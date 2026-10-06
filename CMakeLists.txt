cmake_minimum_required(VERSION 3.28)

project(cuda_image
    LANGUAGES CXX CUDA
)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(
    cuda_image 
    src/main.cpp
    src/invert.cu
)

target_include_directories(
    cuda_image
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        /opt/cuda/include
)


set_target_properties(cuda_image PROPERTIES
    CUDA_ARCHITECTURES native
)