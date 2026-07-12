# case3 公开数据集分析示例

本目录是 `rtl/case3.v` 的公开结果包。

对应的上游 cocotb 测试平台为 `tb/case3_tb.py`。本包使用相同的模型风格，但运行一个固定的小规模配置和一个 JSON 驱动的测试，而非完整的 pytest 矩阵。

产物：

- `design.json`：RTL 元数据、参数、时钟/复位、流端口、AXI master 端口、配置和状态。
- `testbench.json`：JSON 驱动的 cocotb/VCS 运行配置。
- `verification_skeleton.json`：时钟/复位、流驱动/接收、AXI RAM、复位和计分板结构。
- `constraints.json`：固定种子简单随机策略。
- `coverage_bins.json`：用于简单运行的功能 bin。
- `functional_coverage.json`：cocotb 采样的功能 bin 命中计数。
- `coverage_result.json`：统一的行覆盖率、分支覆盖率、功能覆盖率和综合覆盖率结果。
- `rtl/case3.v`：本案例复制的 RTL。
- `rtl/axi_vfifo_raw_wr.v`：复制的写端依赖 RTL。
- `rtl/axi_vfifo_raw_rd.v`：复制的读端依赖 RTL。
- `tb/case3_tb.py`：复制的上游 cocotb 测试平台。
- `case3_cocotb_top.v`：固定参数包装器。
- `test_case3_json_sequences.py`：用于本次运行的 cocotb 测试脚本。
- `dataset_result.json`：顶层产物索引。

测试覆盖率来自：

`public_dataset/case3/vcs_coverage_20260711/report`

目标顶层模块 `case3` 的最终覆盖率：

- line: 25 / 26 = 96.15%
- branch: 9 / 10 = 90.00%
- score: 93.08%

包含 `axi_vfifo_raw_wr` 和 `axi_vfifo_raw_rd` 的总体覆盖率：

- line: 301 / 322 = 93.48%
- branch: 99 / 113 = 87.61%
- functional: 17 / 17 = 100.00%
- composite: 93.79%
