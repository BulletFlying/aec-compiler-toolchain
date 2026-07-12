# A1 公开测试集

本目录描述 A1 轻量 RTL 仿真器的 12 个公开测试用例。

## 测试用例列表

| 用例 | 描述 | 重点 |
|------|------|------|
| `basic01` | 基础组合逻辑 | `assign`、`wire`、基本门 |
| `basic02` | 基础时序逻辑 | DFF、`always @(posedge clk)` |
| `basic03` | `if-else` / `case` 语句 | 过程块 |
| `basic04` | `parameter` 和 `generate` | 参数化模块 |
| `basic05` | `for` 循环和 `integer` | 过程循环 |
| `alu` | ALU 模块 | 多操作组合逻辑 |
| `priority_encoder` | 优先级编码器 | 带优先级的 `case` |
| `i2c` | I2C 控制器 | FSM + 总线协议（更高 F2 权重） |
| `ip` | IP 核集成 | 层次化模块实例 |
| `axis_fifo` | AXI-Stream FIFO | valid/ready 握手 + 存储器 |
| `sha256` | SHA-256 哈希核 | 复杂组合 + 时序逻辑 |
| `GEMM` | 矩阵乘法 | 性能基准（P1/P2/P3 计分） |

## 测试用例结构

每个测试用例遵循以下结构：

```text
case_name/
  filelist.txt          # Verilog 源文件列表
  rtl/                  # RTL 源文件
    design.v
    ...
  tb/
    tb.v                # Testbench
    input.mem           # 输入数据
    output_ref.mem      # 预期输出（golden 参考）
```

## 评测流程

```text
make build
make compile_sim FILELIST=filelist.txt TOP=tb
make run
diff -u tb/output_ref.mem tb/output.mem
```

## 与隐藏测试的关系

隐藏测试遵循相同的接口和结构，但可能包含：

- 更大规模的 RTL 设计和更多模块
- 更复杂的 FSM 和协议交互
- 语法覆盖方面的额外 corner case
- 更高计算负载的性能用例

参赛者不得假定公开测试用例结构固定不变。
