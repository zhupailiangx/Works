cmake_minimum_required(VERSION 2.8)

Project(MathTemplate)

find_package(OpenCV REQUIRED)

##下面是输出信息
message(STATUS "Opnecv ;ibrary status: ")
message(STATUS "> version: ${OpenCV_VERSION} ")
message(STATUS "libraries: ${OpenCV_LIBS} ")
message(STATUS "> include: ${OpenCV_INCLUDE_DIRS}  ")


include_directories(${OpenCV_INCLUDE_DIRS}) 


add_executable(MathTemplate MatchTemplate2.cpp)

target_link_libraries(MathTemplate ${OpenCV_LIBS})
