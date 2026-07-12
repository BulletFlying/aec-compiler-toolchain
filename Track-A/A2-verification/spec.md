# A2：验证环境自动生成 - 赛题说明

## 赛题描述

构建一个自动验证环境生成框架，读取给定的 RTL 设计，自动生成可运行的验证环境，支持约束随机测试和覆盖率反馈。

## 1. 任务目标

给定一个 RTL 设计，系统必须自动：

- 解析 RTL 模块接口：识别时钟、复位、参数、端口方向、端口宽度和协议分组
- 生成 testbench 骨架：时钟/复位生成、输入驱动、输出监视和自动比对框架
- 生成约束随机测试输入，固定 seed 和固定序列数（5000），确保可复现
- 生成或更新功能覆盖 bin，并根据覆盖率反馈生成更有效的测试序列
- 运行仿真并输出行覆盖率、分支覆盖率、功能覆盖率和统一报告

评测覆盖 **10 个独立电路**，每个电路单独计分。

## 2. 输入格式

每个评测输入为一个 RTL benchmark：

```text
benchmark/
  rtl/
    dut.v
```

- `rtl/` 包含待验证的 RTL 源码（单文件或多文件）
- 顶层模块名可作为参数给出或从 RTL 中识别

覆盖的 RTL 接口：

- AXI4-Lite 或 AXI/AXI-like 接口
- 简单 SRAM-like 接口
- Streaming valid/ready 接口

## 3. 输出格式

系统必须为每个电路生成独立的结果目录：

```text
submission_out/
  case_name/
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

### `design.json`

描述 RTL 接口解析结果：

- 顶层模块名
- RTL 文件列表
- 时钟和复位信号
- 端口方向、宽度、类型和协议分组
- 推断的接口协议（AXI、SRAM、valid/ready stream）

### `verification_skeleton.json`

描述自动生成的验证骨架：

- 时钟/复位生成方法
- 驱动列表及负责接口
- 监视列表及采样时机
- DUT 输出结果
- 生成的 testbench 源码路径

### `constraints.json`

描述约束随机测试策略：

- 固定 seed
- 固定总序列数（5000）
- 随机变量列表
- 覆盖率反馈约束调整记录

### `coverage_bins.json`

描述功能覆盖目标：

- Coverpoint 名称
- Bin 定义
- 每个 bin 对应的协议场景或 corner case
- 未覆盖 bin 的反馈记录

### `functional_coverage.json`

描述功能覆盖采样结果：

- 已覆盖 bin 数、有效 bin 总数、功能覆盖百分比
- 每个 coverpoint 的 bin 命中次数和覆盖状态

### `coverage_result.json`

描述覆盖率结果：

- 行覆盖率值
- 分支覆盖率值
- 功能覆盖率值
- 按评分公式计算的综合覆盖率

### `report.json`

顶层汇总报告：

- 各阶段成功/失败：解析、骨架生成、仿真、覆盖率收集
- 关键输出文件路径
- 覆盖率汇总
- 可复现命令

## 4. 运行入口

提交必须提供统一的运行入口：

```sh
./run.sh \
  --rtl benchmark/rtl \
  --top dut \
  --out submission_out/case_name \
  --seed x \
  --num-seq 5000
```

或等价方式：

```sh
python3 run.py \
  --rtl benchmark/rtl \
  --top dut \
  --out submission_out/case_name \
  --seed x \
  --num-seq 5000
```

入口必须完成从 RTL 解析到结果输出的完整流水线。评测人员不应需要手动修改生成文件。

## 5. 环境约束

- 操作系统：Linux x86_64
- Python：推荐 3.10+
- 允许使用 Z3、PyVerilog 等开源库（必须声明依赖）
- 结果必须可复现：相同 seed 和相同 RTL 输入必须产生一致或等价的结果
- 多文件 RTL 必须保持正确的编译顺序和 include 路径
- 若有额外依赖需提供 `requirements.txt`

## 6. 公开数据集

`testcases/` 中的公开数据集包含 `case1` 至 `case5` 作为公开示例，展示：

- 推荐的结果目录结构和报告格式
- 验证骨架、约束、功能覆盖 bin 和三类覆盖率 JSON 表示
- cocotb/VCS 覆盖率收集流程
- 本地调试和格式对齐样例

公开数据集不代表隐藏评测的完整范围。隐藏评测使用相同的 I/O 约定，但具有不同的 RTL 结构、参数、接口组合和 corner case。
