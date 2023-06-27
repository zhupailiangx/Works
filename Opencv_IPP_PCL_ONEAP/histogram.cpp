// CMakeProject2.cpp: 定义应用程序的入口点。
//

#include "histogram.h"
#include <opencv2/opencv.hpp>
#include <ippcore.h>
#include <ipps.h>
#include <ippi.h>
using namespace std;
using namespace cv;
using namespace std::chrono;

#define LOWER 0
#define UPPER 256
#define LEVELS 4
#define MAX_NUM_THREADS 32

cv::Mat ReadImage() {
	string file = "../data/color_4288.jpg";
	cv::Mat image = cv::imread(file,1);
	cout << image.size() << endl;

	//cv::namedWindow("4288");
	//cv::imshow("4288", image);
	//cv::waitKey(0);
	//cv::destroyWindow("4288");
	return image;
}

int Histogram_opencv(cv::Mat &src)
{
	if (src.empty())
	{
		return EXIT_FAILURE;
	}
	vector<Mat> bgr_planes;
	split(src, bgr_planes);
	int histSize = 256;
	float range[] = { 0, 256 }; //the upper boundary is exclusive
	const float* histRange[] = { range };
	bool uniform = true, accumulate = false;
	Mat b_hist, g_hist, r_hist;
	calcHist(&bgr_planes[0], 1, 0, Mat(), b_hist, 1, &histSize, histRange, uniform, accumulate);
	calcHist(&bgr_planes[1], 1, 0, Mat(), g_hist, 1, &histSize, histRange, uniform, accumulate);
	calcHist(&bgr_planes[2], 1, 0, Mat(), r_hist, 1, &histSize, histRange, uniform, accumulate);
	int hist_w = 512, hist_h = 400;
	int bin_w = cvRound((double)hist_w / histSize);
	Mat histImage(hist_h, hist_w, CV_8UC3, Scalar(0, 0, 0));
	normalize(b_hist, b_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat());
	normalize(g_hist, g_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat());
	normalize(r_hist, r_hist, 0, histImage.rows, NORM_MINMAX, -1, Mat());
	for (int i = 1; i < histSize; i++)
	{
		line(histImage, Point(bin_w * (i - 1), hist_h - cvRound(b_hist.at<float>(i - 1))),
			Point(bin_w * (i), hist_h - cvRound(b_hist.at<float>(i))),
			Scalar(255, 0, 0), 2, 8, 0);
		line(histImage, Point(bin_w * (i - 1), hist_h - cvRound(g_hist.at<float>(i - 1))),
			Point(bin_w * (i), hist_h - cvRound(g_hist.at<float>(i))),
			Scalar(0, 255, 0), 2, 8, 0);
		line(histImage, Point(bin_w * (i - 1), hist_h - cvRound(r_hist.at<float>(i - 1))),
			Point(bin_w * (i), hist_h - cvRound(r_hist.at<float>(i))),
			Scalar(0, 0, 255), 2, 8, 0);
	}
	imshow("Source image", src);
	imshow("calcHist Demo", histImage);
	waitKey();
	return EXIT_SUCCESS;

}

int Histogram_ipp(cv::Mat &img) 
{
	int resize_h = img.rows / 2;
	int resize_w = img.cols / 2;

	IppiSize srcSize, dstSize;
	srcSize.width = img.cols;
	srcSize.height = img.rows;

	int width = img.cols;
	int height= img.rows;
	IppiSize roi = { width, height };
	IppStatus sts;
	Ipp8u* data = (Ipp8u*)&img.data[0];

	const int nBins = LEVELS;
	int nLevels[] = { nBins + 1 };
	Ipp32f lowerLevel[] = { LOWER };
	Ipp32f upperLevel[] = { UPPER };
	Ipp32f pLevels[nBins + 1], * ppLevels[1];
	int sizeHistObj, sizeBuffer;

	IppiHistogramSpec* pHistObj;
	Ipp8u* pBuffer;
	Ipp32u pHistVec[nBins];


	// get sizes for spec and buffer
	ippiHistogramGetBufferSize(ipp8u, roi, nLevels, 1/*nChan*/, 1/*uniform*/, &sizeHistObj, &sizeBuffer);

	pHistObj = (IppiHistogramSpec*)ippsMalloc_8u(sizeHistObj);
	pBuffer = (Ipp8u*)ippsMalloc_8u(sizeBuffer);
	// initialize spec
	ippiHistogramUniformInit(ipp8u, lowerLevel, upperLevel, nLevels, 1, pHistObj);

	// check levels of bins
	ppLevels[0] = pLevels;
	sts = ippiHistogramGetLevels(pHistObj, ppLevels);
	printf("\nhistogram_ipp, %d levels,\n", nBins);
	for (int i = 0; i < nBins + 1; i++)
		printf("%.2f\t", pLevels[i]);

	auto start = system_clock::now();
	for (int i; i < 10; i++) {
		// calculate histogram
		sts = ippiHistogram_8u_C1R(data, width, roi, pHistVec, pHistObj, pBuffer);
	}
	auto end = system_clock::now();
	auto duration = duration_cast<microseconds>(end - start);
	printf("\nhistogram ipp takes %.2ld us\n", duration.count() / 10);

	ippsFree(pHistObj);
	ippsFree(pBuffer);

	printf("\nhist result:\n");
	for (int i = 0; i < nBins; i++)
		printf("%d\t", pHistVec[i]);

	printf("\n");

	return 0;
}


int main()
{
	cv::Mat image = ReadImage();
	auto s1 = std::chrono::system_clock::now();
	Histogram_opencv(image);
	auto e1 = std::chrono::system_clock::now();
	auto duration = duration_cast<microseconds>(e1 - s1);
	printf("\opencv takes %.2ld us\n", duration.count());

	auto s2 = std::chrono::system_clock::now();
	Histogram_ipp(image);
	auto e2 = std::chrono::system_clock::now();
	auto duration_ipp = duration_cast<microseconds>(e2 - s2);
	printf("\IPP takes %.2ld us\n", duration_ipp.count());
	return 0;
}
