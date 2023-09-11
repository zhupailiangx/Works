# objdump

## 统计可执行文件的每个指令集的数量
objdump -d opencv_perf_imgproc | awk -F '\t' '{print $3}' | awk '{print $1}' |sort |uniq -c
