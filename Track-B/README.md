# 赛道 B：GPGPU RTL 设计

> 基于 AEC (Array Execution Core) 128-bit 定长指令集，设计并实现一个 GPGPU 系统。
> 提交完整、可综合的 RTL 和与其架构行为一致的 CModel。

## 赛题

| 编号 | 赛题 | 赛题说明 | 评分细则 | 公开测试集 |
|------|------|----------|----------|-----------|
| B | AEC GPGPU RTL 设计 | [spec.md](spec.md) | [scoring.md](scoring.md) | [testcases/](testcases/) |

## 赛题概述

本题要求参赛者设计并实现一个执行 AEC 128-bit 定长指令的 GPGPU 系统，提交完整、可综合的 RTL 和与其架构行为一致的 CModel。官方使用同一组 AEC binary、launch 参数和 memory image 分别运行 CModel 与 RTL，并依据独立生成的 expected result 判断正确性。

**本题关注三个方面：**

1. AEC ISA 的完整、正确实现
2. 在功能正确基础上的吞吐、频率、功耗和面积优化
3. 设计、验证和 PPA 结果的可复现性与解释质量

**本题不要求**：PTX translator、AEC assembler、CUDA runtime、FPGA bitstream 或上板验证。官方 testcase 直接提供已组装完成的 AEC binary。

## AEC ISA 特性

| 特性 | 规格 |
|------|------|
| 指令宽度 | 128-bit 定长 |
| 寄存器文件 | 256 寄存器 x 32-bit / thread |
| 谓词寄存器 | 8 个独立谓词 P0-P7 |
| 执行模型 | Warp = 32 lanes |
| CTA 规模 | 最多 256 threads / CTA (8 warps) |
| 内存空间 | `.gmem`、`.smem`、`.cmem`、`.lmem`、`.pmem` |

## 评分细则（总分 100 分）

| 大项 | 分值 |
|------|------|
| 实现正确性 | 50 |
| PPA | 40 |
| 报告 | 10 |

### 实现正确性（50 分）

| 项目 | 分值 |
|------|------|
| RTL 指令与架构功能 | 40 |
| CModel | 5 |
| RTL/CModel alignment | 5 |

### RTL 40 分分配

| 功能族 | 分值 |
|--------|------|
| ADD-MAX 算术 | 8 |
| AND-FLO 逻辑/位操作 | 5 |
| CMP-PICK 谓词/选择 | 4 |
| LD/ST/LDC/ATOM 和内存空间 | 7 |
| BR/BRX/CALL/RET/HALT/SYNC.CT/MBAR | 6 |
| CVT*/CPY/LOADI/LOADI64 | 4 |
| SHUF/VOTE/MTCH | 2 |
| RCP-SQRT/RDTSC | 4 |

### PPA（40 分）

| 项目 | 分值 |
|------|------|
| Performance benchmark | 15 |
| 最高频率 | 10 |
| Performance per watt | 8 |
| Performance per area | 7 |

吞吐估算公式：

```text
T_i = (W_i x f_max) / C_i
```

其中 W_i 为有效工作量，C_i 为 Verilator 测得的 execution cycles，f_max 为官方 ASAP7/OpenSTA flow 得到的最高有效频率。

### 报告（10 分）

| 报告内容 | 分值 | 满分条件 |
|----------|------|----------|
| 设计说明 | 4 | 架构、pipeline、scheduler、memory、SRAM、关键状态机和取舍完整 |
| 验证说明 | 3 | CModel/RTL/testcase/coverage、失败定位和 alignment 证据可复现 |
| PPA、限制与合规 | 3 | 原始报告、指标解释、已知限制、第三方及生成工具声明完整 |

## SRAM 锁定

比赛使用 commit `522eeccbccefcd66e61893fa1059df24d95e9f86` 的 `The-OpenROAD-Project/asap7_sram_0p0`。官方提供且 PPA flow 认可的 macro 仅包括：

| Wrapper | ASAP7 native cell | Organization |
|---------|-------------------|--------------|
| `aec_sram_256x32` | `srambank_64x4x32_6t122` | 256x32 |
| `aec_sram_512x32` | `srambank_128x4x32_6t122` | 512x32 |
| `aec_sram_1024x32` | `srambank_256x4x32_6t122` | 1024x32 |
| `aec_sram_256x64` | `srambank_64x4x64_6t122` | 256x64 |

SRAM wrappers：[sram/](sram/)

## 评测环境

| 工具 | 版本 |
|------|------|
| Verilator | 5.049 devel, `v5.048-179-gc878a7e73` |
| Yosys | 0.64+308, commit `78e05dfb0` |
| OpenSTA | `v2.2.0-2121-g66c29303` |
| GCC/G++ | 13.3.0 |
| Python | 3.12.3 |
| ASAP7 | PDK 1.7, 7.5-track v28, RVT TT NLDM |

## 公开测试包

36 个公开测试用例，详见 [testcases/](testcases/)：

- **ABI**：c0_smoke
- **算术**：add (2)、mul、div、fma
- **逻辑/位**：bfx、popc
- **类型转换**：cvtff
- **比较/选择**：cmp、cmpp、sel、cpy、loadi64
- **内存**：ld、st、ldc、atom (2)
- **控制流**：brx、call、ret、mbar、sync_ct (2)
- **线程通信**：shuf、vote、mtch
- **SFU**：rcp、sqrt、rdtsc
- **跨领域**：t_partial_warp、t_memory_boundary
- **Kernel**：vadd、gemm_naive、histogram

## 提交目录结构

```text
rtl/         # RTL、official top adapter、SystemVerilog testbench
cmodel/      # CModel source、headers、build files
scripts/     # build、run、regression、PPA commands
reports/     # DESIGN.md、VERIFICATION.md、PPA.md、LIMITATIONS.md
evidence/    # logs、waveforms、JSON results、synthesis/STA reports
README.md    # 环境、依赖、入口命令和已知限制
```

## 禁止事项

- 根据 testcase ID、filename、input hash 或固定数据直接生成答案
- 绕过 RTL/CModel 的 result script
- correctness 和 PPA 使用功能配置不同的核心
- 修改官方 SRAM timing/area/power model
- 隐瞒 vendor IP、第三方 RTL、blackbox 或生成代码来源
- 提交不可复现的 generated RTL
- 依赖评测时联网下载
- 使用未声明的 unsynthesizable construct 进入 judged hierarchy
