# AEC GPGPU RTL 设计竞赛赛题规范

版本：1.0

## 1. 赛题概述

本题要求参赛者设计并实现一个执行 AEC 128-bit 定长指令的 GPGPU 系统，
提交完整、可综合的 RTL 和与其架构行为一致的 CModel。官方使用同一组 AEC
binary、launch 参数和 memory image 分别运行 CModel 与 RTL，并依据独立生成的
expected result 判断正确性。

本题关注三个方面：

1. AEC ISA 的完整、正确实现；
2. 在功能正确基础上的吞吐、频率、功耗和面积优化；
3. 设计、验证和 PPA 结果的可复现性与解释质量。

本题不要求 PTX translator、AEC assembler、CUDA runtime、FPGA bitstream 或
上板验证。官方 testcase 直接提供已经组装完成的 AEC binary。

## 2. 参赛任务

参赛者必须提交：

- 完整 AEC GPGPU RTL；
- AEC functional CModel；
- 构建、运行和回归脚本；
- 设计、验证及 PPA 报告；
- 带完整 Git 历史的仓库压缩包。

AEC ISA 中列出的全部指令均为 required。未实现某条指令时失去对应功能分，
但不因单条高阶指令缺失而使整个提交无效。基础 ABI、控制流和 memory smoke
未通过时，相关 performance/PPA 结果无效。

参赛者可以自由选择 pipeline、warp scheduler、scoreboard、register banking、
cache、coalescing、outstanding request 管理和其他微架构。微架构不得改变附录 A
规定的架构可见行为。

## 3. 交付物

正式提交物为保留 `.git` 历史的仓库压缩包。参赛者可以另外提供可访问的 Git
repository link；发生差异时，以截止时间前提交的压缩包为准。

压缩包格式为 `.tar.gz`，最大 2 GiB。Git LFS 对象必须在压缩包中 materialize；
只包含 pointer file 视为文件缺失。Submodule 必须展开并保留来源说明。压缩包
不得包含 build cache、waveform dump、第三方安装包或与评测无关的大文件。

提交仓库必须采用以下目录：

| 路径 | 内容 |
|---|---|
| `rtl/` | RTL、official top adapter、SystemVerilog testbench |
| `cmodel/` | CModel source、headers、build files |
| `scripts/` | build、run、regression、PPA commands |
| `reports/` | `DESIGN.md`、`VERIFICATION.md`、`PPA.md`、`LIMITATIONS.md` |
| `evidence/` | logs、waveforms、JSON results、synthesis/STA reports |
| `README.md` | 环境、依赖、入口命令和已知限制 |

评测环境默认禁止联网。第三方依赖必须包含在提交包中，或属于官方环境。
Git submodule 必须随压缩包完整展开；不得依赖评测时在线拉取。

## 4. 实现语言

官方 testbench、接口和最终评测输入使用可综合 SystemVerilog。参赛者可以直接
使用 SystemVerilog，也可以使用 Chisel、SpinalHDL、Amaranth 或其他硬件生成
语言，但必须同时提交：

- generator source；
- 依赖版本和 lock file；
- 一键生成命令；
- 生成后的 SystemVerilog；
- 生成结果可复现的说明。

最终 SystemVerilog 必须通过官方 Verilator functional flow 和 Yosys synthesis
flow。不可综合 testbench construct 不得进入 judged RTL hierarchy。

## 5. 架构执行模型

- Warp size 固定为 32 lanes。
- 每 CTA 最多 256 threads，即最多 8 warps。
- 每个 active thread 拥有 256 个 32-bit GPR 和 8 个 predicate。
- PC 是 AEC instruction index，初值为 0。
- Warp 内 active lanes lockstep 执行同一条动态指令。
- Inactive、completed 或 predicate-false lane 不产生架构副作用。
- CTA 在全部启动 warp 完成后结束；kernel 在全部 CTA 完成后结束。

架构 memory spaces：

| Space | 可见范围 | 初始化 | Store |
|---|---|---|---|
| GMEM | grid | harness | allowed |
| SMEM | CTA | launch 清零 | allowed |
| CMEM | grid | harness | forbidden |
| LMEM | thread | launch 清零 | allowed |
| PMEM | kernel launch | harness | forbidden |

SMEM 固定为 65536 bytes/CTA。LMEM 架构容量为 4096 bytes/thread，物理实现允许
映射到 external backing memory。所有架构地址均为对应 space 内的 unsigned
32-bit byte offset。

IMEM、SMEM、CMEM 和 PMEM 使用 synchronous 1-cycle read 语义。GMEM 和 LMEM
使用第 7 节 external memory service。Register file 的内部读写 latency 由参赛者
选择，但不得改变架构行为，所有额外 cycle 均计入 performance。

## 6. Functional RTL interface

官方 testcase 使用统一顶层 `aec_eval_top`。接口分为 reset、program/memory
load、launch、result、GMEM readback 和运行期 external memory service。

```systemverilog
module aec_eval_top (
    input  logic          clk,
    input  logic          rst_n,

    input  logic          load_valid,
    output logic          load_ready,
    input  logic [2:0]    load_target,
    input  logic [31:0]   load_addr,
    input  logic [127:0]  load_data,
    input  logic [15:0]   load_strb,

    input  logic          launch_valid,
    output logic          launch_ready,
    input  logic [31:0]   grid_x,
    input  logic [31:0]   grid_y,
    input  logic [31:0]   grid_z,
    input  logic [31:0]   block_x,
    input  logic [31:0]   block_y,
    input  logic [31:0]   block_z,
    input  logic [31:0]   program_instructions,

    output logic          result_valid,
    input  logic          result_ready,
    output logic [2:0]    result_status,
    output logic [63:0]   result_cycles,

    input  logic          read_valid,
    output logic          read_ready,
    input  logic [31:0]   read_addr,
    output logic          read_data_valid,
    output logic [127:0]  read_data,

    output logic          mem_req_valid,
    input  logic          mem_req_ready,
    output logic          mem_req_write,
    output logic [31:0]   mem_req_addr,
    output logic [1023:0] mem_req_wdata,
    output logic [127:0]  mem_req_wstrb,
    output logic [3:0]    mem_req_tag,

    input  logic          mem_rsp_valid,
    output logic          mem_rsp_ready,
    input  logic [1023:0] mem_rsp_rdata,
    input  logic [3:0]    mem_rsp_tag,
    input  logic          mem_rsp_error
);
endmodule
```

所有 transaction 在 rising edge 的 `valid && ready` 接受，producer 在接受前
保持 payload 稳定。各组信号的功能如下：

- `load_target`：0=IMEM、1=GMEM、2=PMEM、3=CMEM，4--7 reserved；
- IMEM load address 是 instruction index，`load_strb` 必须为 `16'hffff`；
- IMEM `load_data[31:0]`、`[63:32]`、`[95:64]`、`[127:96]` 依次为
  binary 的 `w0`、`w1`、`w2`、`w3`；
- GMEM/PMEM/CMEM load address 是 byte address，`load_strb[i]` 控制
  `load_data[8*i +: 8]`；
- load 在 launch 前完成；launch 提供 grid、block 和合法指令数，PC 合法范围为
  `[0, program_instructions)`；
- `result_status`：0=DONE、1=INVALID、2=EXEC_ERROR，3--7 reserved；
- RTL 不返回 TIMEOUT status；超过 testcase 声明的最大 cycle 数时由 runner 终止并记为
  timeout；
- `result_valid` 必须保持到 `result_ready`；
- readback 在 execution result 后读取 GMEM；`read_addr` 为 16-byte aligned，返回连续
  16 bytes little-endian data；
- program load、input initialization 和 readback 不计入 execution cycles。

Cycle count 从 launch handshake 后第一个 cycle开始，到第一次拉高
`result_valid` 的 cycle结束。执行期间的 pipeline stall、memory latency、barrier
等待和 outstanding store drain 全部计入。

官方 runner 按 reset、load、launch、execution、readback 顺序驱动接口。

## 7. External memory service

GMEM 和 LMEM backing store 由官方 deterministic memory model 提供。运行期
memory transaction 使用 128-byte line：

| 参数 | 固定值 |
|---|---:|
| Line size | 128 bytes |
| Read/write latency | 32 cycles |
| Request bandwidth | 1 request/cycle |
| Response bandwidth | 1 response/cycle |
| Maximum outstanding | 16 |
| Response order | in-order，保留 tag |

请求地址必须 128-byte aligned。写请求的 byte strobe 决定被修改的 bytes；
读请求返回完整 line。每个被接受的请求产生一个带原 tag 的 response，
response 按请求接受顺序返回。

Misaligned 或跨 line 的 ISA access 由 RTL 拆分。Store 在 completion response
时对后续访问可见。`MBAR`、`SYNC.CT`、kernel completion 和 result delivery
必须等待其约束范围内的 store completion。

`mem_rsp_error=1` 表示整个 request 失败，read data 无效且 write 无副作用。
Tag 在对应 response 被接受前不得复用。

该 model 是比赛统一抽象，不代表某种具体 DRAM/HBM。Hidden performance tests
使用相同公开参数。

## 8. CModel 要求

CModel 直接读取官方 AEC binary，接收与 RTL 相同的 launch 参数和
memory image，并输出执行状态及指定 GMEM 区域。CModel 的内部数据结构、
scheduler、执行策略和诊断方式由参赛者选择，其架构可见结果必须符合附录 A。

固定 CLI 为 required，C API 或 Python binding 为 optional。提交必须支持：

```bash
scripts/build.sh
scripts/run_cmodel.sh --case <case.yaml> --output <output-dir>
scripts/run_rtl.sh    --case <case.yaml> --output <output-dir>
scripts/run_tests.sh  --suite public --output <output-dir>
scripts/run_ppa.sh    --output <output-dir>
```

`run_cmodel.sh` 和 `run_rtl.sh` 必须在 output directory 生成结果文件和指定的
GMEM dumps。具体 testcase manifest 与 result schema 随 public testcase package 提供，
public 与 hidden 评测使用同一接口版本。

## 9. Testcase 与评测

官方发布一组参考 testcase、runner 和对应的 manifest/result interface 说明，
用于验证构建、运行、AEC binary 加载、memory 初始化与结果读回流程。
参考 testcase 不代表全部评测覆盖。

Hidden correctness 与 performance tests 使用同一版本的公开接口，只包含本文
定义的合法 ISA 行为、launch 参数和 memory transaction。功能结果按官方
发布的 comparison policy 进行 exact 或浮点容差比较；performance workload 输出
错误、timeout 或返回非 DONE 状态时，该 workload 不产生有效性能指标。

## 10. 评分标准

总分 100 分：

| 大项 | 分值 |
|---|---:|
| 实现正确性 | 50 |
| PPA | 40 |
| 报告 | 10 |

### 10.1 实现正确性：50 分

| 项目 | 分值 |
|---|---:|
| RTL 指令与架构功能 | 40 |
| CModel | 5 |
| RTL/CModel alignment | 5 |

RTL 40 分分配：

| 功能族 | 分值 |
|---|---:|
| ADD--MAX arithmetic | 8 |
| AND--FLO logic/bit | 5 |
| CMP--PICK predicate/select | 4 |
| LD/ST/LDC/ATOM 和 memory spaces | 7 |
| BR/BRX/CALL/RET/HALT/SYNC.CT/MBAR | 6 |
| CVT*/CPY/LOADI/LOADI64 | 4 |
| SHUF/VOTE/MTCH | 2 |
| RCP--SQRT/RDTSC | 4 |

每条指令的分值和 testcase family 在附录 B 给出。功能分按通过的独立
testcase variants 计算；不得仅凭源码中出现对应 opcode 判断完成。

### 10.2 PPA：40 分

| 项目 | 分值 |
|---|---:|
| Performance benchmark | 15 |
| Maximum frequency | 10 |
| Performance per watt | 8 |
| Performance per area | 7 |

Benchmark (i) 的估算实际吞吐为：

$$
T_i = \frac{W_i \times f_{max}}{C_i}
$$

其中 (W_i) 是有效工作量，(C_i) 是 Verilator 测得的 execution cycles，
(f_{max}) 是官方 ASAP7/OpenSTA flow 得到的最高有效频率。不同 benchmark 的
work unit 在 release testcase 说明中定义。

只有输出正确的 performance testcase 才产生有效 throughput。PPA top 必须与
correctness top 使用相同核心 RTL、lane/warp 参数和功能配置。官方允许薄 wrapper
完成 clock、memory macro 和 I/O 适配。

全部提交使用同一套评分参数。评测结果同时报告各 workload 的
cycles、workload、fmax、throughput、power 和 area，使 PPA 指标可复核。

### 10.3 报告：10 分

| 报告内容 | 分值 | 满分条件 |
|---|---:|---|
| 设计说明 | 4 | 架构、pipeline、scheduler、memory、SRAM、关键状态机和取舍完整 |
| 验证说明 | 3 | CModel/RTL/testcase/coverage、失败定位和 alignment 证据可复现 |
| PPA、限制与合规 | 3 | 原始报告、指标解释、已知限制、第三方及生成工具声明完整 |

缺少原始 evidence 的 claim 不计入报告评分。报告评分不因排版风格、篇幅或是否
使用特定绘图工具而单独加减分。

## 11. SRAM 与 PPA memory 口径

比赛使用 commit `522eeccbccefcd66e61893fa1059df24d95e9f86` 的
`The-OpenROAD-Project/asap7_sram_0p0`。官方提供锁定的 behavioral Verilog、
Liberty、LEF 路径与 SHA256，以及可选 wrapper。参赛者可直接实例化表中
native cell，也可使用 wrapper；两种方式的 PPA 口径相同。

官方提供且 PPA flow 认可的 macro 仅包括：

| Optional wrapper | ASAP7 native cell | Organization |
|---|---|---:|
| `aec_sram_256x32` | `srambank_64x4x32_6t122` | 256x32 |
| `aec_sram_512x32` | `srambank_128x4x32_6t122` | 512x32 |
| `aec_sram_1024x32` | `srambank_256x4x32_6t122` | 1024x32 |
| `aec_sram_256x64` | `srambank_64x4x64_6t122` | 256x64 |

这些 macro 均为 synchronous single read/write port，read latency 1 cycle；同一
cycle 不允许同时 read 和 write。参赛者不得实例化表外 SRAM macro。更大、
多 bank 或多 port memory 必须由表中 macro 组合，或使用 standard cells 实现。

计入 core PPA：GPR、predicate storage、IMEM、SMEM、DUT-resident CMEM/PMEM、
cache、queue、buffer 和参赛者增加的片上结构。官方 testbench 中的 GMEM、
CMEM/PMEM host backing arrays、LMEM backing store 及其他 testbench storage
不计入 core PPA。DUT 为 CMEM/PMEM 建立的副本、cache 或 buffer 仍计入。

SRAM 面积按锁定 LEF 的 `SIZE` 计入，timing 和 internal power 按对应
Liberty 计入。原始 Liberty 的 cell `area` 为 0，不用于 SRAM 面积计算。
ASAP7 SRAM collateral 中的 `cell_leakage_power` 为 0，因此 SRAM leakage 在本题统一记为 0；standard
cell leakage 按其 Liberty 计入。所有结果是比赛环境下的 estimated PPA，不代表
流片实测。

## 12. Frequency 与 PPA flow

官方使用 Yosys 和 ASAP7 7.5-track RVT TT NLDM v28 对 judged RTL 综合一次，
并使用 OpenSTA 在 0.7 V、25 C、TT 条件下分析同一 mapped netlist。官方
提供评测使用的综合脚本、SDC 和 library 配置。

Maximum frequency 取满足官方 timing checks 的最高时钟频率。Area 为 mapped
standard-cell area 与官方 SRAM macro area 之和。Power 由 performance workload
产生的 activity 和官方 Liberty 估算，包含 standard-cell switching、internal、
leakage 以及 SRAM internal power。

Synthesis error、combinational loop、multiple driver 或无法完整约束的 timing path 会使
相关 PPA 指标无效。所有提交使用同一套官方 flow、corner 和评测参数。

Workload 定义：

| Workload | Work (W_i) | Reported unit |
|---|---:|---|
| GEMM MxNxK | `2*M*N*K` | GOP/s |
| Copy/transpose | completed read bytes + write bytes | GB/s |
| VADD | completed elements | Gelement/s |
| SAXPY | `3*N` FP operations | GFLOP/s |
| Reduction | input elements | Gelement/s |
| Histogram | completed atomic updates | Gupdate/s |

Performance/W 使用有效 throughput 除以对应 workload 的估算功耗；
performance/area 使用 composite throughput 除以同一 mapped design 的总面积。
所有提交使用相同的 benchmark 输入、activity 采样和时序分析参数。

## 13. 开发与评测环境

官方环境和最低兼容基线：

| Tool | Baseline |
|---|---|
| Verilator | 5.049 devel，`v5.048-179-gc878a7e73`；最低为该 revision |
| Yosys | 0.64+308，commit `78e05dfb0`；最低为该 revision |
| OpenSTA | `v2.2.0-2121-g66c29303`，commit `66c29303` |
| GCC/G++ | 13.3.0；最低 13.3.0 |
| Python | 3.12.3；最低 3.12.3 |
| ASAP7 | PDK 1.7，7.5-track v28，RVT TT NLDM |
| ASAP7 SRAM | `asap7_sram_0p0` |

下载地址：

- Verilator: <https://github.com/verilator/verilator>
- Yosys: <https://github.com/YosysHQ/yosys>
- OpenSTA: <https://github.com/The-OpenROAD-Project/OpenSTA>
- ASAP7 PDK/cells/SRAM: <https://github.com/The-OpenROAD-Project/asap7>

参赛者可以使用更高兼容版本开发，正式评分使用表中环境及锁定的
library 文件。

## 14. 禁止事项

- 根据 testcase ID、filename、input hash 或固定数据直接生成答案；
- 绕过 RTL/CModel 的 result script；
- correctness 和 PPA 使用功能配置不同的核心；
- 修改官方 SRAM timing/area/power model；
- 隐瞒 vendor IP、第三方 RTL、blackbox 或生成代码来源；
- 提交不可复现的 generated RTL；
- 依赖评测时联网下载；
- 使用未声明的 unsynthesizable construct 进入 judged hierarchy。

## 15. 附录 A：AEC Precise ISA Specification

本附录规定 AEC 架构状态、binary encoding 和逐指令行为。

### A.1 Opcode encoding

| Mnemonic | Opcode | Mnemonic | Opcode |
|---|---:|---|---:|
| `ADD` | `0x0001` | `SUB` | `0x0002` |
| `MUL` | `0x0003` | `MAD` | `0x0004` |
| `FMA` | `0x0005` | `DIV` | `0x0006` |
| `NEG` | `0x0007` | `ABS` | `0x0008` |
| `MIN` | `0x0009` | `MAX` | `0x000a` |
| `AND` | `0x0010` | `OR` | `0x0011` |
| `XOR` | `0x0012` | `NOT` | `0x0013` |
| `SHL` | `0x0014` | `SHR` | `0x0015` |
| `BFX` | `0x0016` | `BINS` | `0x0017` |
| `POPC` | `0x0018` | `FLO` | `0x0019` |
| `CMP` | `0x0020` | `CMPP` | `0x0021` |
| `SEL` | `0x0022` | `PICK` | `0x0023` |
| `LD` | `0x0030` | `ST` | `0x0031` |
| `LDC` | `0x0032` | `ATOM` | `0x0033` |
| `BR` | `0x0040` | `BRX` | `0x0041` |
| `CALL` | `0x0043` | `RET` | `0x0044` |
| `HALT` | `0x0045` | `SYNC.CT` | `0x0047` |
| `MBAR` | `0x0049` | `CVTFF` | `0x0050` |
| `CVTFI` | `0x0051` | `CVTIF` | `0x0052` |
| `CVTII` | `0x0053` | `CPY` | `0x0054` |
| `LOADI` | `0x0055` | `LOADI64` | `0x0056` |
| `SHUF` | `0x0057` | `VOTE` | `0x0058` |
| `MTCH` | `0x0059` | `RCP` | `0x0070` |
| `RSQ` | `0x0071` | `SIN` | `0x0072` |
| `COS` | `0x0073` | `EXP` | `0x0074` |
| `LOG` | `0x0075` | `SQRT` | `0x0076` |
| `RDTSC` | `0x0080` |  |  |

### A.2 架构与指令规范

#### 1.1 关键架构规则

| 项目 | 规则 |
|---|---|
| `HALT` | 由当前 active lanes uniform 执行，并完成当前 warp。 |
| non-uniform control | `BRX/CALL/RET/HALT/SYNC.CT` 的非 uniform 使用是 execution error。 |
| `SEL` predicate 字段 | `Pred/Ctrl[2:0]` 是选择 predicate；`SEL` 不允许额外 instruction guard。 |
| `LDC` address form | `LDC.type Rd,[Ra]` 等价于 `LD.cmem.type Rd,[Ra]`。 |
| collective predication | `SHUF/VOTE/MTCH/SYNC.CT` 不允许 instruction guard。 |
| initial state | GPR/P 都为 0；`.smem/.lmem` 每次 launch 清零。 |
| partial warp | 仅有效 thread 对应 lane active。 |
| misaligned LD/ST | 合法，按连续 byte little-endian 完成。 |
| out-of-bounds | 当前指令无副作用并产生 execution error。 |
| ordinary data race | 结果未定义，禁止进入 correctness testcase。 |
| cross-warp atomic order | 可串行化但顺序未指定；测试只比较顺序无关结果。 |
| `RDTSC` | 只保证同一 warp 同值、单调并按 $2^{32}$ wrap；不做 exact CModel/RTL 比较。 |

#### 1.2 微架构自由度

Pipeline latency、issue width、scheduler 策略、cache、coalescing、register banking、NoC
和 HBM 映射由参赛者设计，不得改变正确程序的架构可见结果。

### 2. 架构状态与 launch

#### 2.1 Thread、warp 与 CTA

- Warp size 固定为 32 lanes。
- 每个 CTA 最多 256 threads，即最多 8 warps。
- `.smem` 容量固定为每 CTA 65536 bytes。
- `.lmem` 容量固定为每 thread 4096 bytes；每个 thread 使用独立、0-based
  地址空间，kernel launch 时清零，不允许 host 初始化或 readback。
- `blockDim.x * blockDim.y * blockDim.z` 必须在 `1..256`。
- Thread linear ID：

$$
t = tid.x + ntid.x\times(tid.y + ntid.y\times tid.z).
$$

- `warp_id_in_cta = floor(t / 32)`，`lane_id = t mod 32`。
- 最后一个 partial warp 中，只有 $t < blockDim.x\,blockDim.y\,blockDim.z$ 的 lanes active。
- CTA 的物理调度和不同 CTA 的执行顺序由实现决定。

#### 2.2 Per-thread state

- 256 个 32-bit GPR：`R0..R255`。
- 8 个 predicate：`P0..P7`。
- Kernel launch 时所有 GPR 清零，所有 predicate 为 false。
- Inactive 或 completed lane 不执行指令，不产生 register、predicate、memory、atomic 或 barrier side effect。

#### 2.3 Per-warp state

- PC 是 32-bit AEC instruction index，初值为 0。
- Active mask 来自 launch；本文不支持运行时 SIMT reconvergence stack。
- Call stack 为 per-warp，最多保存 32 个 return PC。
- Warp 在 uniform `HALT` 后进入 completed 状态。
- CTA 在所有启动 warp completed 后完成；kernel 在所有 CTA 完成后完成。

#### 2.4 Special registers

| Selector | Register | 返回值 |
|---:|---|---|
| `0x0100` | `%tid.x` / `%tid` | 当前 thread 的 x coordinate。 |
| `0x0101` | `%ntid.x` / `%ntid` | `blockDim.x`。 |
| `0x0102` | `%ctaid.x` / `%ctaid` | 当前 CTA 的 x coordinate。 |
| `0x0103` | `%nctaid.x` / `%nctaid` | `gridDim.x`。 |
| `0x0104` | `%laneid` | `lane_id`。 |
| `0x0110..0x0113` | `%tid.y/%ntid.y/%ctaid.y/%nctaid.y` | 对应 y coordinate/dimension。 |
| `0x0120..0x0123` | `%tid.z/%ntid.z/%ctaid.z/%nctaid.z` | 对应 z coordinate/dimension。 |

所有返回值是 `.u32`。

### 3. Binary 与通用字段

#### 3.1 128-bit layout

| Bits | Field | 规则 |
|---:|---|---|
| `[127:112]` | Opcode | 16-bit opcode。 |
| `[111:96]` | Pred/Ctrl | type、subop、space、scope 和 predicate。 |
| `[95:80]` | Dest | GPR、predicate 或 0。 |
| `[79:64]` | Src1 | GPR、address GPR、source predicate 或 special selector。 |
| `[63:32]` | Src2/Imm32 | source GPR、packed registers 或 immediate。 |
| `[31:0]` | ImmExt | branch target、third source、mask 或 immediate。 |

Text hex 按 MSB-first 输出。Raw binary 依次保存 `w0,w1,w2,w3`，每个 word 是 little-endian u32：

```text
w0 = bits [31:0]
w1 = bits [63:32]
w2 = bits [95:64]
w3 = bits [127:96]
```

#### 3.2 `Pred/Ctrl`

| Bits | Common meaning |
|---:|---|
| `[2:0]` | instruction predicate index。 |
| `[6:3]` | data type。 |
| `[7]` | reserved，必须为 0。 |
| `[10:8]` | instruction-family subop。 |
| `[13:11]` | memory space、scope 或 family extension。 |
| `[14]` | `pred_neg`。 |
| `[15]` | `pred_en`。 |

普通可谓词执行指令的 lane 执行条件：

```text
execute_lane = active_lane &&
               (!pred_en || (P[pred] XOR pred_neg))
```

Predicate-false lane 保持所有 destination 和 memory 不变。

#### 3.3 字段合法性

- GPR operand 使用 16-bit field 的低 8 bits，高 8 bits 必须为 0。
- Predicate operand 使用低 3 bits，其余 bits 必须为 0。
- 所有没有在逐指令定义中使用的字段和 bit 必须为 0。
- `R0` 是普通可写寄存器，不是硬连线零。
- 64-bit pair 以 `Rd` 表示 `{R[d+1], R[d]}`，低 32 bits 在 `R[d]`。
- Pair base 可以是奇数，只要求 `0 <= d <= 254`。
- 每条指令先从该 lane 的 pre-instruction state 读取全部 source，再提交 destination；因此 `Rd==Rs1/Rs2/Rs3` 合法。Pair source/destination overlap 也遵循同一规则。
- 非法字段在指令产生 side effect 前报告 illegal instruction。
- `pred_en=0` 时 `pred_neg` 必须为 0；除 `SEL` 把 `[2:0]` 用作选择
  predicate 外，未启用 guard 的指令必须使 `pred=0`。

### 4. Type 与数据表示

| Code | Type | Register representation |
|---:|---|---|
| `0x0` | `.b32` | 32-bit bit pattern。 |
| `0x1` | `.b64` | register pair。 |
| `0x2` | `.u32` | 32-bit unsigned integer。 |
| `0x3` | `.s32` | two's-complement signed integer。 |
| `0x4` | `.u8` | 有效值在低 8 bits，destination 高 24 bits 为 0。 |
| `0x5` | `.s8` | 有效值在低 8 bits，destination sign-extend 到 32 bits。 |
| `0x6..0x7` | reserved | illegal。 |
| `0x8` | `.f32` | IEEE 754 binary32 bits。 |
| `0x9` | `.f64` | IEEE 754 binary64 register pair。 |
| `0xa` | `.f16` | IEEE 754 binary16 在低 16 bits，高 16 bits 为 0。 |
| `0xb` | `.bf16` | bfloat16 在低 16 bits，高 16 bits 为 0。 |
| `0xc..0xe` | reserved | illegal。 |
| `0xf` | `.none` | untyped/control/system form。 |

#### 4.1 Legal type matrix

| Family/op | Legal types |
|---|---|
| `ADD/SUB/MUL` | `.u32/.s32/.f32/.f16/.bf16/.f64` |
| `MAD` | `.u32/.s32/.f32` |
| `FMA` | `.f32/.f16/.bf16/.f64` |
| `DIV` | `.u32/.s32/.f32/.f64` |
| `NEG/ABS` | `.s32/.f32/.f16/.bf16/.f64` |
| `MIN/MAX` | `.u32/.s32/.f32` |
| `AND/OR/XOR/NOT` | `.b32/.u32`; omitted suffix means `.b32` |
| `SHL/SHR/BFX` | `.u32/.s32` |
| `BINS/POPC/FLO` | `.b32/.u32` |
| `CMP/CMPP` | `.u32/.s32/.f32` |
| `SEL/PICK` | `.u32/.s32/.f32` |
| `LD` | `.b32/.b64/.u32/.s32/.f32` |
| `ST` | `.b32/.u32/.s32/.f32` |
| `LDC` | `.b32/.u32/.f32` |
| `ATOM` | `.u32/.s32` |
| `SHUF` | `.u32/.s32/.f32` |
| `RCP/RSQ/SIN/COS/EXP/LOG/SQRT` | `.f32` only |
| `CPY` register form | `.b32/.b64/.u32/.s32/.u8/.s8/.f32/.f64/.f16/.bf16` |
| `CPY` special-register form | `.u32` only |
| `LOADI/LOADI64/RDTSC/BR/BRX/CALL/RET/HALT/SYNC.CT/MBAR` | `.none`；`RDTSC` destination 是 32-bit bit pattern |

未列出的 opcode/type 组合是 illegal instruction。

### 5. Operand placement

#### 5.1 Common forms

| Form | Fields |
|---|---|
| `OP Rd, Rs1, Rs2` | `Dest=Rd`, `Src1=Rs1`, `Src2[15:0]=Rs2`。 |
| `OP Rd, Rs` | `Dest=Rd`, `Src1=Rs`。 |
| `OP Rd, Rs1, Rs2, Rs3` | `Dest=Rd`, `Src1=Rs1`, `Src2[15:0]=Rs2`, `ImmExt[15:0]=Rs3`。 |
| `LOADI Rd, imm32` | `Dest=Rd`, `ImmExt=imm32`。 |
| `LOADI64 Rd, imm64` | `Dest=Rd`, `Src2=imm64[63:32]`, `ImmExt=imm64[31:0]`。 |

#### 5.2 Special forms

| Instruction | Fields |
|---|---|
| `BFX Rd, Rs, lsb, width` | `Dest=Rd`, `Src1=Rs`, `Src2[7:0]=lsb`, `Src2[15:8]=width`。 |
| `BINS Rd, base, insert, lsb, width` | `Dest=Rd`, `Src1=base`, `Src2[15:0]=insert`, `ImmExt[7:0]=lsb`, `ImmExt[15:8]=width`。 |
| `CMP/CMPP Rd/Pd, Rs1, Rs2` | Common 3-register form；compare subop in `Pred/Ctrl[10:8]`。 |
| `SEL Rd, Rs1, Rs2, Pn` | Common 3-register data fields；`Pred/Ctrl[2:0]=Pn`，`pred_en=0`。 |
| `LD Rd, [Ra]` | `Dest=Rd`, `Src1=Ra`。 |
| `ST [Ra], Rs` | `Dest=0`, `Src1=Ra`, `Src2[15:0]=Rs`。 |
| `LDC Rd, [Ra]` | `Dest=Rd`, `Src1=Ra`；等价访问 `.cmem`。 |
| `ATOM op Rd, [Ra], Rs` | `Dest=old`, `Src1=Ra`, `Src2[15:0]=Rs`。 |
| `ATOM.cas Rd, [Ra], Rcmp, Rupdate` | `Dest=old`, `Src1=Ra`, `Src2[31:16]=Rcmp`, `Src2[15:0]=Rupdate`。 |
| `BR/BRX/CALL label` | `ImmExt=target_pc`。 |
| `CVT*.dst.src Rd, Rs` | `Dest=Rd`, `Src1=Rs`, dst type `[6:3]`, src type `[13:10]`。 |
| `CPY Rd, Rs/%special` | `Dest=Rd`, `Src1=register or special selector`。 |
| `SHUF.mode.type Rd, Rs, val, mask` | `Dest=Rd`, `Src1=Rs`, `Src2[4:0]=val`, `ImmExt=32-bit participation mask`。 |
| `VOTE.mode Rd/Pd, Pn` | `Dest=Rd/Pd`, `Src1[2:0]=Pn`, destination kind in `Pred/Ctrl[11]`。 |
| `MTCH.any Rd, Rs` | `Dest=Rd`, `Src1=Rs`。 |

Move/system 的值规则：

- `LOADI` 把 immediate 的低 32 bits 原样写入 `Rd`。
- `LOADI64` 把低 32 bits 写 `R[d]`，高 32 bits 写 `R[d+1]`。
- `CPY.b32/u32/s32/f32` 复制一个完整 32-bit GPR。
- `CPY.b64/f64` 复制 source pair 到 destination pair。
- `CPY.u8/f16/bf16` 复制有效低位并把 destination 高位清零；`CPY.s8` 对低 8 bits sign-extend。
- `CPY.u32 Rd,%special` 写第 2.4 节定义的 32-bit special-register value。

#### 5.3 Family-specific `Pred/Ctrl`

| Family | Special interpretation |
|---|---|
| `CMP/CMPP` | `[10:8]`: `eq=0, ne=1, lt=2, le=3, gt=4, ge=5`。 |
| `LD/ST/LDC` | `[13:11]`: memory space。`LDC` 必须为 `.cmem` code 2。 |
| `ATOM` | `[10:8]`: op；`[13:11]`: memory space。 |
| `MBAR` | `[13:11]`: `CT=0, SYS=2`。 |
| `CVT*` | `[13:10]`: source type；`[6:3]`: destination type；`[9:7]=0`。 |
| `SHUF` | `[10:8]`: `idx=0, up=1, down=2, bfly=3`。 |
| `VOTE` | `[10:8]`: `all=0, any=1, uni=2`；bit 11: `GPR=0, predicate=1`。 |
| `RCP/RSQ/SQRT` | `[10:8]`: `approx=0, full=1`。 |
| `SIN/COS/EXP/LOG` | `[10:8]=0`。 |

### 5.4 Canonical encoding matrix

本节把第 4 节 legal type、第 5.1--5.3 节字段规则合并为逐 opcode 的合法编码入口。表中的 `G` 表示允许通用 predicate guard，`N` 表示 `pred_en=pred_neg=pred=0`，`R` 表示 `BRX` 必须编码条件 predicate。`r` 是低 8-bit GPR index，`p` 是低 3-bit predicate index，`pair` 是 `0..254` 的 GPR pair base。除表中明确使用的字段和 immediate bits 外，所有 payload bits、`Pred/Ctrl` reserved bits 及 family 未使用的 subop/extension bits 均为 MBZ（must be zero）。

| Opcode | Type | Guard | `Pred/Ctrl` special value | Canonical payload |
|---|---|:---:|---|---|
| `ADD` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `SUB` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `MUL` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `MAD` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r, ImmExt[15:0]=r` |
| `FMA` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r/pair, Src1=r/pair, Src2[15:0]=r/pair, ImmExt[15:0]=r/pair` |
| `DIV` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r/pair, Src1=r/pair, Src2[15:0]=r/pair` |
| `NEG` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r/pair, Src1=r/pair` |
| `ABS` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r/pair, Src1=r/pair` |
| `MIN` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `MAX` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `AND` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `OR` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `XOR` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `NOT` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r` |
| `SHL` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `SHR` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `BFX` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[7:0]=lsb, Src2[15:8]=width` |
| `BINS` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r, ImmExt[7:0]=lsb, ImmExt[15:8]=width` |
| `POPC` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r` |
| `FLO` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r` |
| `CMP` | `legal matrix` | G | `subop=compare 0..5, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `CMPP` | `legal matrix` | G | `subop=compare 0..5, ext=0` | `Dest=p, Src1=r, Src2[15:0]=r` |
| `SEL` | `legal matrix` | N | `[2:0]=select p, subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `PICK` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r, Src1=r, Src2[15:0]=r` |
| `LD` | `legal matrix` | G | `subop=0, ext=space 0..4` | `Dest=r/pair, Src1=address r` |
| `ST` | `legal matrix` | G | `subop=0, ext=space 0/1/3` | `Dest=0, Src1=address r, Src2[15:0]=data r` |
| `LDC` | `legal matrix` | G | `subop=0, ext=2` | `Dest=r, Src1=address r` |
| `ATOM` | `legal matrix` | G | `subop=atomic 0..7, ext=space 0/1` | `non-CAS: Dest=r, Src1=address r, Src2[15:0]=update r; CAS adds Src2[31:16]=compare r` |
| `BR` | `.none` | N | `subop=0, ext=0` | `ImmExt=target_pc` |
| `BRX` | `.none` | R | `[2:0]=condition p, subop=0, ext=0` | `ImmExt=target_pc` |
| `CALL` | `.none` | N | `subop=0, ext=0` | `ImmExt=target_pc` |
| `RET` | `.none` | N | `subop=0, ext=0` | `no payload` |
| `HALT` | `.none` | N | `subop=0, ext=0` | `no payload` |
| `SYNC.CT` | `.none` | N | `subop=0, ext=0` | `no payload` |
| `MBAR` | `.none` | N | `subop=0, ext=scope 0/2` | `no payload` |
| `CVTFF` | `conversion matrix` | G | `dst=[6:3], src=[13:10], [9:7]=0` | `Dest=r/pair, Src1=r/pair` |
| `CVTFI` | `conversion matrix` | G | `dst=[6:3], src=[13:10], [9:7]=0` | `Dest=r, Src1=r/pair` |
| `CVTIF` | `conversion matrix` | G | `dst=[6:3], src=[13:10], [9:7]=0` | `Dest=r/pair, Src1=r` |
| `CVTII` | `conversion matrix` | G | `dst=[6:3], src=[13:10], [9:7]=0` | `Dest=r, Src1=r` |
| `CPY` | `legal matrix` | G | `subop=0, ext=0` | `Dest=r/pair, Src1=r/pair or listed special selector` |
| `LOADI` | `.none` | G | `subop=0, ext=0` | `Dest=r, ImmExt=imm32` |
| `LOADI64` | `.none` | G | `subop=0, ext=0` | `Dest=pair, Src2=imm64[63:32], ImmExt=imm64[31:0]` |
| `SHUF` | `legal matrix` | N | `subop=mode 0..3, ext=0` | `Dest=r, Src1=r, Src2[4:0]=val, ImmExt=participation_mask` |
| `VOTE` | `.none` | N | `subop=mode 0..2, bit11=dest_kind, bits13:12=0` | `Dest=r/p by kind, Src1=p` |
| `MTCH` | `.none` | N | `subop=0 (.any), ext=0` | `Dest=r, Src1=r` |
| `RCP` | `.f32` | G | `subop=mode 0/1, ext=0` | `Dest=r, Src1=r` |
| `RSQ` | `.f32` | G | `subop=mode 0/1, ext=0` | `Dest=r, Src1=r` |
| `SIN` | `.f32` | G | `subop=0, ext=0` | `Dest=r, Src1=r` |
| `COS` | `.f32` | G | `subop=0, ext=0` | `Dest=r, Src1=r` |
| `EXP` | `.f32` | G | `subop=0, ext=0` | `Dest=r, Src1=r` |
| `LOG` | `.f32` | G | `subop=0, ext=0` | `Dest=r, Src1=r` |
| `SQRT` | `.f32` | G | `subop=mode 0/1, ext=0` | `Dest=r, Src1=r` |
| `RDTSC` | `.none` | G | `subop=0, ext=0` | `Dest=r` |

对于 `.f64/.b64`，表中相应的 `r` 必须按 legal type matrix 解释为 `pair`。`BR/BRX/CALL` 的 `target_pc` 必须位于 `[0, program_instructions)`。`BFX/BINS` 字段可以编码任意 8-bit `lsb/width`，超出第 6.2 节运行范围的值产生 execution error；它们不是静态 illegal encoding。


### 6. Integer、logical 与 compare 语义

#### 6.1 Integer arithmetic

- `u32/s32 ADD/SUB/MUL/MAD` 的结果是精确数学结果 modulo $2^{32}$。
- `.s32` 只改变比较、右移、除法和 MIN/MAX 的解释；bit pattern 相同。
- `DIV.u32` 是 unsigned quotient。
- `DIV.s32` 向 0 截断。
- 除数为 0 时产生 execution error，destination 保持不变。
- `INT_MIN / -1` 产生 `0x80000000`。
- `NEG.s32(INT_MIN)` 和 `ABS.s32(INT_MIN)` 都产生 `0x80000000`。
- `SHL/SHR` 使用 `Rs2[4:0]` 作为 shift amount。
- `SHR.u32` 补 0；`SHR.s32` 复制 sign bit。

#### 6.2 Bit-field

- `BFX` 合法条件：`0 <= lsb <= 31`、`0 <= width <= 32`、`lsb+width <= 32`。
- `width=0` 时结果为 0。
- `BFX.u32` zero-extends；`BFX.s32` 从抽取字段的最高位 sign-extends。
- `BINS` 使用同样的 range 条件；`width=0` 时结果等于 `base`。
- 非法 range 产生 execution error，destination 保持不变。
- `POPC` 返回 32-bit 输入中的 1-bit 数量。
- `FLO` 返回最高 set bit 的 index `0..31`；输入 0 返回 `0xffffffff`。

#### 6.3 Compare/select

- Integer compare 按 type 选择 signed 或 unsigned。
- `CMP` 写 32-bit `0` 或 `1`。
- `CMPP` 写 false 或 true。
- `SEL` 根据 `Pn` 复制 `Rs1` 或 `Rs2` 的 bit pattern。
- `PICK` 检查 `Rs1[31]`；为 1 时复制 `Rs2`，否则复制 `Rs1`。type 只规定输出表示。

### 7. Floating-point 与 conversion

#### 7.1 Common FP policy

- FP arithmetic 使用 round-to-nearest, ties-to-even。
- Subnormal 被保留；FTZ=false，DAZ=false。
- Reference CModel 启动时必须设置 `FE_TONEAREST`，并禁止 `fast-math`、
  `finite-math-only`、忽略 signed zero 等会改变 IEEE 语义的编译选项。基础
  arithmetic/conversion 要求 bit-exact；SFU normal finite result 按本文容差
  比较。
- f16/bf16 source 只读取 GPR 低 16 bits；u8/s8 source 只读取低 8 bits。运算或 conversion 写窄 destination 时按第 4 节生成确定的高位。
- f64 source/destination 使用 register pair；涉及的每个 pair base 都必须小于等于 254。
- `FMA` 是无限精度乘加后一次舍入到 destination type。
- `MAD` 先把乘法舍入到 destination type，再执行并舍入加法。
- 任何 NaN 输入产生 canonical quiet NaN：
  - f16 `0x7e00`
  - bf16 `0x7fc0`
  - f32 `0x7fc00000`
  - f64 `0x7ff8000000000000`
- FP compare：NaN 参与时 `.ne=true`，其余 compare false。
- `MIN/MAX` 仅支持 f32：一个 operand 是 NaN 时返回另一个 numeric operand；两个都是 NaN 时返回 canonical NaN；`MIN(+0,-0)=-0`，`MAX(+0,-0)=+0`。

#### 7.2 Conversion legal matrix

| Opcode | Destination | Source |
|---|---|---|
| `CVTFF` | `f16/bf16/f32/f64` | `f16/bf16/f32/f64` |
| `CVTFI` | `u8/s8/u32/s32` | `f16/bf16/f32/f64` |
| `CVTIF` | `f16/bf16/f32/f64` | `u8/s8/u32/s32` |
| `CVTII` | `u8/s8/u32/s32` | `u8/s8/u32/s32` |

Conversion 使用以下固定规则：

- FP-to-FP 和 int-to-FP 使用 round-to-nearest, ties-to-even。
- FP-to-int 先向 0 截断，再 clamp 到 destination type range。
- NaN 转 integer 得 0。
- `+Inf/-Inf` 分别 clamp 到 destination maximum/minimum；unsigned minimum 为 0。
- Integer narrowing 取 low destination-width bits，再按 destination signedness zero/sign-extend 到 GPR。
- `CVTII` widening 按 source signedness解释，再按 destination representation 写回。

### 8. Memory model

#### 8.1 Spaces

| Space | Visibility | Initialization | Store |
|---|---|---|---|
| `.gmem` | 整个 grid | harness 提供 | allowed |
| `.smem` | 当前 CTA | 每个 CTA launch 清零 | allowed |
| `.cmem` | 整个 grid read-only | harness 提供 | illegal |
| `.lmem` | 当前 thread | 每个 thread launch 清零 | allowed |
| `.pmem` | 当前 kernel launch read-only | harness 提供 | illegal |

GMEM、CMEM 和 PMEM 的 testcase byte size 由 manifest artifacts 决定；SMEM 和
LMEM 使用正文第 5 节固定容量。AEC address register 是该 space 内的 unsigned
32-bit byte offset。

#### 8.2 Access widths

| Type | Bytes | Load destination |
|---|---:|---|
| `.b32/.u32/.s32/.f32` | 4 | 一个 GPR，bit-exact。 |
| `.b64` | 8 | `{R[d+1],R[d]}`。 |

- Multi-byte value 使用 little-endian。
- 普通 LD/ST 允许 misaligned address，也允许跨自然 word boundary。
- 访问的每个 byte 都必须在目标 space 内；否则整条指令 execution error，且无 destination/memory side effect。
- `.b64` load 要求 `d<=254`。
- `LDC.type Rd,[Ra]` 等价于 `LD.cmem.type Rd,[Ra]`。

#### 8.3 Ordering and races

- 单个 warp 的指令按 program order 产生架构 side effect。
- `SYNC.CT` 对当前 CTA 的 `.smem` 和 `.gmem` 提供 release/acquire visibility，并等待所有 required warp。
- `MBAR.CT` 保证当前 warp 在 barrier 前的 memory accesses 先于 barrier 后的 accesses 对当前 CTA 可见。
- `MBAR.SYS` 对 `.gmem` 提供同样的 system-scope ordering。
- `MBAR` 不等待其他 warp。
- 没有 atomic/synchronization 的跨 lane/warp 冲突是 data race；结果未定义，禁止作为 correctness testcase。

#### 8.4 Atomics

- Atomic address 必须 4-byte aligned 且 4 bytes 完全位于 `.gmem` 或 `.smem`。
- `ADD` modulo $2^{32}$。
- `MIN/MAX` 按 `.u32/.s32` 解释。
- `XCHG/AND/OR/XOR` 处理 32-bit bit pattern。
- `CAS`：若 old value 等于 `Rcmp`，写 `Rupdate`；始终把 old value 写到 `Rd`。
- 同一 warp 内按 ascending lane ID 串行化。
- 不同 warp/CTA 间保证每次 atomic 可串行化，但串行顺序未指定。
- Predicated-false lane 不参与 atomic order。

### 9. Control、barrier 与 collective

#### 9.1 Control flow

- `BR`：`PC=target`。
- `BRX`：所有 active lanes 的 branch condition 必须一致；全 true 时 `PC=target`，全 false 时 `PC=PC+1`，mixed 时 execution error。
- `CALL`：push `PC+1` 后 `PC=target`。
- `RET`：pop return PC。空 stack 是 execution error。
- 第 32 次 push 合法；第 33 次 push 是 execution error。
- `BR/CALL/RET/HALT/SYNC.CT/MBAR/SHUF/VOTE/MTCH` 不允许 generic instruction predicate；条件分支只使用 `BRX`。
- `HALT` 完成当前 warp。它必须由当前 active lanes uniform 执行。

#### 9.2 `SYNC.CT`

- `SYNC.CT` 不允许 predicate guard。
- 第一个 warp 到达某一 generation 时，required set 固定为当时 CTA 中所有尚未 completed 的启动 warp。
- 每个 required warp 每个 barrier generation 到达一次。
- 所有 required warp 到达后一起从 `PC+1` 继续。
- 已 completed warp 不参与后续 generation。
- 已进入 required set 的 warp 若未到达 barrier 就完成或永久绕过 barrier，该 generation 不释放，runner 最终报告 timeout/deadlock。
- 一个 warp 在同一 generation 重复到达是 execution error。

#### 9.3 Warp primitives

`SHUF/VOTE/MTCH` 不允许 generic instruction predicate。它们采样指令开始时的 active mask。

##### SHUF

- Participating mask = `active_mask & ImmExt`。
- 不在 participating mask 的 destination lane 保持 `Rd` 不变。
- `.idx`: `src_lane = val`。
- `.up`: `src_lane = lane_id - val`。
- `.down`: `src_lane = lane_id + val`。
- `.bfly`: `src_lane = lane_id XOR val`。
- 如果 `src_lane` 不在 `0..31` 或不在 participating mask，destination lane 复制自身的 `Rs`。
- 否则 destination lane 复制 source lane 的 `Rs` bit pattern。

##### VOTE

- Source predicate index 在 `Src1[2:0]`。
- Participant set 是 active lanes。
- `.all`：所有 participant source predicate 为 true。
- `.any`：至少一个为 true。
- `.uni`：所有 participant 的 source predicate 相同。
- Empty set 定义为 `.all=true/.any=false/.uni=true`。
- GPR destination 写 0 或 1；predicate destination 写 false 或 true。

##### MTCH

- 每个 active destination lane 获得一个 32-bit mask。
- Bit `i` 为 1 当且仅当 lane `i` active 且其 `Rs` 32-bit bit pattern 等于 destination lane 的 `Rs`。

### 10. SFU 与 system

#### 10.1 SFU functions

| Instruction | Function |
|---|---|
| `RCP` | $1/x$ |
| `RSQ` | $1/\sqrt{x}$ |
| `SIN` | $\sin(x)$，输入单位 radians |
| `COS` | $\cos(x)$，输入单位 radians |
| `EXP` | $2^x$ |
| `LOG` | $\log_2(x)$ |
| `SQRT` | $\sqrt{x}$ |

- `.approx` normal finite result：relative error `<= 2^-12`；当 reference result 为 0 时 absolute error `<= 2^-24`。
- `.full`、`SIN/COS/EXP/LOG` normal finite result：`<= 4 ULP`。
- NaN 输入、负数 `SQRT/RSQ`、负数 `LOG` 产生 canonical qNaN。
- `SIN/COS(±Inf)` 产生 canonical qNaN。
- `LOG(±0)=-Inf`，`LOG(+Inf)=+Inf`。
- `RCP(±0)=±Inf`，`RCP(±Inf)=±0`。
- `RSQ(+0)=+Inf`，`RSQ(-0)=-Inf`，`RSQ(+Inf)=+0`。
- `SQRT(±0)=±0`，`SQRT(+Inf)=+Inf`。
- `EXP(+Inf)=+Inf`，`EXP(-Inf)=+0`。
- Overflow 产生 signed infinity；underflow 按 IEEE subnormal/zero rounding。

#### 10.2 `RDTSC`

- 返回当前 SM cycle/timestamp counter 的低 32 bits。
- Counter 每个实现定义的 SM cycle 加 1，并按 $2^{32}$ wrap。
- 同一 warp 执行同一条 `RDTSC` 时所有 executing lanes 写入相同值。
- 同一 warp 中，后执行的 `RDTSC` 在没有 wrap 时不得小于先执行的值。
- 功能 testcase 只检查同 warp 一致性和单调性，不比较 CModel/RTL exact value。
- Functional Reference CModel 使用全局 deterministic instruction-step counter
  作为 timestamp；同一条 `RDTSC` 的所有 executing lanes 读取同一值。跨
  warp/CTA 的精确 timestamp 不属于可比较结果。

### 11. Illegal instruction 与 execution error

#### 11.1 Illegal instruction

以下情况在执行前拒绝：

- unknown/reserved opcode、type、subop、space 或 scope。
- opcode/type 组合不在 legal matrix。
- reserved/unused bits 非 0。
- register field 高位非 0，或 register/predicate 越界。
- register pair base 大于 254。
- branch/call target 不在 program range。
- store 到 `.cmem/.pmem`。
- collective 或禁止 guard 的 control instruction 使用 predicate guard。

#### 11.2 Execution error

以下情况在 runtime 报错：

- memory out-of-bounds。
- atomic misaligned/out-of-bounds。
- integer divide by zero。
- invalid `BFX/BINS` range。
- non-uniform control condition。
- call stack overflow/underflow。
- barrier generation misuse。

出错指令不提交任何 register、predicate、memory、atomic、PC 或 barrier side effect。Illegal instruction 的 runner 状态是 `invalid`；execution error 是 `fail`；等待无法释放的 barrier 或超过统一执行预算是 `timeout`。

动态指令以 warp 为提交单位。任一 executing lane 产生 execution error 时，
该 warp 本次指令对所有 lane 的全部架构修改均不提交；predicate-false lane
不参与错误检查。ATOM 必须先完成所有 participating lane 的地址和错误检查，
再按 ascending lane ID 提交。
## 16. 附录 B：逐指令分值表

| Opcode | 分值 | Opcode | 分值 |
|---|---:|---|---:|
| ADD | 0.7 | SUB | 0.7 |
| MUL | 0.7 | MAD | 0.9 |
| FMA | 0.9 | DIV | 0.9 |
| NEG | 0.8 | ABS | 0.8 |
| MIN | 0.8 | MAX | 0.8 |
| AND | 0.4 | OR | 0.4 |
| XOR | 0.4 | NOT | 0.4 |
| SHL | 0.4 | SHR | 0.4 |
| BFX | 0.7 | BINS | 0.7 |
| POPC | 0.6 | FLO | 0.6 |
| CMP | 1.0 | CMPP | 1.0 |
| SEL | 1.0 | PICK | 1.0 |
| LD | 2.0 | ST | 1.5 |
| LDC | 1.0 | ATOM | 2.5 |
| BR | 0.7 | BRX | 1.0 |
| CALL | 0.8 | RET | 0.7 |
| HALT | 0.5 | SYNC.CT | 1.5 |
| MBAR | 0.8 | CVTFF | 0.6 |
| CVTFI | 0.6 | CVTIF | 0.6 |
| CVTII | 0.6 | CPY | 0.6 |
| LOADI | 0.5 | LOADI64 | 0.5 |
| SHUF | 0.8 | VOTE | 0.6 |
| MTCH | 0.6 | RCP | 0.5 |
| RSQ | 0.5 | SIN | 0.5 |
| COS | 0.5 | EXP | 0.5 |
| LOG | 0.5 | SQRT | 0.5 |
| RDTSC | 0.5 | **合计** | **40.0** |

每条指令的分数覆盖其全部 legal required type/subop/space。该指令按
评测 manifest 中各 variants 的权重计分；只通过单一 type 不自动获得该 opcode 满分。

## 17. 附录 C：Public testcase package

随赛题发布的参考 testcase package 包含 manifest、AEC assembly/binary、input、
expected、generator 和 build metadata。该子集用于展示评测接口与典型行为，
不代表全部指令、类型和边界情况的覆盖范围。

## 18. 附录 D：ASAP7 SRAM 锁定与 wrapper

### D.1 版本与原生接口

SRAM collateral 锁定为：

- repository：`https://github.com/The-OpenROAD-Project/asap7_sram_0p0.git`；
- commit：`522eeccbccefcd66e61893fa1059df24d95e9f86`；
- license：BSD-3-Clause。

白名单中的 native cell 具有以下同构、高有效接口，`AW` 和 `DW` 由
表 D-1 决定：

```systemverilog
module <native_cell> (
    input               clk,
    input  [AW-1:0]     ADDRESS,
    input  [DW-1:0]     wd,
    input               banksel,
    input               read,
    input               write,
    output reg [DW-1:0] dataout
);
```

`banksel` 为 1 时在 `posedge clk` 执行访问。Write 更新指定 word；read 在该
时钟沿更新 `dataout`，没有 read 时 `dataout` 保持原值。原生 behavioral
model 在 `read && write` 时执行 write，但参赛设计不得依赖该优先级，
同一访问最多使能两者之一。Macro 无 reset，未写入位置的内容未定义。
Native cell 不提供 byte write enable。

| Native cell | Organization | AW | DW | LEF `SIZE` (um) | Area (um^2) |
|---|---:|---:|---:|---:|---:|
| `srambank_64x4x32_6t122` | 256x32 | 8 | 32 | 9.612 x 43.2 | 415.2384 |
| `srambank_128x4x32_6t122` | 512x32 | 9 | 32 | 16.0 x 43.2 | 691.2 |
| `srambank_256x4x32_6t122` | 1024x32 | 10 | 32 | 30.348 x 43.2 | 1311.0336 |
| `srambank_64x4x64_6t122` | 256x64 | 8 | 64 | 9.612 x 77.76 | 747.42912 |

### D.2 锁定文件

每个 `<native_cell>` 的三个必需 view 相对于锁定仓库根目录为：

- functional simulation：`generated/verilog/<native_cell>.v`；
- timing/internal power：`generated/LIB/<native_cell>.lib`；
- dimensions/physical abstract：`generated/LEF/<native_cell>.lef`。

SHA256 如下：

| Native cell | Verilog SHA256 | Liberty SHA256 | LEF SHA256 |
|---|---|---|---|
| `srambank_64x4x32_6t122` | `462dab78a945da97fada3d45ca410722e33516b116a4d2fb66c5760e60a0337f` | `6c9e1752370c1f857437e5b3d42edd628496fedb2b4e4b7a45a6044000e55021` | `15ce8352303ddf999aff20b1d82550cf28ac792610efd7874c0705204b83a6c3` |
| `srambank_128x4x32_6t122` | `936fa180b87b3db45b95830173a5bfe0836eaa75a84b68cedfc079051a6ca4a7` | `6498190c476828969177ca2856bd3a596a990582a8b3a52b98c0f96284e24981` | `7ce48392379ef079235d5779291968d8ce5d9a56ba12be8be68b165976eacb8f` |
| `srambank_256x4x32_6t122` | `8fd89ad2ae34f40650d02985f19a70b4a28a2cdf5ad0a8b9db1e71c2a94593ba` | `43c5c8396817c534d0d14a379908bba94aa80612936457495659439c27315224` | `36c5e37468e4fa1a971b27a0e6893cb7472ff0b165a0dddfeba7bdc2daba7ac7` |
| `srambank_64x4x64_6t122` | `c0d63f6652f67fba6263e48b660adb369ccf059b1ea4f2e7155390131846b23b` | `ea69e8d52f4f5d92e1c5c87dd5380f4e3fdc4f669e0bde1484af4527fafc84c5` | `497002d3593528156129e8b9648945ff98f2edf2831a38d44d51873e555d5df5` |

评测时
Verilator 加载 behavioral Verilog，Yosys 将 native cell 作为 library/blackbox
保留，OpenSTA 加载实例化 cell 对应的 Liberty。面积报告按实例数累加
LEF `SIZE` 面积，不使用 Liberty 中为 0 的 cell `area`。

### D.3 可选 wrapper

官方 wrapper 只做端口重命名，不增加 storage、reset 或 bypass。参赛者可直接
实例化 native cell，也可使用下列 wrapper：

```systemverilog
module aec_sram_256x32 (
    input logic clk, en, read_en, write_en,
    input logic [7:0] addr,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);
    srambank_64x4x32_6t122 u_sram (
        .clk(clk), .ADDRESS(addr), .wd(write_data), .banksel(en),
        .read(read_en), .write(write_en), .dataout(read_data));
endmodule

module aec_sram_512x32 (
    input logic clk, en, read_en, write_en,
    input logic [8:0] addr,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);
    srambank_128x4x32_6t122 u_sram (
        .clk(clk), .ADDRESS(addr), .wd(write_data), .banksel(en),
        .read(read_en), .write(write_en), .dataout(read_data));
endmodule

module aec_sram_1024x32 (
    input logic clk, en, read_en, write_en,
    input logic [9:0] addr,
    input logic [31:0] write_data,
    output logic [31:0] read_data
);
    srambank_256x4x32_6t122 u_sram (
        .clk(clk), .ADDRESS(addr), .wd(write_data), .banksel(en),
        .read(read_en), .write(write_en), .dataout(read_data));
endmodule

module aec_sram_256x64 (
    input logic clk, en, read_en, write_en,
    input logic [7:0] addr,
    input logic [63:0] write_data,
    output logic [63:0] read_data
);
    srambank_64x4x64_6t122 u_sram (
        .clk(clk), .ADDRESS(addr), .wd(write_data), .banksel(en),
        .read(read_en), .write(write_en), .dataout(read_data));
endmodule
```
