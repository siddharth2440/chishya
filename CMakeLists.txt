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
    src/image.cpp
    src/stb_image.cpp
    src/device_image.cu
    src/pipeline.cpp
    src/invert.cu
    src/grayscale.cu
    src/brightness.cu
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

add_executable(
    test_image
    tests/test_image.cpp
    src/image.cpp
    src/stb_image.cpp
)

target_include_directories(
    test_image
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        /opt/cuda/include
)

add_executable(
    test_device_image
    tests/test_device_image.cu
    src/device_image.cu
)

target_include_directories(
    test_device_image
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        /opt/cuda/include
)


add_executable(
    test_invert
    tests/test_invert.cu
    src/invert.cu
    src/device_image.cu
)

target_include_directories(
    test_invert
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        /opt/cuda/include
)


add_executable(
    test_grayscale
    tests/test_grayscale.cu
    src/grayscale.cu
    src/device_image.cu
)

target_include_directories(
    test_grayscale
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        /opt/cuda/include
)



add_executable(
    test_brightness
    tests/test_brightness.cu
    src/brightness.cu
    src/device_image.cu
)

target_include_directories(
    test_brightness
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        /opt/cuda/include
)


add_executable(
    test_image_pipeline
    tests/test_image.pipeline.cu
    src/pipeline.cpp
    src/invert.cu
    src/grayscale.cu
    src/brightness.cu
    src/device_image.cu
)

target_include_directories(
    test_image_pipeline
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/include
        /opt/cuda/include
)