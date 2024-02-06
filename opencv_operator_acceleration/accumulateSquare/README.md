## 函数介绍
该函数将输入图像 src 或其选定区域（提高到 2 的幂）添加到累加器 dst

## 参数
src 输入图像，有1- 或3-通道，8-位或32-位浮点类型。

dst 累加图像，与输入图像有相同的通道数，32-位或64-位浮点类型。

mask 可选的操作屏蔽。

## 运行
```
mkdir build
cd build
cmake ..
make
./accumulateSquare
```
