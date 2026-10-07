#include "image_op.hpp"
#include "device_image.hpp"
#include "invert.hpp"

#include <cuda_runtime.h>

__global__ void invert_kernel( Pixel* image, int pixel_count ) {

    const int pixel = blockIdx.x * blockDim.x + threadIdx.x;
    if (pixel >=  pixel_count) {
        return;
    }

    /*
        image_inversion_formula:  "new_value = 255 − old_value"
    */
    image[pixel].r = 255 - image[pixel].r;
    image[pixel].g = 255 - image[pixel].g;
    image[pixel].b = 255 - image[pixel].b;

}



void Invert::apply(DeviceImage& image) {

    constexpr int threads_per_block = 256;
    const int blocks = ( image.pixel_count() + threads_per_block - 1) / threads_per_block;

    invert_kernel<<<blocks, threads_per_block>>>(image.data(), image.pixel_count());

    cudaDeviceSynchronize();

}
