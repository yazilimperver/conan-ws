cmake_minimum_required(VERSION 3.15)
project(GTestExample LANGUAGES CXX)

# Conan Toolchain ve Paketleri Dahil Et
include(${CMAKE_BINARY_DIR}/conan_toolchain.cmake OPTIONAL)

# C++17 veya üstü
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(GTest REQUIRED)

add_executable(test_app src/main.cpp)
target_link_libraries(test_app GTest::gtest GTest::gtest_main)

enable_testing()
add_test(NAME gtest_example COMMAND test_app)