#!/bin/bash
python3 -m pip install --upgrade pip

if [ ! -d build ]; then
	mkdir build
fi
cd build
cmake -DWITH_TBB=OFF -DWITH_OPENMP=OFF -DWITH_PTHREADS_PF=OFF ..
make opencv_perf_core opencv_perf_imgproc opencv_perf_objdetect -j8


cd bin

export OPENCV_OPENCL_DEVICE=disabled

python3 ../../modules/ts/misc/run.py -t core --gtest_filter=Size_MatType_inRange.inRange/16:Size_MatType_bitwise_and.bitwise_and/10:Size_MatType_NormType_normalize.normalize/20:Size_Depth_Channels_split.split/26:Size_MatType_NormType_norm.norm/20:Size_MatType_bitwise_not.bitwise_not/10:BinaryOpTest.subtract/20:OCL_ConvertScaleAbsFixture_ConvertScaleAbs.ConvertScaleAbs/15 --gtest_output=xml:core_selected.xml --perf_force_samples=1000 --perf_min_samples=1000

python3 ../../modules/ts/misc/run.py -t imgproc --gtest_filter=Size_Source_calcHist3d.calcHist3d/3:Size_CvtMode_cvtColor8u.cvtColor8u/243:Size_CvtMode_cvtColor8u.cvtColor8u/358:TestFindContours_findContours.findContours/49:TestFindContours_findContours.findContours/33:OCL_ThreshFixture_Threshold.Threshold/32:Size_MatType_ThreshType_threshold.threshold/40:Size_MatType_BorderType3x3_gaussianBlur3x3.gaussianBlur3x3/31:Size_MatType_BorderType_gaussianBlur5x5.gaussianBlur5x5/61:TestWarpAffine_WarpAffine.WarpAffine/10:TestWarpAffine_WarpAffine.WarpAffine/9:Size_MatType_dilate.dilate/8:TestBoundingRect_BoundingRect.BoundingRect/9:Size_MatType_erode.erode/8:OCL_EqualizeHistFixture_EqualizeHist.EqualizeHist/2:Size_MatType_dx_dy_Border3x3_sobelFilter.sobelFilter/63:Size_MatType_dx_dy_Border5x5_sobelFilter.sobelFilter/105:Size_MatType_BorderType3x3_blur3x3.blur3x3/31:Size_MatType_BorderType_blur5x5.blur5x5/25:Size_MatType_kSize_medianBlur.medianBlur/30:Size_MatType_kSize_medianBlur.medianBlur/31:Transform.getPerspectiveTransform_1000:TestWarpPerspectiveNear_t_WarpPerspectiveNear.WarpPerspectiveNear/12:Sz_ClipLimit_CLAHE.CLAHE/8:TestFilter2d_Filter2d.Filter2d/6:MomentsFixture_val_Moments1.Moments1/21:TestBilateralFilter_BilateralFilter.BilateralFilter/14:OCL_ThreshFixture_Threshold.Threshold/56:OCL_EqualizeHistFixture_EqualizeHist.EqualizeHist/3:TestWarpPerspectiveNear_t_WarpPerspectiveNear.WarpPerspectiveNear/20:OCL_ImgSize_TmplSize_Method_MatType_MatchTemplate.MatchTemplate/97:OCL_ImgSize_TmplSize_Method_MatType_MatchTemplate.MatchTemplate/136 --gtest_output=xml:imgproc_selected.xml --perf_force_samples=1000 --perf_min_samples=1000

python3 ../../modules/ts/misc/run.py -t objdetect --gtest_filter=Perf_Objdetect_Not_QRCode.decode/11:Perf_Objdetect_Not_QRCode.decode/6 --gtest_output=xml:objdetect_selected.xml --perf_force_samples=1000 --perf_min_samples=1000

python3 ../../modules/ts/misc/report.py core_selected.xml -o html >core_selected.ods

python3 ../../modules/ts/misc/report.py imgproc_selected.xml -o html >imgproc_selected.ods

python3 ../../modules/ts/misc/report.py objdetect_selected.xml -o html >objdetect_selected.ods

python3 ../../opencv_test_results_to_excel.py --input_path core_selected.ods --output_path core_selected.xlsx --OS $(lsb_release -d |  awk '{print $2""$3}') --Skew $(cat /proc/cpuinfo | grep "model name" | awk '{print $NF}' | head -n 1) --File_Name core --Memory_type $(sudo dmidecode -t memory | grep "Type:" | awk '{print $2}' | grep 'DDR' | head -n 1) --WW WW40 --Memory_Speed $(sudo dmidecode -t memory | awk '/Speed:.*MT\/s/ {gsub(/.*Speed:/,""); gsub(/ MT\/s.*/,"MT/s");print;exit}') --CPU_req $(cat /sys/devices/system/cpu/cpu0/cpufreq/base_frequency | tr -d '\n' | rev | cut -c 4-7 | rev | awk '{print $1 "MHz"}')

python3 ../../opencv_test_results_to_excel.py --input_path imgproc_selected.ods --output_path imgproc_selected.xlsx --OS $(lsb_release -d |  awk '{print $2""$3}') --Skew $(cat /proc/cpuinfo | grep "model name" | awk '{print $NF}' | head -n 1) --File_Name imgproc --Memory_type $(sudo dmidecode -t memory | grep "Type:" | awk '{print $2}' | grep 'DDR' | head -n 1) --WW WW40 --Memory_Speed $(sudo dmidecode -t memory | awk '/Speed:.*MT\/s/ {gsub(/.*Speed:/,""); gsub(/ MT\/s.*/,"MT/s");print;exit}') --CPU_req $(cat /sys/devices/system/cpu/cpu0/cpufreq/base_frequency | tr -d '\n' | rev | cut -c 4-7 | rev | awk '{print $1 "MHz"}')

python3 ../../opencv_test_results_to_excel.py --input_path objdetect_selected.ods --output_path objdetect_selected.xlsx --OS $(lsb_release -d |  awk '{print $2""$3}') --Skew $(cat /proc/cpuinfo | grep "model name" | awk '{print $NF}' | head -n 1) --File_Name objdetect --Memory_type $(sudo dmidecode -t memory | grep "Type:" | awk '{print $2}' | grep 'DDR' | head -n 1) --WW WW40 --Memory_Speed $(sudo dmidecode -t memory | awk '/Speed:.*MT\/s/ {gsub(/.*Speed:/,""); gsub(/ MT\/s.*/,"MT/s");print;exit}') --CPU_req $(cat /sys/devices/system/cpu/cpu0/cpufreq/base_frequency | tr -d '\n' | rev | cut -c 4-7 | rev | awk '{print $1 "MHz"}')
