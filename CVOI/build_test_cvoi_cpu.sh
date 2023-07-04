#!/bin/bash
source /opt/intel/oneapi/setvars.sh
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/oneapi/ipp/latest/lib/intel64/tl/tbb
echo 
echo ==================== Start build ====================
echo
echo  
echo ==================== build CPU Implementation Dilate ====================
cd Reference-Optimized-Implementation/Optimized-OpenCV-Operators/"CPU Implementation"/Dilate
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#./cv_dilate ../data/color_4288.jpg

echo  
echo ==================== build CPU Implementation GaussianBlur ====================
cd ../..
cd GaussianBlur
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#cd ..
#./build/src/gaussian-blur 


echo  
echo ==================== build CPU Implementation Histogram ====================
cd ../..
cd Histogram
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#./ipp_histogram 

echo  
echo ==================== build CPU Implementation ImageDiff ====================
cd ../..
cd ImageDiff
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#./absdiff_opt 

echo  
echo ==================== build CPU Implementation MatchTemplate ====================
cd ../..
cd MatchTemplate
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#./match_template 

echo  
echo ==================== build CPU Implementation MeanBlur ====================
cd ../..
cd MeanBlur
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)

#cd ..
#./build/src/mean-blur



echo  
echo ==================== build CPU Implementation MorphOpen ====================
cd ../..
cd MorphOpen
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#cd ..
#./build/src/MorphOpen-3
#./build/src/MorphOpen-5

echo  
echo ==================== build CPU Implementation Resize ====================
cd ../..
cd Resize
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#./resize ../data/image2.jpg


echo  
echo ==================== build CPU Implementation SobelGradient ====================
cd ../..
cd SobelGradient
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#cd ..
#./build/src/gradient-magnitude-hypot  

#./build/src/gradient-magnitude-sum

echo  
echo ==================== build CPU Implementation WarpAffine ipp_affine ====================
cd ../..
cd WarpAffine/ipp_affine
if [ ! -d ./build ]; then
   mkdir ./build
fi
cd ./build
cmake ../
make -j$(nproc)
#./ipp_affine

echo 
echo ==================== End build ====================


echo 
echo
echo 
echo ==================== Start testing ====================
echo
echo  
echo  
echo ==================== run CPU Implementation Dilate ====================
cd ../../..
cd Dilate/build
ping -c 5 127.0.0.1 >/dev/null
./cv_dilate ../data/color_4288.jpg


echo
echo   
echo ==================== run CPU Implementation GaussianBlur ====================
cd ../..
cd GaussianBlur
ping -c 5 127.0.0.1 >/dev/null
./build/src/gaussian-blur 
cd build


echo
echo   
echo ==================== run CPU Implementation Histogram ====================
cd ../..
cd Histogram/build
ping -c 5 127.0.0.1 >/dev/null
./ipp_histogram 


echo
echo  
echo ==================== run CPU Implementation ImageDiff ====================
cd ../..
cd ImageDiff/build
ping -c 5 127.0.0.1 >/dev/null
./absdiff_opt 


echo
echo  
echo ==================== run CPU Implementation MatchTemplate ====================
cd ../..
cd MatchTemplate/build
ping -c 5 127.0.0.1 >/dev/null
./match_template 


echo
echo   
echo ==================== run CPU Implementation MeanBlur ====================
cd ../..
cd MeanBlur
ping -c 5 127.0.0.1 >/dev/null
./build/src/mean-blur
cd build


echo
echo   
echo ==================== run CPU Implementation MorphOpen ====================
cd ../..
cd MorphOpen
ping -c 5 127.0.0.1 >/dev/null
./build/src/MorphOpen-3
ping -c 5 127.0.0.1 >/dev/null
./build/src/MorphOpen-5
cd build


echo
echo  
echo ==================== run CPU Implementation Resize ====================
cd ../..
cd Resize/build
ping -c 5 127.0.0.1 >/dev/null
./resize ../data/image2.jpg


echo
echo  
echo ==================== run CPU Implementation SobelGradient ====================
cd ../..
cd SobelGradient
#cd ..
ping -c 5 127.0.0.1 >/dev/null
./build/src/gradient-magnitude-hypot  
ping -c 5 127.0.0.1 >/dev/null
./build/src/gradient-magnitude-sum
cd build


echo
echo   
echo ==================== run CPU Implementation WarpAffine ipp_affine ====================
cd ../..
cd WarpAffine/ipp_affine/build
ping -c 5 127.0.0.1 >/dev/null
./ipp_affine
echo
echo   
echo ==================== End testing ====================

