# AEC GPGPU 公开参考测试集 v1

本包包含竞赛测试用例的非穷尽参考子集。展示 AEC 二进制布局、测试用例清单、启动和内存产物、预期输出表示、比对策略，以及部分指令和 kernel 行为。

**本包不是覆盖率承诺。** 隐藏评测可使用竞赛规范定义的任何合法指令、类型、操作数组合、启动形状、内存空间或行为。隐藏测试使用相同的已发布清单/结果接口版本。

## 测试用例结构

每个用例存储在 `tests/aec_cases/<case-path>/` 下，可能包含：

- `case.yaml`：启动、内存初始化、预期结果、比对和超时
- `program.aec`：可审查的 AEC 汇编源码
- `program.bin`：DUT 和 CModel 消费的 128-bit AEC 指令
- `program.hex`：同一二进制的 MSB-first 审查形式
- `input/` 和 `expected/`：二进制内存产物
- `generate.py`：独立的输入/预期生成器（如适用）
- `build.json`：源码和二进制溯源

## 公开用例（共 36 个）

| 类别 | 用例路径 | 描述 |
|------|----------|------|
| **ABI** | `abi/c0_smoke` | 基础冒烟测试 |
| **算术** | `add/c1_normal_simt` | 常规 SIMD 加法 |
| | `add/c2_boundary_simt` | 边界值加法 |
| | `mul/c1_normal_simt` | 乘法 |
| | `div/c1_normal_simt` | 除法 |
| | `fma/c1_normal_simt` | 融合乘加 |
| **逻辑/位** | `bfx/c1_normal_simt` | 位域提取 |
| | `popc/c1_normal_simt` | 人口计数 |
| **类型转换** | `cvtff/c1_normal_simt` | 浮点到浮点转换 |
| **比较** | `cmp/c1_normal_simt` | 比较到整数结果 |
| | `cmpp/c1_normal_simt` | 比较到谓词 |
| | `sel/c1_normal_simt` | 谓词选择 |
| | `cpy/c1_normal_simt` | 拷贝 |
| | `loadi64/c1_normal_simt` | 64 位立即数加载 |
| **内存** | `ld/c1_normal_simt` | 加载 |
| | `st/c1_normal_simt` | 存储 |
| | `ldc/c1_normal_simt` | 常量缓冲区加载 |
| | `atom/c1_normal_simt` | 原子操作 |
| | `atom/c2_boundary_simt` | 原子操作边界情况 |
| **控制流** | `brx/c1_normal_simt` | 条件分支 |
| | `call/c1_normal_simt` | 子程序调用 |
| | `ret/c1_normal_simt` | 子程序返回 |
| | `mbar/c1_normal_simt` | 内存屏障 |
| | `sync_ct/c1_normal_simt` | CTA 同步 |
| | `sync_ct/c2_boundary_simt` | CTA 同步边界 |
| **通信** | `shuf/c1_normal_simt` | Warp shuffle |
| | `vote/c1_normal_simt` | Warp vote |
| | `mtch/c1_normal_simt` | 线程匹配 |
| **SFU** | `rcp/c1_normal_simt` | 倒数 |
| | `sqrt/c1_normal_simt` | 平方根 |
| | `rdtsc/c1_normal_simt` | 读时间戳计数器 |
| **跨领域** | `cross/t_partial_warp` | 部分 warp 执行 |
| | `cross/t_memory_boundary` | 内存边界条件 |
| **Kernel** | `kernels/vadd` | 向量加法 kernel |
| | `kernels/gemm_naive` | 朴素矩阵乘法 |
| | `kernels/histogram` | 直方图 kernel |

`PUBLIC_CASES.txt` 为本归档的权威清单。
