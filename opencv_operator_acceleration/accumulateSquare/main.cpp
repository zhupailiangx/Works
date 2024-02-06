#include <opencv2/opencv.hpp>  
#include <opencv2/core/core.hpp>
#include <iostream>
#include <chrono>
#include "ippcore.h"
#include "ipps.h"
#include "ippi.h"
#include "ippcv.h"
#include "ippcc.h"
#include "ippvm.h"
#include <omp.h>
const int TEST_NUM=100;
#define TIMERSTART(tag)  auto tag##_start = std::chrono::high_resolution_clock::now(),tag##_end = tag##_start
#define TIMEREND(tag)  tag##_end =  std::chrono::high_resolution_clock::now()
#define DURATION_s(tag) printf("%s costs %ld s\n",#tag,std::chrono::duration_cast<std::chrono::seconds>(tag##_end - tag##_start).count()/TEST_NUM);
#define DURATION_ms(tag) printf("%s costs %1d ms\n",#tag,std::chrono::duration_cast<std::chrono::milliseconds>(tag##_end - tag##_start).count()/TEST_NUM);
#define DURATION_us(tag) printf("%s costs %ld us\n",#tag,std::chrono::duration_cast<std::chrono::microseconds>(tag##_end - tag##_start).count()/TEST_NUM);
#define DURATION_ns(tag) printf("%s costs %ld ns\n",#tag,std::chrono::duration_cast<std::chrono::nanoseconds>(tag##_end - tag##_start).count()/TEST_NUM);

using namespace std;
using namespace cv;
using namespace std::chrono;
//std::cout<<"loop times :" <<TEST_NUM<<std::endl;


void test_opencv_accumulate_sqr(cv::Mat& m1, cv::Mat& m2){

   TIMERSTART(opencv_accumulateSqr);

    for (int i = 0; i < TEST_NUM; i++) {
        cv::accumulateSquare(m1, m2);
    }
    TIMEREND(opencv_accumulateSqr);
    DURATION_us(opencv_accumulateSqr);
}


void test_ipp_accumulate_sqr(cv::Mat& m1, cv::Mat& m2) {

    TIMERSTART(ipp_accumulateSqr);
    IppiSize roi = { m1.cols, m1.rows};
    int srcstep = (int)m1.step, dststep = (int)m2.step;
    for (int i = 0; i < TEST_NUM; i++) {
        IppStatus status = ippiAddSquare_8u32f_C1IR((Ipp8u*)(m1.data), srcstep, (Ipp32f*)(m2.data), dststep, roi);

}
    

   TIMEREND(ipp_accumulateSqr);
    DURATION_us(ipp_accumulateSqr);
}




void test_ipp_omp_accumulate_sqr(cv::Mat& m1, cv::Mat& m2)
{


    int step_size;
    int srcstep, dststep;
    IppiSize roi;
    IppiSize roi_tail;
    int tail;
    
    TIMERSTART(ipp_mutil_accumulateSqr);
    for (int i = 0; i < TEST_NUM; i++) {
        //omp_set_num_threads(1);

    int numThreads;

#pragma omp parallel num_threads(8)
 {   
#pragma omp master
            {
                numThreads = omp_get_num_threads();
                
                tail = m1.rows % numThreads;
                roi = { m1.cols, m1.rows/numThreads };
                //roi.height = m1.rows / c;
                //roi.width = m1.cols;
                roi_tail = { m1.cols, m1.rows / numThreads + tail };
                step_size = m1.cols * (m1.rows / numThreads);
                srcstep = (int)m1.step, dststep = (int)m2.step;
                
            }
#pragma omp barrier
            {
            int j = omp_get_thread_num();
            Ipp8u* ipp_src=(Ipp8u*)((Ipp8u*)m1.data + j * step_size);
            Ipp32f* ipp_dst = (Ipp32f*)((Ipp32f*)m2.data + j * step_size);
            
            if (j==numThreads-1){
                IppStatus status = ippiAddSquare_8u32f_C1IR(ipp_src, m1.cols,ipp_dst , m2.cols*4, roi_tail);
                }
                
            else{
                IppStatus status = ippiAddSquare_8u32f_C1IR(ipp_src, m1.cols,ipp_dst , m2.cols*4, roi);
            }
            }

}
   }

    TIMEREND(ipp_mutil_accumulateSqr);
    DURATION_us(ipp_mutil_accumulateSqr);
}

   

void compare_result(cv::Mat &m1, cv::Mat &m2)
{
    int step = m1.cols * m1.channels();
    int same = 0;
    int diff = 0;
    for (int x = 0; x < m1.rows; x++) {
        for (int y = 0; y < step; y++) {
            if (m1.data[x * step + y] == m2.data[x * step + y]) {
                same++;
            }
            else {
                diff++;
            }
        }
    }

    float correctness = same / (same + diff) * 100;

    printf("pixels same is %d, diff is %d, correctness is %2.2f %%\n", same, diff, correctness);
}

void test(cv::Mat img1, cv::Mat img2, cv::Mat img3, cv::Mat img4)
{
    
    std::cout << "=================OpenCV accumulateSqr===================" << std::endl;
    test_opencv_accumulate_sqr(img1, img2);
    std::cout << "=================IPP accumulateSqr======================" << std::endl;
    test_ipp_accumulate_sqr(img1, img3);
    compare_result(img2, img3);
    std::cout << "=================IPP tile accumulateSqr=================" << std::endl;
    test_ipp_omp_accumulate_sqr(img1, img4);
    compare_result(img3, img4);


}

int main(int argc, char* argv[])
{


    Mat src = imread("../data/image2.jpg", cv::IMREAD_GRAYSCALE);
    Size srcSize = cv::Size(src.cols, src.rows);
    //Mat src(srcSize, CV_8U);
    

    Mat cv_result(srcSize, CV_32FC1);
    Mat ipp_result(srcSize, CV_32FC1);
    Mat ipp_tile_result(srcSize, CV_32FC1);

    test(src, cv_result, ipp_result, ipp_tile_result);
    
    imshow("openCV", cv_result);
    imshow("IPP", ipp_result);
    imshow("IPP_TL", ipp_tile_result);
    waitKey();
    destroyAllWindows();

	return 0;
}

