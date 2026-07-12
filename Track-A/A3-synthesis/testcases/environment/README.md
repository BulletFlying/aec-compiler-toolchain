# 指定运行环境

正式镜像：`my_siliconcompiler_image:latest`

冻结镜像 ID：

```text
sha256:cf58004bd15d8d67677812e91ccdebe8da1b17dfab1a0390b96c7f568b74f42a
```

已确认主要工具版本：

| 工具 | 版本/路径 |
| --- | --- |
| Yosys | 0.54 (`/root/.local/bin/yosys`) |
| Berkeley ABC | Yosys 随附 (`/root/.local/bin/yosys-abc`) |
| OpenSTA | 2.7.0 (`/usr/local/bin/sta`) |
| Icarus Verilog | 10.3 (`/usr/bin/iverilog`) |

镜像约 44.9 GB，不包含在竞赛包内。正式比赛前，主办方将通过以下一种或多种方式提供：Docker Hub、百度网盘 Docker tar 包、已预装镜像的评测服务器。

## 每个 point 的资源限制

- 1 个 CPU 核。
- 1 个综合线程，不得主动创建并行综合 worker。
- 10 GiB 内存。
- 网络关闭。
- 从相同的已构建源码快照独立启动，不共享前一个 point 的运行缓存。

评测容器会固定单个 CPU，并设置常见线程环境变量为 1：

```text
OMP_NUM_THREADS=1
OPENBLAS_NUM_THREADS=1
MKL_NUM_THREADS=1
NUMEXPR_NUM_THREADS=1
MAKEFLAGS=-j1
```

评测调用本身不设置并行 `make`。工具即使在一个 CPU 上创建多个工作线程，也属于违反单线程要求。
