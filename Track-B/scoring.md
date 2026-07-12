# 赛道 B：GPGPU RTL 设计 - 评分细则

## 总分：100 分

| 类别 | 分值 |
|------|-----:|
| 实现正确性 | 50 |
| PPA | 40 |
| 报告 | 10 |

---

## 1. 实现正确性（50 分）

| 子项 | 分值 |
|------|-----:|
| RTL 指令与架构功能 | 40 |
| CModel | 5 |
| RTL/CModel 一致性 | 5 |

### RTL 正确性（40 分）

分值按指令族分配：

| 指令组 | 分值 | 包含指令 |
|--------|-----:|----------|
| ADD-MAX 算术 | 8 | ADD, SUB, MUL, MAD, FMA, DIV, NEG, ABS, MIN, MAX |
| AND-FLO 逻辑/位操作 | 5 | AND, OR, XOR, NOT, SHL, SHR, BFX, BINS, POPC, FLO |
| CMP-PICK 谓词/选择 | 4 | CMP, CMPP, SEL, PICK |
| LD/ST/LDC/ATOM 和内存空间 | 7 | LD, ST, LDC, ATOM (.gmem/.smem/.cmem/.lmem/.pmem) |
| BR/BRX/CALL/RET/HALT/SYNC.CT/MBAR | 6 | BR, BRX, CALL, RET, HALT, SYNC.CT, MBAR |
| CVT*/CPY/LOADI/LOADI64 | 4 | CVTFF, CVTFI, CVTIF, CVTII, CPY, LOADI, LOADI64 |
| SHUF/VOTE/MTCH | 2 | SHUF, VOTE, MTCH |
| RCP-SQRT/RDTSC | 4 | RCP, RSQ, SIN, COS, EXP, LOG, SQRT, RDTSC |

### CModel（5 分）

- 完整的 AEC ISA 解释器，行为与 RTL 一致
- 正确执行所有指令类型

### RTL/CModel 一致性（5 分）

- RTL 和 CModel 之间 cycle-accurate 或指令-accurate 对齐
- 相同 AEC binary 和相同 launch 参数下结果一致

---

## 2. PPA（40 分）

| 子项 | 分值 |
|------|-----:|
| Performance benchmark | 15 |
| 最高频率 | 10 |
| Performance per watt | 8 |
| Performance per area | 7 |

### 吞吐估算

```text
T_i = (W_i * f_max) / C_i
```

其中：
- `W_i` = 有效工作量（由题目定义）
- `C_i` = Verilator 测得的执行周期数
- `f_max` = 官方 ASAP7/OpenSTA flow 得到的最高有效频率

### Performance Benchmark（15 分）

在多个 kernel benchmark 上评测。分数相对于最佳提交。

### 最高频率（10 分）

由官方 OpenSTA flow 使用 ASAP7 PDK 1.7、7.5-track v28、RVT TT NLDM 测得。

### Performance per Watt（8 分）

```text
Perf/Watt = T_i / Power
```

Power 由官方综合/STA flow 估算。

### Performance per Area（7 分）

```text
Perf/Area = T_i / Area
```

Area 为综合的总单元面积。

---

## 3. 报告（10 分）

| 报告内容 | 分值 | 满分条件 |
|----------|-----:|----------|
| 设计说明 | 4 | 架构、pipeline、scheduler、memory、SRAM、关键状态机和取舍完整描述 |
| 验证说明 | 3 | CModel/RTL/testcase/coverage、失败定位和 alignment 证据可复现 |
| PPA、限制与合规 | 3 | 原始报告、指标解释、已知限制、第三方及生成工具声明完整 |

### 设计说明（4 分）

必须覆盖：
- 整体架构和数据流
- Pipeline 级间和 hazard 处理
- Warp scheduler 设计和调度策略
- 存储层次（寄存器文件、shared memory、cache）
- SRAM macro 使用和映射
- 关键状态机和控制逻辑
- 设计权衡理由

### 验证说明（3 分）

必须覆盖：
- CModel 设计和覆盖率
- RTL testbench 结构
- Testcase 设计和覆盖率指标
- 失败定位方法
- RTL/CModel alignment 证据（diff 日志、波形比对）

### PPA、限制与合规（3 分）

必须覆盖：
- 原始 PPA 报告（面积、时序、功耗）
- 指标解读和分析
- 已知限制和未实现功能
- 第三方 IP、生成 RTL 和工具声明

---

## 4. 评分流程

1. **正确性检查**：在 CModel 和 RTL 上运行官方 AEC binary，与预期结果比对
2. **PPA 测量**：使用 ASAP7/OpenSTA flow 综合，测量频率/面积/功耗
3. **Performance benchmark**：运行 kernel benchmark，计算吞吐
4. **报告评审**：人工评审文档质量

## 5. 同分排名

分数相同时：
1. 正确性分高者优先
2. PPA 分高者优先
3. 提交时间早者优先
