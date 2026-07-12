# A3：轻量 RTL 逻辑综合工具 - 赛题说明

## 赛题描述

设计并实现一个可离线运行的 RTL 逻辑综合工具。该工具读取 Verilog/SystemVerilog RTL、顶层模块、SDC 约束和 Nangate45 Liberty，在统一资源限制下生成一个或多个合法门级网表。

评测重点：网表功能正确性、arrival-area PPA、综合运行时间和提交源代码的原创贡献。

参赛队伍必须提交工具源代码和统一的 Makefile。允许使用或参考 Mockturtle、Yosys 或 Berkeley ABC 等开源项目，也允许 LLM 辅助开发；所有第三方依赖和开发方法必须完整披露。

## 1. 核心要求

### 1.1 RTL 前端与 Elaboration

工具必须处理测试电路使用的 Verilog/SystemVerilog 语法和工程特性：

- `module` 层次、参数化、`generate`、连续赋值、过程语句
- 组合逻辑、时钟触发逻辑、同步/异步复位、FSM
- 转义标识符、宽位向量、有符号运算、生成器产生的 RTL
- 来自 `problem.yaml` 的顶层、时钟和复位元数据

### 1.2 逻辑优化与工艺映射

工具必须执行 RTL 下降、中间表示构建、工艺无关优化和 Nangate45 工艺映射。输出网表只能实例化指定 Liberty 文件中的标准单元。不允许黑盒、未解析的内部 cell 或来自未提供库的模块。

参赛者可为同一电路输出多个面积/时序权衡点。评测器通过 `CONFIG` 和 `CIRCUIT` 指定配置文件和电路，然后使用 `POINT` 从 1 到 N（`1 <= N <= 7`）中选择。工具必须解析配置并执行对应的优化策略。不同 point 必须反映实际综合策略，而非基于电路 ID 的预生成网表。

### 1.3 源代码与可复现构建

提交必须包含完整的可构建源代码。评测在指定镜像中从源码运行 `make -j1 build`，无网络访问。不允许仅二进制提交、远程 API 封装、无许可证的第三方代码或不可复现构建。

## 2. 交付物

提交根必须至少包含：

```text
Makefile
submission.yaml
config.json
ORIGINALITY_DECLARATION.md
THIRD_PARTY.md
src/
```

| 文件 | 用途 |
|------|------|
| `Makefile` | 唯一评测构建/运行入口；必须实现第 3 节接口 |
| `submission.yaml` | 队伍、工具名称和开发类型 |
| `config.json` | 每电路 point 参数、优化序列和默认回退 |
| `ORIGINALITY_DECLARATION.md` | 自研模块、开源复用、LLM 使用、消融证据 |
| `THIRD_PARTY.md` | 第三方项目版本、许可证、调用边界、修改内容 |
| `src/` | 完整工具源代码和构建所需的本地文件 |

## 3. Makefile 测试接口

### 3.1 必须实现的目标

| 目标 | 用途 |
|------|------|
| `build` | 离线编译提交源代码，生成 `bin/synth_tool`。每次提交仅构建一次 |
| `synth` | 综合一个电路的一个 point，生成指定门级网表 |
| `clean` | 移除提交自身的构建和临时产物；不得删除输入测试用例或评测目录 |

### 3.2 参数

| 变量 | 示例 | 含义 |
|------|------|------|
| `RTL` | `/case/rtl/design.v` | 输入 RTL 文件，只读 |
| `TOP` | `top` | 待综合并保留的顶层模块 |
| `SDC` | `/case/constraints.sdc` | 综合约束，只读 |
| `LIBERTY` | `/pdk/Nangate...lib` | 唯一允许的工艺库 |
| `CONFIG` | `/submission/config.json` | 提交的 point 配置文件，只读 |
| `CIRCUIT` | `LSV01` | 当前电路 ID，用于配置选择 |
| `POINT` | `1` | 当前优化点，范围 1 到该电路配置的 point 数 |
| `OUT_DIR` | `/output` | 当前 point 的独立可写目录 |

### 3.3 每电路 Point 配置

提交根必须提供标准 JSON 文件 `config.json`。顶层键为电路 ID；值为 point 配置数组。保留键 `$default` 作为未覆盖和隐藏电路的回退：

```json
{
  "$default": [
    {"name": "balanced", "passes": ["strash", "balance", "rewrite"]}
  ],
  "LSV01": [
    {"abc_sequence": "compress2rs; dch; amap"},
    ["if -K 6 -g -C 8", "dch", "map"]
  ]
}
```

每个值必须是长度为 1-7 的数组；数组长度即为该电路的 point 数。数组元素可以是任何合法 JSON。字段名和执行语义完全参赛者定义。

评测器仅检查顶层映射和数组长度；不解析数组元素。工具读取 `CONFIG` 并选择匹配 `CIRCUIT` 的数组；若键不存在则回退到 `$default`。然后 `POINT-1` 选择当前配置。

### 3.4 评测流程

```bash
make -j1 build

make -j1 synth \
  RTL=/case/rtl/design.v \
  TOP=top \
  SDC=/case/constraints.sdc \
  LIBERTY=/pdk/NangateOpenCellLibrary_typical.lib \
  CONFIG=/submission/config.json \
  CIRCUIT=LSV01 \
  POINT=1 \
  OUT_DIR=/output
```

成功的 `synth` 必须返回 0 并确保：

```text
/output/netlist.v
```

`netlist.v` 必须非空、可被 Verilog 解析器解析，且顶层模块名匹配 `TOP`。

## 4. 指定环境与资源限制

指定镜像：`my_siliconcompiler_image:latest`

```text
sha256:cf58004bd15d8d67677812e91ccdebe8da1b17dfab1a0390b96c7f568b74f42a
```

主要参考工具：Yosys 0.54、OpenSTA 2.7.0、Icarus Verilog 10.3、Yosys 捆绑的 Berkeley ABC。

每个综合 point：

- 1 CPU 核心，1 综合线程
- 10 GiB 内存
- 网络禁用
- `MAKEFLAGS=-j1`；常见 OpenMP/BLAS 线程变量设为 1

创建并行综合 worker 属于违规；内存溢出或进程崩溃则该该 point 无效。

## 5. 正确性验证

正确性是评分的前提，按 point 评测：

1. 读取 `netlist.v`，链接到指定顶层，检查无黑盒或未未授权 cell
2. 用隐藏 testbench/seed 运行原始 RTL 零延迟仿真，生成 golden trace
3. 用相同 testbench/seed 和 `NangateOpenCellLibrary.v` 功能模型仿真门级网表
4. 逐字节比较有效采样周期的输出 trace

与指定 seed 的任何不一致 = 该 point 不正确。不正确的 point 不进入 PPA 集合；若某电路无正确 point，得 0 分。

## 6. 数据集

官方题库有 20 个电路：10 个公开和 10 个隐藏。全部 20 个等权。

### 公开电路

| ID | 名称 | 类别 | 难度 | RTL 行数 |
|----|------|------|------|----------|
| LSV01 | epfl_priority | 组合优先级 | 易 | 1102 |
| LSV02 | epfl_cavlc | 组合控制 | 易 | 766 |
| LSV03 | epfl_adder | 组合算术 | 易 | 1206 |
| LSV04 | itc99_b11 | 时序 FSM | 中 | 139 |
| LSV05 | sog_axi_downsizer | AXI 控制 | 易 | 220 |
| LSV06 | sog_pfpu_f2i | 浮点转换 | 易 | 23 |
| LSV07 | sog_qdiv | 时序除法器 | 中 | 82 |
| LSV08 | sog_stage_mult | 乘法器流水线 | 中 | 30 |
| LSV09 | sha256_wishbone | 密码/总线 | 难 | 1085 |
| LSV10 | vexriscv_small | CPU 核 | 难 | 3319 |

每个电路目录包含 `rtl/design.v`、`constraints.sdc`、`problem.yaml` 和简要说明。

详见 [testcases/](testcases/) 获取完整参赛者包。

## 7. 官方参考点

每个电路有 7 个官方参考点，用于构建 arrival-area Pareto 前沿：

| Point | 参考策略 |
|-------|----------|
| yosys_p1 | compress2rs + dch，映射到 Nangate45 |
| yosys_p2 | `if -K 6 -g -C 8` + dch，映射到 Nangate45 |
| yosys_p3 | resyn2rs + dch，映射到 Nangate45 |
| yosys_p4 | 两轮 compress2rs + dch，映射到 Nangate45 |
| yosys_p5 | 两轮 `if -K 6 -g -C 8` + dch，映射到 Nangate45 |
| dc_area | 商业工具面积导向参考 |
| dc_timing | 商业工具时序导向参考 |

商业参考不是评测依赖；提交的工具必须在指定开源镜像中独立构建和运行。
