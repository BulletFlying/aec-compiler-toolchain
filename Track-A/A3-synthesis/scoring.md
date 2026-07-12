# A3：轻量 RTL 逻辑综合工具 - 评分细则

## 总分：100 分

| 类别 | 分值 |
|------|-----:|
| PPA Hypervolume | 90 |
| 运行时间 | 5 |
| 原创性 | 5 |

## 1. 统一 PPA 评测

组委会使用 Nangate45 typical Liberty 和统一的 OpenSTA 脚本重新评测所有正确网表。评测 SDC 将时钟周期、输入/输出延迟和最大延迟设为 0，同时保留驱动/负载和复位 false path：

```text
arrival_ns = max(0, -WNS)
```

面积为实例化标准单元 Liberty 面积之和。`arrival` 和 `area` 均为越小越好。

## 2. PPA Hypervolume

对于电路 `i`，官方 7 个成功 point 产生参考 Pareto 前沿 `P_ref_i`。固定 nadir 点：

```text
z_i = (1.05 * max(r_arrival), 1.05 * max(r_area))
```

设 `S_i` 为该电路参赛者所有正确 point。2D 支配超体积得分：

```text
Q_PPA_i = min(2, HV(S_i, z_i) / HV(P_ref_i, z_i))
```

提交单个 point 使用单例集合；多个互补 point 可覆盖更完整的面积/时序权衡。参考前沿对应 `Q_PPA_i = 1`；超过参考继续线性累加；上限为 2 倍超体积。

## 3. 运行时间与每电路得分

`T_ref_i` 为所有 7 个官方参考点的总 wall time；`T_user_i` 为所有尝试 point 的总 `make synth` wall time（含失败），不包括 build、仿真和 OpenSTA 评测：

```text
Q_time_i = min(1, T_ref_i / T_user_i)
Score_i = G_i * (45 * Q_PPA_i + 5 * Q_time_i)
S_tech = (1/20) * sum(Score_i)
```

其中 `G_i = 1` 表示至少一个 point 通过正确性，否则 `G_i = 0`。每电路技术分范围：0-95。20 个电路的平均分 `S_tech` 同样为 0-95；PPA 最多贡献 90 分，运行时间最多 5 分。

当提交超体积等于参考且运行时间不慢于参考时，该电路得 50 分；2 倍参考超体积且满分运行时间时，该电路得 95 分。

## 4. 原创性加分

队伍在 `submission.yaml` 中声明两种类型之一：

- `open_source_based`：基于或调用开源 EDA 工具构建
- `from_scratch`：综合核心流水线由队伍独立实现

两种类型技术评分相同。原创性按五项标准评估，每项 0 至 1 分：

1. 源代码自主性
2. 算法贡献
3. 核心完整性
4. 消融证据
5. 可复现性与答辩

```text
S_final = S_tech + S_originality <= 100
0 <= S_originality <= 5
```

最终总分固定为 100：PPA 90、运行时间 5、原创性 5。

开源工具能力不计为队伍原创贡献，但在此之上新增的 pass、代价模型、搜索方法和映射算法可凭证据得分。LLM 辅助开发不自动扣分但必须披露并可解释/可复现。

## 5. 禁止事项

- 未披露抄袭他队代码
- 评测期间调用外部服务
- 读取隐藏电路标识进行针对性优化
- 提交预计算网表
- 创建违反资源限制的并行综合 worker
