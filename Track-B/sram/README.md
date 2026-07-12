# 锁定 ASAP7 SRAM 资料

竞赛 SRAM 库锁定为：

- 仓库：`https://github.com/The-OpenROAD-Project/asap7_sram_0p0.git`
- commit：`522eeccbccefcd66e61893fa1059df24d95e9f86`
- 许可证：BSD-3-Clause

参赛者可直接实例化 native macro，或使用 `asap7_sram_wrappers.sv` 中的可选适配器。两种形式均绑定到相同的 native cell，并获得相同的时序、功耗和面积处理。

## Native 接口

每个允许的 native macro 具有以下 active-high 接口：

```systemverilog
module <macro> (
    input              clk,
    input  [AW-1:0]    ADDRESS,
    input  [DW-1:0]    wd,
    input              banksel,
    input              read,
    input              write,
    output reg [DW-1:0] dataout
);
```

操作发生在 `posedge clk` 且 `banksel` 为高时。写操作更新所选字。读操作更新 `dataout`；否则 `dataout` 保持先前值。同时 `read=1` 和 `write=1` 执行写操作，因为锁定的行为模型给予写优先权。竞赛 RTL 不得依赖此情况，每次访问最多只能驱动 `read` 和 `write` 之一为高。

存储器无复位，未初始化位置的值未指定。字节写使能不可用。需要字节写的设计必须使用读-改-写、banking 或标准单元存储。

## 允许的 macro 和视图

以下路径相对于锁定的 SRAM 仓库检出目录。

| Native cell | 组织 | Verilog 和 Liberty 地址宽度 | LEF 尺寸 (um) | 面积 (um^2) |
|---|---:|---:|---:|---:|
| `srambank_64x4x32_6t122` | 256x32 | 8 | 9.612 x 43.2 | 415.2384 |
| `srambank_128x4x32_6t122` | 512x32 | 9 | 16.0 x 43.2 | 691.2 |
| `srambank_256x4x32_6t122` | 1024x32 | 10 | 30.348 x 43.2 | 1311.0336 |
| `srambank_64x4x64_6t122` | 256x64 | 8 | 9.612 x 77.76 | 747.42912 |

对于每个 `<macro>`：

- 功能仿真：`generated/verilog/<macro>.v`
- 时序和功耗：`generated/LIB/<macro>.lib`
- 尺寸和物理抽象：`generated/LEF/<macro>.lef`

锁定的 Liberty 文件声明 cell `area : 0`。评测流程因此从对应的 LEF `SIZE` 添加 macro 面积；不得从 Liberty `area` 字段获取 SRAM 面积。Liberty 仍然是时序和内部功耗的权威来源。

## 工具绑定

- Verilator 读取提交的 RTL、可选 wrapper 和四个锁定的行为 Verilog 文件
- Yosys 将 native cell 作为库/blackbox cell 读取并保留其实例；不得综合行为 `mem` 阵列
- OpenSTA 读取映射后网表、ASAP7 标准单元 Liberty 和每个实例化 SRAM macro 的 Liberty 文件
- 面积报告步骤使用上表中的 LEF 面积计算每个 native macro 实例

`ASAP7_SRAM_LOCK.sha256` 记录所有十二个视图的精确预期内容。
