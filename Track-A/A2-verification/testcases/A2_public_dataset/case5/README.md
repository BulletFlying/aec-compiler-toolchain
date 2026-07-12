# case5 公开数据集分析示例

本目录是 `rtl/case5.v` 的公开结果包。

包含内容：

- `design.json`：RTL 元数据、参数、时钟/复位以及地址-命令接口分组。
- `testbench.json`：JSON 驱动的 cocotb/VCS 运行配置。
- `verification_skeleton.json`：时钟/复位生成、输入驱动、命令监控、完成驱动和计分板结构。
- `constraints.json`：固定种子、固定 5000 序列的约束随机策略，用于 Z3 兼容生成器。
- `coverage_bins.json`：用于指导随机生成的功能覆盖率 bin。
- `functional_coverage.json`：cocotb 采样的功能 bin 命中计数。
- `coverage_result.json`：统一的行覆盖率、分支覆盖率、功能覆盖率和综合覆盖率结果。
- `rtl/case5.v`：本案例复制的 RTL。
- `tb/case5_tb.py`：复制的上游 cocotb 测试平台。
- `case5_cocotb_top.v`：`case5` 的直接 cocotb 顶层包装器。
- `test_case5_json_sequences.py`：用于固定 5000 序列结果的 JSON 驱动 cocotb 运行脚本。
- `dataset_result.json`：将所有产物关联在一起的一体化顶层索引。

对应的上游 cocotb 测试平台为 `tb/case5_tb.py`。它验证完整的 AXI 交叉开关，并通过读/写交叉开关路径间接实例化 `case5`。本包使用直接包装器，以便覆盖率统计针对目标 RTL。

测试所用的包装器使用 4 个 master 接口、每个 master 2 个地址区域、2 个 slave 接口插槽（`S=1`）、M2 上的安全 master、写命令输出使能，以及一个较小的 accept 限制来测试背压和完成释放行为。

VCS 可以在本设置中支持 JSON 驱动的输入，因为 cocotb 读取 JSON 并通过 VPI 驱动 RTL。VCS 本身只需正常的覆盖率选项：

```sh
-cm line+branch
```

测试覆盖率来自：

`public_dataset/case5/vcs_coverage_20260711/report`

最终覆盖率：

- line: 121 / 138 = 87.68%
- branch: 38 / 43 = 88.37%
- functional: 26 / 26 = 100.00%
- composite: 91.57%
