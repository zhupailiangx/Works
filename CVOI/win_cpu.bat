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



echo ------------------------------------------build: OpenCV_CPU_Dilate------------------------------------------
if not exist OpenCV_CPU_Dilate\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\Dilate .\OpenCV_CPU_Dilate\ /E
	cd .\OpenCV_CPU_Dilate
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_CPU_GaussianBlur------------------------------------------
if not exist OpenCV_CPU_GaussianBlur\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\GaussianBlur .\OpenCV_CPU_GaussianBlur\ /E
	cd  .\OpenCV_CPU_GaussianBlur
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_CPU_Histogram------------------------------------------
if not exist OpenCV_CPU_Histogram\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\Histogram .\OpenCV_CPU_Histogram\ /E
	cd .\OpenCV_CPU_Histogram
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_CPU_ImageDiff------------------------------------------
if not exist OpenCV_CPU_ImageDiff\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\ImageDiff .\OpenCV_CPU_ImageDiff\ /E
	cd .\OpenCV_CPU_ImageDiff
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release
	cd ..\..\
)


echo ------------------------------------------build: OpenCV_CPU_MatchTemplate------------------------------------------
if not exist OpenCV_CPU_MatchTemplate\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\MatchTemplate .\OpenCV_CPU_MatchTemplate\ /E
	cd .\OpenCV_CPU_MatchTemplate
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_CPU_MeanBlur------------------------------------------
if not exist OpenCV_CPU_MeanBlur\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\MeanBlur .\OpenCV_CPU_MeanBlur\ /E
	cd .\OpenCV_CPU_MeanBlur
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release --target mean-blur
	cd ..\..\
)


echo ------------------------------------------build: OpenCV_CPU_MorphOpen------------------------------------------
if not exist OpenCV_CPU_MorphOpen\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\MorphOpen .\OpenCV_CPU_MorphOpen\ /E
	cd .\OpenCV_CPU_MorphOpen
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_CPU_Resize------------------------------------------
if not exist OpenCV_CPU_Resize\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\Resize .\OpenCV_CPU_Resize\ /E
	cd .\OpenCV_CPU_Resize
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_CPU_SobelGradient------------------------------------------
if not exist OpenCV_CPU_SobelGradient\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\SobelGradient .\OpenCV_CPU_SobelGradient\ /E
	cd .\OpenCV_CPU_SobelGradient
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\
)

echo ------------------------------------------build: OpenCV_CPU_WarpAffine------------------------------------------
if not exist OpenCV_CPU_WarpAffine\ (
	xcopy ..\Reference-Optimized-Implementation\Optimized-OpenCV-Operators\"CPU Implementation"\WarpAffine .\OpenCV_CPU_WarpAffine\ /E
	cd .\OpenCV_CPU_WarpAffine\win
	mkdir build
	cd build
	cmake ..
	cmake --build . --config Release 
	cd ..\..\..\
)


echo  ------------------------------------------------------------------------------------
echo  ------------------------------------------------------------------------------------
echo  ------------------------------------------------------------------------------------
ping -n 5 127.0.0.1 > nul 


rem test
rem  *******************************************************************************
echo ------------------------------------------test: OpenCV_CPU_Dilate------------------------------------------
cd .\OpenCV_CPU_Dilate\build
.\Release\cv_dilate.exe ..\data\color_4288.jpg
ping -n 5 127.0.0.1 > nul 
cd ..\..

echo ------------------------------------------test: OpenCV_CPU_GaussianBlur------------------------------------------
cd .\OpenCV_CPU_GaussianBlur
.\build\src\Release\gaussian-blur.exe 
ping -n 5 127.0.0.1 > nul 
cd ..\

echo ------------------------------------------test: OpenCV_CPU_Histogram------------------------------------------
cd .\OpenCV_CPU_Histogram\build
.\Release\ipp_histogram.exe 
ping -n 5 127.0.0.1 > nul 
cd ..\..\

echo ------------------------------------------test: OpenCV_CPU_ImageDiff------------------------------------------
cd .\OpenCV_CPU_ImageDiff\build
.\Release\absdiff_opt.exe
ping -n 5 127.0.0.1 > nul 
cd ..\..\

echo ------------------------------------------test: OpenCV_CPU_MatchTemplate------------------------------------------
cd .\OpenCV_CPU_MatchTemplate\build\
.\Release\match_template.exe
ping -n 5 127.0.0.1 > nul 
cd ..\..\

echo ------------------------------------------test: OpenCV_CPU_MeanBlur------------------------------------------
cd .\OpenCV_CPU_MeanBlur
.\build\src\Release\mean-blur.exe
ping -n 5 127.0.0.1 > nul 
cd ..\

echo ------------------------------------------test: OpenCV_CPU_MorphOpen------------------------------------------
cd .\OpenCV_CPU_MorphOpen
.\build\src\Release\MorphOpen-3.exe
ping -n 5 127.0.0.1 > nul 
.\build\src\Release\MorphOpen-5.exe
ping -n 5 127.0.0.1 > nul 
cd ..\

echo ------------------------------------------test: OpenCV_CPU_Resize------------------------------------------
cd .\OpenCV_CPU_Resize\build
.\Release\resize.exe ..\data\image2.jpg
ping -n 5 127.0.0.1 > nul 
cd ..\..\

echo ------------------------------------------test: OpenCV_CPU_SobelGradient------------------------------------------
cd .\OpenCV_CPU_SobelGradient
.\build\src\Release\gradient-magnitude-hypot.exe 
ping -n 5 127.0.0.1 > nul 
.\build\src\Release\gradient-magnitude-sum.exe 
ping -n 5 127.0.0.1 > nul 
cd ..\

echo ------------------------------------------test: OpenCV_CPU_WarpAffine------------------------------------------
cd .\OpenCV_CPU_WarpAffine\win
.\build\Release\ipp_affine.exe 
ping -n 5 127.0.0.1 > nul 
cd ..\..\

rem  *******************************************************************************


PAUSE