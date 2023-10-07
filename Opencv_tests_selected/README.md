## Linux
### 环境准备
```
sudo apt install python3-pip
pip install pandas
pip install openpyxl
pip install lxml
```
### opencv 测试编译及结果输出到ods
下载 opencv_test_selected.sh,放到opencv 目录下
```
sh opencv_test_selected.sh
```

### 结果到excel
下载 opencv_test_results_to_excel.py 到opencv/build/bin
修改参数,eg: 12700 core moudle
```
python3 opencv_test_results_to_excel.py --input_path core_selected.ods --output_path core_selected.xlsx --Skew 12700 --File_Name core --Memory_type DDR4 --WW WW40 --Memory_Speed 3200MT/s --CPU_req 2100MHz
```
