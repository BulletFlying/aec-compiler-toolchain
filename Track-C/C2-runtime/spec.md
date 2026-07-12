# C2：主机侧驱动与 Runtime - 赛题说明

## 赛题描述

实现 AEC 虚拟 GPGPU 的 Host Runtime：

```text
libaec.so
```

冲击 Excellent 等级时还需提交：

```text
agents/dma_agent.py
agents/kernel_agent.py
```

本题使用**确定性虚拟设备**——不使用真实 FPGA、Linux 内核驱动或物理 PCIe。所有性能分均使用虚拟周期。

## 1. Runtime API

Runtime 必须导出 `include/aec_runtime.h` 中的全部符号；暂未实现的高等级功能可返回
`AEC_ERROR_NOT_SUPPORTED`。

### 内存管理

- `aecAlloc` - 分配设备内存
- `aecFree` - 释放设备内存
- `aecCopyH2D` - 主机到设备拷贝
- `aecCopyD2H` - 设备到主机拷贝
- `aecCopyAsync` - 异步拷贝

### Kernel 执行

- `aecLaunch(kernel, gridDim, blockDim, args, stream)` - 启动 kernel

### Stream 和 Event

- `aecStreamCreate` - 创建执行流
- `aecStreamSync` - 同步执行流
- `aecEventRecord` - 记录事件

### 设备管理

- `aecDeviceCount` - 查询设备数量
- `aecDeviceInfo` - 查询设备信息

### 错误处理

- 线程局部错误状态

## 2. 计算库

### 多精度 GEMM（10 种数据类型）

| 精度 | API |
|------|-----|
| FP4 E2M1 | `aecMatmulF4` |
| FP8 E4M3/E5M2 | `aecMatmulF8` |
| FP16 | `aecMatmulF16` |
| BF16 | `aecMatmulBF16` |
| FP32 | `aecMatmulF32` |
| FP64 | `aecMatmulF64` |
| INT4 | `aecMatmulI4` |
| INT8 | `aecMatmulI8` |
| INT32 | `aecMatmulI32` |

### 向量运算

- `aecAxpy` - 向量乘加
- `aecDot` - 点积
- `aecNrm2` - 向量 L2 范数

## 3. 虚拟驱动

- 设备 ABI 合规
- 双 DMA 通道（H2D 和 D2H）
- 注册内存（零拷贝）
- 故障恢复

## 4. Agent 接口（Excellent 等级）

每次调用从 stdin 读取一个 JSON，并且只向 stdout 输出一个满足 `schemas/` 约束的 JSON。

### DMA Agent

输入：

```json
{"case_id":1,"direction":"h2d","bytes":4096,"alignment":64,"registered":true,"concurrency":2}
```

输出：

```json
{"channel":0,"chunk_bytes":4096,"queue_depth":2,"use_zero_copy":true}
```

### Kernel Agent

输入：

```json
{"case_id":1,"dtype":"f16","m":128,"n":128,"k":128,"alignment":16,"workspace":8192,"candidates":[{"id":"candidate-1","semantic_kernel_id":2,"image_id":721154,"variant":3,"workspace":4096,"alignment":16,"divisibility":8}]}
```

输出：

```json
{"kernel_id":"candidate-1"}
```

DMA Agent 选择通道、chunk、queue depth 和 zero-copy；Kernel Agent 只能从输入的合法
`candidates` 中选择一个 `kernel_id`。

## 5. 强制执行路径

成功的 `aecLaunch` 和计算接口必须解析固定 image、生成 little-endian 参数块，并通过
`AEC_DEVICE_OP_ISA_LAUNCH` 交给受控设备执行。不得在 Host 侧直接计算结果或使用自定义
Kernel image 绕过规定路径。

## 6. Starter Kit

完整 starter kit 位于 [starter-kit/](starter-kit/)：

| 组件 | 位置 |
|------|------|
| 公共头文件 | `include/aec_runtime.h`、`aec_isa.h`、`aec_device_abi.h` |
| 固定 kernel image | `kernels/images/`（34 个 image） |
| 虚拟设备库 | `lib/libaec_device.so` |
| 起始代码 | `src/aec_runtime.cpp` |
| 示例程序 | `examples/01_device_query.c` ~ `06_registered_copy.c` |
| 公开测试 | `cases/test_r101.py` ~ `test_r402.py` |
| 评分脚本 | `grader/public_grade.py` |
| 文档 | `docs/01_赛题说明.md` ~ `docs/06_提交与公开测试指南.md` |

### 推荐阅读顺序

1. `docs/01_赛题说明.md` - 赛题描述
2. `include/aec_runtime.h` - API 参考
3. `docs/02_Runtime与设备规范.md` - Runtime 和设备规范
4. `docs/03_AEC_ISA规范.md` - AEC ISA 规范
5. `docs/04_数值规范.md` - 数值规范
6. `docs/05_Agent与评分标准.md` - Agent 和评分标准
7. `docs/06_提交与公开测试指南.md` - 提交和公开测试指南

## 7. 环境

- Little-endian Linux
- C ABI
- C++17
- 评测期间无网络访问
