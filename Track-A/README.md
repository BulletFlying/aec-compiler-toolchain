# 赛道 A：EDA 软件

> 参赛队伍选择本赛道后完成 **A1 + A2 + A3 全部题目**。
> 本赛道自研工具将为赛道 B 的 RTL 代码提供仿真、验证与综合 PPA 评估服务。

## 赛题列表

| 编号 | 赛题 | 赛题说明 | 评分细则 | 公开测试集 |
|------|------|----------|----------|-----------|
| A1 | 轻量 RTL 仿真器 | [spec.md](A1-simulator/spec.md) | [scoring.md](A1-simulator/scoring.md) | [testcases/](A1-simulator/testcases/) |
| A2 | 验证环境自动生成 | [spec.md](A2-verification/spec.md) | [scoring.md](A2-verification/scoring.md) | [testcases/](A2-verification/testcases/) |
| A3 | 轻量 RTL 逻辑综合工具 | [spec.md](A3-synthesis/spec.md) | [scoring.md](A3-synthesis/scoring.md) | [testcases/](A3-synthesis/testcases/) |

## 赛道总览

赛道 A 聚焦于**自研 EDA 工具**，包含三个独立评分的子题：

```text
A1 仿真器        -> 为赛道 B 提供轻量级 RTL 仿真能力
A2 验证生成器    -> 为赛道 B 自动生成验证环境
A3 逻辑综合工具  -> 为赛道 B 提供 PPA 评估反馈
```

## 评分总则

**赛道 A 分为 A1、A2、A3 三道赛题，每道原始满分均为 100 分。最终赛道总分为三道题归一化后等权平均，满分为 100 分。**

```text
赛道总分 = (A1归一化分 + A2归一化分 + A3归一化分) / 3
A1归一化分 = (A1原始得分 / 100) x 100
A2归一化分 = (A2原始得分 / 100) x 100
A3归一化分 = (A3原始得分 / 100) x 100
```

> **示例**：A1 得 70 分、A2 得 80 分、A3 得 60 分，则赛道总分 = (70 + 80 + 60) / 3 = 70 分。

| 赛题 | 原始满分 | 评分构成 |
|------|----------|----------|
| A1 轻量 RTL 仿真器 | 100 | 语言解析 (F1) + 正确性 (F2) + 编译性能 (P1) + 仿真性能 (P2) + 多核加速比 (P3) |
| A2 验证环境自动生成 | 100 | 10 电路 x 10 分（骨架 3 + 覆盖率 7） |
| A3 逻辑综合工具 | 100 | PPA Hypervolume 90 + Runtime 5 + 原创性 5 |

## 提交规范

| 子题 | 必交文件 |
|------|----------|
| A1 | `Makefile` + 仿真器源码 |
| A2 | `run.sh` 或 `run.py` + 源码 + `requirements.txt` |
| A3 | `Makefile` + `submission.yaml` + `config.json` + `ORIGINALITY_DECLARATION.md` + `THIRD_PARTY.md` + `src/` |

## 环境约束

| 子题 | 环境 |
|------|------|
| A1 | Linux x86_64，评测系统提供 filelist |
| A2 | Linux x86_64，Python 3.10+，允许 Z3/PyVerilog |
| A3 | 冻结 Docker 镜像 `my_siliconcompiler_image:latest`，Yosys 0.54 / OpenSTA 2.7.0 / Icarus 10.3 |
