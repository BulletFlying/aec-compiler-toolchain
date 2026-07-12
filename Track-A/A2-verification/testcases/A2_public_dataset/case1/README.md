# case1 公开数据集分析示例

本目录是 `rtl/case1.v` 的公开结果包。

包含内容：

- `design.json`：RTL 元数据、参数、时钟/复位以及 AXI 读接口分组。
- `testbench.json`：JSON 驱动的 cocotb/VCS 运行配置。
- `verification_skeleton.json`：时钟/复位生成、输入驱动、输出监控和计分板结构。
- `constraints.json`：固定种子、固定 5000 序列的约束随机策略，用于 Z3 后端生成器。
- `coverage_bins.json`：用于指导随机生成的功能覆盖率 bin。
- `functional_coverage.json`：cocotb 采样的功能 bin 命中计数。
- `coverage_result.json`：统一的行覆盖率、分支覆盖率、功能覆盖率和综合覆盖率结果。
- `case1_cocotb_top.v`：`case1` 的直接 cocotb 顶层包装器。
- `test_case1_json_sequences.py`：用于固定 5000 序列结果的 JSON 驱动 cocotb 运行脚本。
- `dataset_result.json`：将所有产物关联在一起的一体化顶层索引。

注意：`verilog-axi/tb/axi_dma_rd` 的目标是 `axi_dma_rd`，而 `axi_dma_rd.v` 并不会实例化 `case1`。本包使用直接包装器，以便覆盖率统计针对目标 RTL。

测试所用的 VCS 配置使用 32 位 slave 端和 16 位 master 端。`rtl/case1.v` 已打补丁，在 generate 阶段使用安全线网保护依赖参数的位选择，使 VCS O-2018.09-SP2 能够编译不等的 S/M 宽度。

VCS 可以在本设置中支持 JSON 驱动的输入，因为 cocotb 读取 JSON 并通过 VPI 驱动 RTL。VCS 本身只需正常的覆盖率选项：

```sh
-cm line+branch
```

测试覆盖率来自：

`public_dataset/case1/vcs_coverage_20260711/report`

最终覆盖率：

- line: 168 / 317 = 53.00%
- branch: 29 / 60 = 48.33%
- functional: 24 / 24 = 100.00%
- composite: 65.79%
