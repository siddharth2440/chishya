#include "grayscale.hpp"
#include "device_image.hpp"

#include <cuda_runtime.h>

__global__ void grayscale_kernel( Pixel* image, int pixel_count ) {

    const int pixel = blockIdx.x * blockDim.x + threadIdx.x;
    if (pixel >= pixel_count) {
        return;
    }

    const unsigned char r = image[pixel].r;
    const unsigned char g = image[pixel].g;
    const unsigned char b = image[pixel].b;
    
    /*
        gray = 0.299R + 0.587G + 0.114B
    */ 
    const unsigned char grayscale_val { static_cast<unsigned char>(0.299 * r + 0.587 * g + 0.114 * b) };

    image[pixel].r = grayscale_val;
    image[pixel].g = grayscale_val;
    image[pixel].b = grayscale_val;

}

void GrayScale::apply( DeviceImage& image ) {
    constexpr int threads_per_block = 256;
    const int blocks = (image.pixel_count() + threads_per_block - 1) / threads_per_block;

    grayscale_kernel<<<blocks, threads_per_block>>>(image.data(), image.pixel_count());

    cudaDeviceSynchronize();
}