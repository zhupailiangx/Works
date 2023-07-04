@echo off

call C:\"Program Files (x86)"\Intel\oneAPI\setvars.bat
call  C:\"Program Files (x86)"\Intel\oneAPI\setvars-vcvarsall.bat
rem env setting
rem  *******************************************************************************
set PATH=%PATH%;C:\Program Files (x86)\Intel\oneAPI\compiler\2023.0.0\windows\bin;C:\Program Files (x86)\Intel\oneAPI\ipp\latest\redist\intel64;C:\Program Files (x86)\Intel\oneAPI\ipp\latest\redist\intel64\tl\tbb;C:\Program Files (x86)\opencv\build\x64\vc15\bin
rem  *******************************************************************************



rem build
rem  *******************************************************************************

if not exist compilation\ (
	mkdir compilation
)
cd compilation\




echo ------------------------------------------build: OpenCV_GPU_ESIMD------------------------------------------
if not exist OpenCV_GPU_ESIMD\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"GPU Implementation"\DirectProgramming\ESIMD .\OpenCV_GPU_ESIMD\ /E
	cd .\OpenCV_GPU_ESIMD
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_GPU_Canny------------------------------------------
if not exist OpenCV_GPU_Canny\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"GPU Implementation"\Practices\Canny .\OpenCV_GPU_Canny\ /E
	cd .\OpenCV_GPU_Canny
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_GPU_Dilation------------------------------------------
if not exist OpenCV_GPU_Dilation\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"GPU Implementation"\Practices\Dilation .\OpenCV_GPU_Dilation\ /E
	cd .\OpenCV_GPU_Dilation
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_GPU_Erosion------------------------------------------
if not exist OpenCV_GPU_Erosion\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"GPU Implementation"\Practices\Erosion .\OpenCV_GPU_Erosion\ /E
	cd .\OpenCV_GPU_Erosion
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_GPU_GaussianBlur------------------------------------------
if not exist OpenCV_GPU_GaussianBlur\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"GPU Implementation"\Practices\GaussianBlur .\OpenCV_GPU_GaussianBlur\ /E
	cd .\OpenCV_GPU_GaussianBlur
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_GPU_MeanBlur------------------------------------------
if not exist OpenCV_GPU_MeanBlur\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"GPU Implementation"\Practices\MeanBlur .\OpenCV_GPU_MeanBlur\ /E
	cd .\OpenCV_GPU_MeanBlur
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)


echo ------------------------------------------build: OpenCV_GPU_MorphOpen------------------------------------------
if not exist OpenCV_GPU_MorphOpen\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"GPU Implementation"\Practices\MorphOpen .\OpenCV_GPU_MorphOpen\ /E
	cd .\OpenCV_GPU_MorphOpen
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_GPU_SobelGradient------------------------------------------
if not exist OpenCV_GPU_SobelGradient\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"GPU Implementation"\Practices\SobelGradient .\OpenCV_GPU_SobelGradient\ /E
	cd .\OpenCV_GPU_SobelGradient
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------------

ping -n 5 127.0.0.1 > nul 


rem test
echo ------------------------------------------test: OpenCV_GPU_ESIMD------------------------------------------
cd .\OpenCV_GPU_ESIMD
.\build\Release\histogram.exe 
ping -n 5 127.0.0.1 > nul 
cd ..\

echo ------------------------------------------test: OpenCV_GPU_Canny------------------------------------------
cd .\OpenCV_GPU_Canny
set SYCL_DEVICE_FILTER=opencl:gpu
.\build\Release\canny.exe 
ping -n 5 127.0.0.1 > nul 
set SYCL_DEVICE_FILTER=
cd ..


echo ------------------------------------------test: OpenCV_GPU_Dilation------------------------------------------
cd .\OpenCV_GPU_Dilation
set SYCL_DEVICE_FILTER=opencl:gpu
.\build\Release\dilation.exe 
ping -n 5 127.0.0.1 > nul 
set SYCL_DEVICE_FILTER=
cd ..

echo ------------------------------------------test: OpenCV_GPU_Erosion------------------------------------------
cd .\OpenCV_GPU_Erosion
set SYCL_DEVICE_FILTER=opencl:gpu
.\build\Release\erosion.exe 
ping -n 5 127.0.0.1 > nul 
set SYCL_DEVICE_FILTER=
cd ..

echo ------------------------------------------test: OpenCV_GPU_GaussianBlur------------------------------------------
cd .\OpenCV_GPU_GaussianBlur
set SYCL_DEVICE_FILTER=opencl:gpu
.\build\Release\gaussian3.exe 
ping -n 5 127.0.0.1 > nul 
.\build\Release\gaussian5.exe 
ping -n 5 127.0.0.1 > nul 
set SYCL_DEVICE_FILTER=
cd ..

echo ------------------------------------------test: OpenCV_GPU_MeanBlur------------------------------------------
cd .\OpenCV_GPU_MeanBlur
set SYCL_DEVICE_FILTER=opencl:gpu
.\build\Release\meanBlur.exe
ping -n 5 127.0.0.1 > nul  
set SYCL_DEVICE_FILTER=
cd ..

echo ------------------------------------------test: OpenCV_GPU_MorphOpen------------------------------------------
cd .\OpenCV_GPU_MorphOpen
set SYCL_DEVICE_FILTER=opencl:gpu
.\build\Release\morphOpen.exe 
ping -n 5 127.0.0.1 > nul 
set SYCL_DEVICE_FILTER=
cd ..

echo ------------------------------------------test: OpenCV_GPU_SobelGradient------------------------------------------
cd .\OpenCV_GPU_SobelGradient
set SYCL_DEVICE_FILTER=opencl:gpu
.\build\Release\gradient-magnitude-sum.exe 
ping -n 5 127.0.0.1 > nul 
.\build\Release\gradient-magnitude-hypot.exe 
ping -n 5 127.0.0.1 > nul 
set SYCL_DEVICE_FILTER=
cd ..


rem  *******************************************************************************


PAUSE