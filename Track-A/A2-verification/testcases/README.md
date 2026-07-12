# A2 公开测试集

本目录包含 A2 验证环境自动生成的 5 个公开示例电路。

## 公开用例

| 用例 | 接口类型 | 描述 |
|------|----------|------|
| `case1` | AXI4-Lite | 简单寄存器文件，带 AXI4-Lite slave 接口 |
| `case2` | SRAM-like | 单端口 SRAM，带地址/数据/写使能 |
| `case3` | Valid/ready stream | 流式数据处理器，带反压 |
| `case4` | AXI4-Lite（复杂） | AXI4-Lite 外设，带多个寄存器组 |
| `case5` | 混合 | SRAM 和 valid/ready 接口组合 |

## 目的

这些公开示例展示：

- 推荐的结果目录结构和报告格式
- 验证骨架、约束、覆盖 bin 和结果的 JSON 表示
- cocotb/VCS 覆盖率收集流程
- 本地调试和格式对齐

## 输入结构

每个用例提供：

```text
caseN/
  rtl/
    dut.v               # 待验证的 RTL 源码
```

## 预期输出结构

每个用例应生成：

```text
output/
  caseN/
    design.json
    verification_skeleton.json
    constraints.json
    coverage_bins.json
    functional_coverage.json
    coverage_result.json
    report.json
    generated_tb/
    generated_tests/
```

## 运行用例

```sh
./run.sh \
  --rtl testcases/case1/rtl \
  --top dut \
  --out output/case1 \
  --seed 42 \
  --num-seq 5000
```

## 与隐藏评测的关系

隐藏评测使用相同的 I/O 约定，但具有：

- 不同的 RTL 结构、参数和接口组合
- 额外的 corner case
- 更复杂的协议交互
- 总共 10 个电路（对比 5 个公开示例）

参赛者不得假定隐藏测试完全照搬公开示例。
