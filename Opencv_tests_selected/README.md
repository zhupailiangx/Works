## Linux OpenCV select
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


