# Makefile 接口速查

## Point 配置

提交根目录必须包含 `config.json`。顶层 key 是 circuit ID，保留 `$default` 作为未覆盖题和隐藏题的回退；value 是 point 配置数组：

```json
{
  "$default": [
    {"passes": ["balance", "rewrite"], "objective": "balanced"}
  ],
  "LSV01": [
    {"abc_sequence": "compress2rs; dch; amap"},
    {"abc_sequence": ["if -K 6 -g -C 8", "dch", "map"]}
  ]
}
```

数组长度必须为 1 到 7，决定该 circuit 运行几个 points。数组元素可以是 object、string、array、number、boolean 或 null；评测器只读取数组长度，不解释参数。选手工具必须解析 `CONFIG`，选择 `config[CIRCUIT]`，不存在时选择 `config["$default"]`，再使用 `POINT-1` 对应的元素。

## 固定命令

```bash
make -j1 build
make -j1 synth RTL=/benchmark/case/rtl/design.v \
  TOP=<top-module> \
  SDC=/benchmark/case/constraints.sdc \
  LIBERTY=/benchmark/lib/NangateOpenCellLibrary_typical.lib \
  CONFIG=/submission/config.json \
  CIRCUIT=LSV01 \
  POINT=1 \
  OUT_DIR=/output
make clean
```

## 必需结果

- `make build` 返回 0，并生成可执行文件 `bin/synth_tool`。
- `make synth` 返回 0，并生成非空文件 `/output/netlist.v`。
- 网表顶层模块名必须与 `TOP` 完全一致。
- 网表只能实例化 `LIBERTY` 中允许的 Nangate45 标准单元，不得有黑盒、未解析 `$` cell 或题目特化的预计算模块。
- `CONFIG` 指向提交根目录的 `config.json`，`CIRCUIT` 是当前题目 ID。
- `POINT` 从 1 开始，最大值等于当前 circuit 配置数组长度，且不超过 7。
- 评测器不向工具传递已解析后的参数；解析和实现优化序列是选手工具职责。

## 计时边界

`build` 每份提交执行一次，不计入综合 runtime。每个 point 的计时从调用 `make synth` 前开始，到命令退出时结束。失败 point 的运行时间仍计入该 circuit 的总时间。

## 正确性

主办方使用固定隐藏 testbench 和随机种子分别仿真原 RTL 与 `netlist.v`，比较逐周期输出 trace。网表仿真使用 `lib/nangate45/NangateOpenCellLibrary.v` 功能模型，不加载 SDF。每个 point 必须通过全部规定向量才能参与 PPA 计算。
