// CMakeProject2.cpp: 定义应用程序的入口点。
//

#include "Resize.h"
#include <opencv2/opencv.hpp>
#include "ipp.h"
#include "ippcore_tl.h"
#include "ippi_tl.h"
#include "ipps.h"
#include "ippcore_tl.h"
#include <omp.h>
using namespace std;
using namespace cv;
using namespace std::chrono;

#define LOWER 0
#define UPPER 256
#define LEVELS 4
#define MAX_NUM_THREADS 32

cv::Mat ReadImage() {
	string file = "../color_4288.jpg";
	cv::Mat image = cv::imread(file,1);
	cout << image.size() << endl;

	//cv::namedWindow("4288");
	//cv::imshow("4288", image);
	//cv::waitKey(0);
	//cv::destroyWindow("4288");
	return image;
}

int Resize_opencv(cv::Mat &src)
{
	int resize_w = src.cols/2;
	int resize_h = src.rows/2;
	Size dsize = Size(resize_w, resize_h);
	Mat dst_tmp = Mat(resize_h, resize_w, CV_8UC3);

	float sum = 0;
	high_resolution_clock::time_point start, end;
	duration<double, std::milli> delta;
	int loop = 10;
	for (int i = 0; i < loop; i++)
	{
		start = high_resolution_clock::now();
		resize(src, dst_tmp, dsize, 0, 0, INTER_NEAREST);
		end = high_resolution_clock::now();
		delta = end - start;
		sum += delta.count();
	}
	imshow("Source image", src);
	imshow("openCV", dst_tmp);
	waitKey(0);
	destroyAllWindows();

	cout << "The openCV resize time is: " << sum << "ms" << endl;
	cout << "The Average resize time: " << sum / loop << "ms" << endl
		<< endl;
	
	

	return EXIT_SUCCESS;

}

int Resize_ipp(cv::Mat &img) 
{
	int resize_w = img.cols/2;
	int resize_h = img.rows/2;

	IppiSize srcSize, dstSize;
	srcSize.width = img.cols;
	srcSize.height = img.rows;
	dstSize.width = resize_w;
	dstSize.height = resize_h;

	Mat dst_tmp = Mat(resize_h, resize_w, CV_8UC3);
	int srcStep = img.step;
	int dstStep = dst_tmp.step;
	Ipp8u* pSrc = (Ipp8u*)&img.data[0];
	Ipp8u* pDst = (Ipp8u*)&dst_tmp.data[0];

	int specSize = 0;
	int initSize = 0;
	Ipp32u numChannels = 3;
	IppStatus ippStatus;

	int g_bufSize = 0;
	IppiResizeSpec_32f* g_pSpec = 0;

	ippStatus = ippiResizeGetSize_8u(srcSize, dstSize, ippNearest, 0, &specSize, &initSize);
	g_pSpec = (IppiResizeSpec_32f*)ippsMalloc_8u(specSize);
	ippStatus = ippiResizeNearestInit_8u(srcSize, dstSize, g_pSpec);
	ippStatus = ippiResizeGetBufferSize_8u(g_pSpec, dstSize, numChannels, &g_bufSize);

	Ipp8u* pBuffer = 0;
	IppiPoint dstOffset = { 0, 0 };
	pBuffer = ippsMalloc_8u(g_bufSize);

	float sum = 0;
	high_resolution_clock::time_point start, end;
	duration<double, std::milli> delta;
	int loop = 10;
	for (int i = 0; i < loop; i++)
	{
		start = high_resolution_clock::now();
		ippStatus = ippiResizeNearest_8u_C3R(pSrc, srcStep, pDst, dstStep, dstOffset, dstSize, g_pSpec, pBuffer);
		end = high_resolution_clock::now();
		delta = end - start;
		sum += delta.count();
	}

	imshow("ipp", dst_tmp);
	waitKey(1000);
	destroyAllWindows();

	cout << "The IPP resize time is: " << sum << "ms" << endl;
	cout << "The Average resize time: " << sum / loop << "ms" << endl
		<< endl;

	if (pBuffer)
	{
		ippsFree(pBuffer);
	}
	if (g_pSpec)
	{
		ippsFree(g_pSpec);
	}

	printf("\n");

	return 0;
}

void Resize_TL(Mat &img) 
{
	int resize_w = img.cols / 2;
	int resize_h = img.rows / 2;
	IppiSizeL srcSize_TL, dstSize_TL;
	srcSize_TL.width = img.cols;
	srcSize_TL.height = img.rows;
	dstSize_TL.width = resize_w;
	dstSize_TL.height = resize_h;

	Mat dst_tmp = Mat(resize_h, resize_w, CV_8UC3);
	Ipp32s srcStep = img.step;
	Ipp32s dstStep = dst_tmp.step;
	Ipp8u* pSrc = (Ipp8u*)&img.data[0];
	Ipp8u* pDst = (Ipp8u*)&dst_tmp.data[0];

	IppSizeL specSize = 0;
	IppSizeL tempSize = 0;
	Ipp32u numChannels = 3;
	IppStatus ippStatus;

	IppiResizeSpec_LT* g_pSpec_TL = 0;

	int threads = 8;
	omp_set_num_threads(threads);

	ippStatus = ippiResizeGetSize_LT(srcSize_TL, dstSize_TL, ipp8u, ippNearest, 0, &specSize, &tempSize);
	g_pSpec_TL = (IppiResizeSpec_LT*)ippsMalloc_8u(specSize);
	ippStatus = ippiResizeNearestInit_LT(srcSize_TL, dstSize_TL, ipp8u, numChannels, g_pSpec_TL);
	ippStatus = ippiResizeGetBufferSize_LT(g_pSpec_TL, &tempSize);
	Ipp8u* pBuffer = ippsMalloc_8u(tempSize);

	float sum = 0;
	high_resolution_clock::time_point start, end;
	duration<double, std::milli> delta;
	int loop = 10;
	for (int i = 0; i < loop; i++)
	{
		start = high_resolution_clock::now();
		ippStatus = ippiResizeNearest_8u_C3R_LT(pSrc, srcStep, pDst, dstStep, g_pSpec_TL, pBuffer);
		end = high_resolution_clock::now();
		delta = end - start;
		sum += delta.count();
	}

	imshow("TL", dst_tmp);
	waitKey(1000);
	destroyAllWindows();

	cout << "The TL resize time: " << sum << "ms" << endl;
	cout << "The Average resize time: " << sum / loop << "ms" << endl
		<< endl;
}

int main()
{
	cv::Mat image = ReadImage();
	auto s1 = std::chrono::system_clock::now();
	Resize_opencv(image);
	auto e1 = std::chrono::system_clock::now();
	auto duration = duration_cast<microseconds>(e1 - s1);
	printf("\opencv takes %.2ld us\n", duration.count());

	auto s2 = std::chrono::system_clock::now();
	Resize_ipp(image);
	auto e2 = std::chrono::system_clock::now();
	auto duration_ipp = duration_cast<microseconds>(e2 - s2);
	printf("\IPP takes %.2ld us\n", duration_ipp.count());
	return 0;
}
