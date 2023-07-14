# OpenCV MatchTemplate 算子Linux和Windows性能差异分析
分析方式:安装方式和Vtune

## Windows 安装
(1) https://github.com/opencv/opencv/releases/tag/4.5.5 中下载exe文件安装

(2)
```
download source code
open cmd
cd <opencv code dir>
mkdir build
cd build
cmake -D WITH_IPP=ON/OFF
cmake --build . --target INSTALL
```

![Screenshot from 2023-07-13 08-16-21](https://github.com/zhupailiangx/Works/assets/120553507/35179a4b-602b-4f0a-891a-c9953257d663)


## windows exe 
opencv match template took 13.025 milliseconds
opencv match template took 11.083 milliseconds
opencv match template took 11.847 milliseconds
opencv match template took 12.067 milliseconds
opencv match template took 11.203 milliseconds
opencv match template took 11.896 milliseconds
opencv match template took 12.263 milliseconds
opencv match template took 12.429 milliseconds
opencv match template took 11.097 milliseconds
opencv match template took 11.662 milliseconds
opencv     took average 11.857 milliseconds
![image](https://github.com/zhupailiangx/Works/assets/120553507/f8e7857d-4658-473b-984b-9bfc5caf9edd)

## windows souece code WITH_IPP=OFF
opencv match template took 32.068 milliseconds
opencv match template took 31.659 milliseconds
opencv match template took 31.753 milliseconds
opencv match template took 31.333 milliseconds
opencv match template took 32.464 milliseconds
opencv match template took 31.516 milliseconds
opencv match template took 33.159 milliseconds
opencv match template took 31.737 milliseconds
opencv match template took 32.896 milliseconds
opencv match template took 32.580 milliseconds
opencv     took average 32.116 milliseconds
![image](https://github.com/zhupailiangx/Works/assets/120553507/d94cfefe-7c90-4b49-b738-034cab94b260)

## windows souce code WITH_IPP=ON
opencv match template took 12.727 milliseconds
opencv match template took 11.319 milliseconds
opencv match template took 11.297 milliseconds
opencv match template took 11.595 milliseconds
opencv match template took 11.239 milliseconds
opencv match template took 12.118 milliseconds
opencv match template took 11.787 milliseconds
opencv match template took 11.843 milliseconds
opencv match template took 11.408 milliseconds
opencv match template took 12.206 milliseconds
opencv     took average 11.754 milliseconds

![image](https://github.com/zhupailiangx/Works/assets/120553507/559be1b3-65bc-425a-9f0c-cb03aa8bb995)
