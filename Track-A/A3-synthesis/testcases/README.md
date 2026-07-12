# A3 逻辑综合参赛者包

本目录包含 A3 逻辑综合的完整参赛者包，包括 10 个公开电路（LSV01-LSV10）。

---

## 目录结构

- `public/`：10 个公开电路，每个包含 `rtl/design.v`、`constraints.sdc`、`problem.yaml` 和 `README.md`
- `lib/nangate45/`：Nangate45 typical Liberty、DB 和门级功能仿真模型
- `references/`：70 个公开电路的官方参考点、Pareto 前沿、超体积和指标 CSV
- `figures/public_pareto/`：公开电路的 arrival-area 散点图和 Pareto 前沿
- `scripts/`：Yosys/OpenSTA 公开参考脚本（仅供理解数据和自测，非提交接口）
- `submission_template/`：提交元数据、Makefile、原创性声明和第三方依赖模板
- `docs/`：官方参赛规范 PDF、LaTeX 源文件和接口速查

## 公开电路

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

## 必须提交的文
提交根必须至少包含：

```text
Makefile
submission.yaml
config.json
ORIGINALITY_DECLARATION.md
THIRD_PARTY.md
src/                       # 完整可构建源代码
```

禁止仅二进制提交、预生成网表或仅远程服务封装。评测期间网络禁用。

## Makefile 接口

必须支持：

```bash
make -j1 build
make -j1 synth RTL=<rtl.v> TOP=<top> SDC=<constraints.sdc> \
  LIBERTY=<Nangate45.lib> CONFIG=<config.json> CIRCUIT=<circuit-id> \
  POINT=<1..N> OUT_DIR=<absolute-output-dir>
make clean
```

`build` 必须生成可执行入口 `bin/synth_tool`。每次成功的 `synth` 必须生成 `OUT_DIR/netlist.v`，顶层模块名匹配 `TOP`。

`config.json` 顶层键为电路 ID；`$default` 为保留回退键。每个值为长度 1-7 的 JSON 数组；数组长度即为该电路的 point 数。数组元素可以是任何合法 JSON 参数或优化序列。评测器不解释元素内容。

## 快速开始

```bash
# 构建综合工具
make -j1 build

# 在公开电路上运行综合
make -j1 synth \
  RTL=public/LSV01_epfl_priority/rtl/design.v \
  TOP=top \
  SDC=public/LSV01_epfl_priority/constraints.sdc \
  LIBERTY=lib/nangate45/NangateOpenCellLibrary_typical.lib \
  CONFIG=config.json \
  CIRCUIT=LSV01 \
  POINT=1 \
  OUT_DIR=/tmp/output_LSV01_p1
```

## 正确性与评分

每个 point 的正确性由组委会使用隐藏激励与 RTL/门级零延迟仿真、逐周期比对来验证。不使用自报结果。不正确、内存溢出、网表缺失、黑盒或未授权 cell 的 point 不进入 PPA；无正确 point 的电路得 0 分。

总分 100 分：PPA 最多 90、运行时间最多 5、原创性最多 5。`Q_PPA = min(2, HV_user/HV_ref)`。每电路技术分 = `45*Q_PPA + 5*Q_runtime`；20 个电路平均后加上原创性加分。

允许使用 Mockturtle、Yosys、Berkeley ABC 或其他开源工具，但必须完整披露版本、许可证、调用边界和新增代码。允许 LLM 辅助开发，必须在原创性声明中披露。
