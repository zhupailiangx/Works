#!/bin/bash
source /opt/intel/oneapi/setvars.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/oneapi/ipp/latest/lib/intel64/tl/tbb
echo 
echo ==================== Start build ====================
echo
echo  
echo  
echo ==================== build GPU Implementation DirectProgramming ====================
cd Reference-Optimized-Implementation/Optimized-OpenCV-Operators/"GPU Implementation"/DirectProgramming/ESIMD
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#cd ..
#./build/histogram

echo  
echo ==================== build GPU Implementation Canny ====================
cd ../../..
cd Practices/Canny
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#cd ..
#export SYCL_DEVICE_FILTER=opencl:gpu

#./build/canny 

echo  
echo ==================== build GPU Implementation Dilation ====================
cd ../..
cd Dilation
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#cd ..
#export SYCL_DEVICE_FILTER=opencl:gpu

#./build/dilation

echo  
echo ==================== build GPU Implementation Erosion ====================
cd ../..
cd Erosion
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)

#cd ..
#export SYCL_DEVICE_FILTER=opencl:gpu

#./build/erosion

echo  
echo ==================== build GPU Implementation GaussianBlur ====================
cd ../..
cd GaussianBlur
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)

#cd ..
#export SYCL_DEVICE_FILTER=opencl:gpu
#./build/gaussian3

#./build/gaussian5 


echo  
echo ==================== build GPU Implementation MeanBlur ====================
cd ../..
cd MeanBlur
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)

#cd ..
#export SYCL_DEVICE_FILTER=opencl:gpu

#./build/meanBlur
#cd build


echo  
echo ==================== build GPU Implementation MorphOpen ====================
cd ../..
cd MorphOpen
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)

#cd ..
#export SYCL_DEVICE_FILTER=opencl:gpu

#./build/morphOpen 


echo  
echo ==================== build GPU Implementation SobelGradient ====================
cd ../..
cd SobelGradient
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)


echo 
echo ==================== End build ====================


echo 
echo
echo 
echo ==================== Start testing ====================
echo
echo   
echo
echo   
echo ==================== run GPU Implementation DirectProgramming ESIMD ====================
cd ../../..
cd DirectProgramming/ESIMD
#cd ..
ping -c 5 127.0.0.1 >/dev/null
./build/histogram
cd build


echo
echo   
echo ==================== run GPU Implementation Canny ====================
cd ../../..
cd Practices/Canny
#cd ..
export SYCL_DEVICE_FILTER=opencl:gpu
ping -c 5 127.0.0.1 >/dev/null
./build/canny 
cd build


echo
echo   
echo ==================== run GPU Implementation Dilation ====================
cd ../..
cd Dilation
#cd ..
export SYCL_DEVICE_FILTER=opencl:gpu
ping -c 5 127.0.0.1 >/dev/null
./build/dilation
cd build


echo
echo   
echo ==================== run GPU Implementation Erosion ====================
cd ../..
cd Erosion

#cd ..
export SYCL_DEVICE_FILTER=opencl:gpu
ping -c 5 127.0.0.1 >/dev/null
./build/erosion
cd build


echo
echo  
echo ==================== run GPU Implementation GaussianBlur ====================
cd ../..
cd GaussianBlur
#cd ..
export SYCL_DEVICE_FILTER=opencl:gpu
ping -c 5 127.0.0.1 >/dev/null
./build/gaussian3
ping -c 5 127.0.0.1 >/dev/null
./build/gaussian5 
cd build


echo
echo   
echo ==================== run GPU Implementation MeanBlur ====================
cd ../..
cd MeanBlur

#cd ..
export SYCL_DEVICE_FILTER=opencl:gpu
ping -c 5 127.0.0.1 >/dev/null
./build/meanBlur
cd build


echo
echo   
echo ==================== run GPU Implementation MorphOpen ====================
cd ../..
cd MorphOpen
#cd ..
export SYCL_DEVICE_FILTER=opencl:gpu
ping -c 5 127.0.0.1 >/dev/null
./build/morphOpen 
cd build


echo
echo   
echo ==================== run GPU Implementation SobelGradient ====================
cd ../..
cd SobelGradient
export SYCL_DEVICE_FILTER=opencl:gpu
ping -c 5 127.0.0.1 >/dev/null
./build/gradient-magnitude-sum 

ping -c 5 127.0.0.1 >/dev/null

./build/gradient-magnitude-hypot


echo
echo   
echo ==================== End testing ====================

