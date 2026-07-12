# case2 公开数据集分析示例

本目录与 `case2` 的 `axi_ram` 公开结果包对应，但使用现有的纯 Verilog 测试平台而非 cocotb。

包含内容：

- `rtl/case2.v`：本案例复制的顶层 RTL 源文件。
- `rtl/case2_1.v` 和 `rtl/case2_2.v`：复制的 RTL 依赖文件。
- `tb/case2_tb.v`：复制的纯 Verilog 向量测试平台。
- `tb/input.mem` 和 `tb/output.mem`：已签入的向量激励和预期输出。
- `filelist.txt`：用于编译复制的 RTL/测试平台的本地文件列表。
- `design.json`：RTL 元数据、参数、时钟/复位以及 AXI-Stream 接口分组。
- `testbench.json`：Verilog 测试平台元数据和 VCS 覆盖率运行配置。
- `verification_skeleton.json`：时钟/复位生成、输入驱动、输出监控和计分板结构。
- `vector_io_schema.json`：`tb/input.mem` 和 `tb/output.mem` 的模式定义。
- `constraints.json`：固定种子、固定 5000 序列的约束随机策略，用于 Z3 后端生成器。
- `coverage_bins.json`：用于指导随机生成的功能覆盖率 bin。
- `functional_coverage.json`：已验证向量流的功能 bin 命中计数。
- `coverage_result.json`：统一的行覆盖率、分支覆盖率、功能覆盖率和综合覆盖率结果。
- `dataset_result.json`：将所有产物关联在一起的一体化顶层索引。

测试覆盖率来自现有的 Verilog 向量测试平台：

`public_dataset/case2/vcs_coverage_20260711/report`

`tb.UUT` 子树的最终 RTL 覆盖率：

- line: 92 / 154 = 59.74%
- branch: 46 / 73 = 63.01%
- functional: 13 / 14 = 92.86%
- composite: 70.59%

当前 `case2_tb.v` 不读取 JSON。JSON/Z3 流程需要先生成 `tb/input.mem` 和 `tb/output.mem`，然后 VCS 可以运行 Verilog 测试平台并使用以下选项收集覆盖率：

```sh
-cm line+branch
```
