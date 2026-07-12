# C2：主机侧驱动与 Runtime - 评分细则

## 总分：100 分

| 模块 | 分值 | 内容 |
|------|-----:|------|
| Runtime | 30 | 查询、错误、内存、拷贝、Stream、Event、Launch |
| 计算库 | 30 | GEMM（10 种 dtype）、AXPY、DOT、NRM2 |
| 虚拟驱动 | 20 | 设备 ABI、双 DMA、注册内存、故障恢复 |
| Agent | 20 | DMA 策略和 Kernel image 选择 |

---

## 1. Runtime（30 分）

覆盖 6 项需求（R101-R106）：

| 能力 | 需求 |
|------|------|
| 设备查询 | 设备数量、设备信息 |
| 错误处理 | 线程局部错误状态、错误码 |
| 内存管理 | 分配、释放 |
| 同步拷贝 | H2D、D2H |
| Stream/Event | 创建、销毁、同步、记录 |
| Kernel 启动 | 以 grid/block 维度、参数启动 |

## 2. 计算库（30 分）

### GEMM（10 种数据类型）

| 精度 | API | 评分项 |
|------|-----|--------|
| FP4 E2M1 | `aecMatmulF4` | R202 |
| FP8 E4M3/E5M2 | `aecMatmulF8` | R202 |
| FP16 | `aecMatmulF16` | R202 |
| BF16 | `aecMatmulBF16` | R202 |
| FP32 | `aecMatmulF32` | R201 |
| FP64 | `aecMatmulF64` | R202 |
| INT4 | `aecMatmulI4` | R203 |
| INT8 | `aecMatmulI8` | R203 |
| INT32 | `aecMatmulI32` | R201/R203 |

### 向量运算

- `aecAxpy` - y = alpha * x + y
- `aecDot` - 点积
- `aecNrm2` - L2 范数

## 3. 虚拟驱动（20 分）

| 能力 | 描述 |
|------|------|
| 设备 ABI | 符合 `aec_device_abi.h` |
| 双 DMA | H2D 和 D2H 通道 |
| 注册内存 | 零拷贝内存注册 |
| 故障恢复 | 错误检测与恢复 |

## 4. Agent（20 分）

### DMA Agent

- DMA 通道选择
- Chunk 大小和队列深度优化
- 注册内存的 zero-copy 策略

### Kernel Agent

- 基于 dtype 和 shape 选择候选 image
- 满足 alignment、workspace 和 shape 约束

## 5. 等级要求

| 等级 | 必需能力 |
|------|----------|
| **Basic** | 查询/错误、内存管理、同步拷贝、Vector Add、FP32/INT32 GEMM |
| **Good** | Basic + Stream/Event、异步 DMA、注册内存、全部计算操作、故障恢复 |
| **Excellent** | Good + 两个合法 Agent 并取得足够的性能分 |

## 6. 运行公开测试

```bash
cd starter-kit
make -j2
make examples
./bin/01_device_query
python3 grader/public_grade.py --submission . --profile public
```

公开测试覆盖 R101-R106、R201-R204、R301-R304、R401-R402，用于开发和排错。

## 7. 固定 Kernel Image

竞赛提供 34 个固定 kernel image。参赛者不能添加自定义 image。Kernel Agent 从提供的
合法候选中选择最优 image。
