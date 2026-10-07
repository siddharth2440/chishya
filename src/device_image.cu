
#include "cuda_runtime.h"
#include <stdexcept>

#include "device_image.hpp"

DeviceImage::DeviceImage( const Image& image )
    : width_{ image.width() }, height_{ image.height() }, data_{ nullptr } {

        const std::size_t bytes = image.width() * image.height() * sizeof(Pixel);

        const cudaError_t result = cudaMalloc( reinterpret_cast<void**>(&data_), bytes );

        if (result != cudaSuccess) {
            throw std::runtime_error( cudaGetErrorString(result) );
        }

       const cudaError_t copy_result = cudaMemcpy( data_, image.data(), bytes, cudaMemcpyHostToDevice);
       if ( copy_result != cudaSuccess ) {
        throw std::runtime_error( cudaGetErrorString(copy_result) );
       }
}

DeviceImage::~DeviceImage() {
    if (data_) {
        cudaFree(data_);
    }
}

DeviceImage::DeviceImage(DeviceImage&& other) noexcept
    : width_{ other.width() }, height_{ other.height() }, data_{ other.data_ } {
        other.data_ = nullptr;
}

DeviceImage& DeviceImage::operator=(DeviceImage&& other) noexcept {
    if ( this == &other ) {
        return *this;
    }
    
    if (data_) {
        cudaFree(data_);
    }

    width_ = other.width_;
    height_ = other.height_;
    data_ = other.data_;

    other.data_ = nullptr;

    return *this;
}

void DeviceImage::download( Image& image ) const {
    if ( image.width() != width_ || image.height() != height_ ) {
        throw std::runtime_error("Image Dimensions mismatch");
    }

    const std::size_t bytes = width_ * height_ * sizeof(Pixel);    
    const cudaError_t result = cudaMemcpy( image.data(), data_, bytes, cudaMemcpyDeviceToHost );

    if (result != cudaSuccess) {
        throw std::runtime_error(cudaGetErrorString(result));
    }
}

std::size_t DeviceImage::width() const noexcept {
    return width_;
}

std::size_t DeviceImage::height() const noexcept {
    return height_;
}


std::size_t DeviceImage::pixel_count() const noexcept {
    return width_ * height_;
}

Pixel* DeviceImage::data() noexcept {
    return data_;
}