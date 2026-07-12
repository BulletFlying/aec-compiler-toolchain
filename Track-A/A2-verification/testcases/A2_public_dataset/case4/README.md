# case4 公开数据集分析示例

本目录是 `rtl/case4.v` 和 `tb/case4_tb.py` 的具体公开结果示例。

包含内容：

- `design.json`：RTL 元数据、参数、时钟/复位以及 AXI 接口分组。
- `testbench.json`：cocotb 测试平台元数据和 VCS 覆盖率运行配置。
- `verification_skeleton.json`：时钟/复位生成、输入驱动、输出监控和计分板结构。
- `constraints.json`：固定种子、固定 5000 序列的约束随机策略，用于 Z3 后端生成器。
- `coverage_bins.json`：用于指导随机生成的功能覆盖率 bin。
- `functional_coverage.json`：cocotb 采样的功能 bin 命中计数。
- `coverage_result.json`：统一的行覆盖率、分支覆盖率、功能覆盖率和综合覆盖率结果。
- `rtl/case4.v`：本案例复制的 RTL。
- `tb/case4_tb.py`：复制的上游 cocotb 测试平台。
- `dataset_result.json`：将所有产物关联在一起的一体化顶层索引。
- `test_case4_json_sequences.py`：用于固定 5000 序列结果的 JSON 驱动 cocotb 运行脚本。

测试覆盖率来自 JSON 驱动的 5000 序列 VCS/cocotb 结果：

`public_dataset/case4/vcs_coverage_20260711/report`

最终覆盖率：

- line: 125 / 129 = 96.90%
- branch: 25 / 31 = 80.65%
- functional: 29 / 29 = 100.00%
- composite: 93.28%

VCS 可以在本设置中支持 JSON 驱动的输入，因为 cocotb 读取 JSON 并通过 VPI 驱动 RTL。VCS 本身只需正常的覆盖率选项：

```sh
-cm line+branch
```
