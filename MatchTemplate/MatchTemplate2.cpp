#include <opencv2/imgproc.hpp>
#include <opencv2/highgui.hpp>
#include <iostream>


using namespace std;
using namespace cv;

int main() {
    //cout<<"hello world!"<<endl;
    string GRAY_FILE_NAME = "../screenshot.png";
    string TEMP_FILE_NAME = "../screen_temp.png";
    Mat gray_image = cv::imread(GRAY_FILE_NAME, IMREAD_GRAYSCALE);
    Mat temp_image = imread(TEMP_FILE_NAME, IMREAD_GRAYSCALE);
    //cout<<gray_image;
    Mat resultImg;

    int ResultCols = gray_image.cols - temp_image.cols + 1;
    int ResultRows = gray_image.rows - temp_image.rows + 1;
    //cout<<ResultCols;

    resultImg.create(ResultRows, ResultCols, CV_32FC1);

    int method = TM_CCORR_NORMED;
    auto TotalTime = 0.0;
    for (int i = 0; i < 1; i++)
    {
        auto start = std::chrono::steady_clock::now();
        matchTemplate(gray_image, temp_image, resultImg, method);
        auto stop = std::chrono::steady_clock::now();
        auto cv_time = std::chrono::duration_cast<std::chrono::microseconds>(stop - start).count() / 1000.0;


        cout << "cv_time: " << cv_time << endl;

        TotalTime += cv_time;
    }
    cout << "mean_cv_time: " << TotalTime / 1 << endl;

}