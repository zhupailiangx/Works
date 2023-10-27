## Linux OpenCV select
有两种方法
### 第一个方法
下载opencv 源码 https://github.com/opencv/opencv/archive/refs/tags/4.8.0.zip, 
下载 one_script_opencv_tests.sh 和opencv_test_results_to_excel.py,放到opencv 目录下
```
sh one_script_opencv_tests.sh
```

---
**第二个**
### 环境准备
```
sudo apt update
sudo apt install cmake
sudo apt install g++
sudo apt install python3-pip
pip install pandas
pip install openpyxl
pip install lxml
```
### opencv 测试编译及结果输出到ods
下载opencv 源码 https://github.com/opencv/opencv/archive/refs/tags/4.8.0.zip, 

下载 opencv_test_selected.sh,放到opencv 目录下
```
sh opencv_test_selected.sh
```
注： **bitwise_not::Size_MatType::(1920x1080, 8UC1)** 算子默认最大samples=200,如果需要修改成1000，请将perf_bitwise.cpp 20行
```
declare.iterations(200);
```
修改成
```
declare.iterations(1000);
```

### ods结果到excel
下载 opencv_test_results_to_excel.py 到opencv/build/bin

#### 查看参数
```
python3 opencv_test_results_to_excel.py --h

options:
  -h, --help            show this help message and exit
  --input_path INPUT_PATH
                        input ods file
  --output_path OUTPUT_PATH
                        result excel file
  --Skew SKEW           Machine type
  --File_Name FILE_NAME
                        Moudle
  --Memory_type MEMORY_TYPE
                        Memory type
  --OS OS               OS version
  --OpenCV_version OPENCV_VERSION
                        OpenCV version
  --OpenCV_install OPENCV_INSTALL
                        OpenCV install
  --OpenCL OPENCL       OpenCL
  --Memory_Speed MEMORY_SPEED
                        Memory Speed
  --WW WW               Weeks
  --CPU_req CPU_REQ     CPU base frequency
```


#### 修改参数(eg: 12700 core moudle) 输出到excel
```
python3 opencv_test_results_to_excel.py --input_path core_selected.ods --output_path core_selected.xlsx --Skew 12700 --File_Name core --Memory_type DDR4 --WW WW40 --Memory_Speed 3200MT/s --CPU_req 2100MHz
```
#### 自动查询参数输出到excel
```
python3 opencv_test_results_to_excel.py --input_path core_selected.ods --output_path core_selected.xlsx --Skew $(cat /proc/cpuinfo | grep "model name" | awk '{print $NF}' | head -n 1) --OS $(lsb_release -d |  awk '{print $2" "$3}') --File_Name core --Memory_type $(sudo dmidecode -t memory | grep "Type:" | awk '{print $2}' | grep 'DDR' | head -n 1) --WW WW40 --Memory_Speed $(sudo dmidecode -t memory | awk '/Speed:.*MT\/s/ {gsub(/.*Speed:/,""); gsub(/ MT\/s.*/,"MT/s");print;exit}') --CPU_req $(cat /sys/devices/system/cpu/cpu0/cpufreq/base_frequency | tr -d '\n' | rev | cut -c 4-7 | rev | awk '{print $1 "MHz"}')
```

```
python3 opencv_test_results_to_excel.py --input_path imgproc_selected.ods --output_path imgproc_selected.xlsx --Skew $(cat /proc/cpuinfo | grep "model name" | awk '{print $NF}' | head -n 1) --OS $(lsb_release -d |  awk '{print $2" "$3}') --File_Name imgproc --Memory_type $(sudo dmidecode -t memory | grep "Type:" | awk '{print $2}' | grep 'DDR' | head -n 1) --WW WW40 --Memory_Speed $(sudo dmidecode -t memory | awk '/Speed:.*MT\/s/ {gsub(/.*Speed:/,""); gsub(/ MT\/s.*/,"MT/s");print;exit}') --CPU_req $(cat /sys/devices/system/cpu/cpu0/cpufreq/base_frequency | tr -d '\n' | rev | cut -c 4-7 | rev | awk '{print $1 "MHz"}')
```

```
python3 opencv_test_results_to_excel.py --input_path objdetect_selected.ods --output_path objdetect_selected.xlsx --Skew $(cat /proc/cpuinfo | grep "model name" | awk '{print $NF}' | head -n 1) --OS $(lsb_release -d |  awk '{print $2" "$3}') --File_Name objdetect --Memory_type $(sudo dmidecode -t memory | grep "Type:" | awk '{print $2}' | grep 'DDR' | head -n 1) --WW WW40 --Memory_Speed $(sudo dmidecode -t memory | awk '/Speed:.*MT\/s/ {gsub(/.*Speed:/,""); gsub(/ MT\/s.*/,"MT/s");print;exit}') --CPU_req $(cat /sys/devices/system/cpu/cpu0/cpufreq/base_frequency | tr -d '\n' | rev | cut -c 4-7 | rev | awk '{print $1 "MHz"}')
```

