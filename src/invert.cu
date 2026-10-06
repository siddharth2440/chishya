#include <cuda_runtime.h>

__global__ void invert_kernel( unsigned char* image, int pixel_count ) {

    const int pixel = blockIdx.x * blockDim.x + threadIdx.x;
    if (pixel > pixel_count) {
        return;
    }

    const int index = pixel * 3;

    image[ index + 0 ] = 255 - image[index + 0];
    image[ index + 1 ] = 255 - image[index + 1];
    image[ index + 2 ] = 255 - image[index + 2];
    
}

void invert_image(unsigned char* device_image, int pixel_count) {
    
    constexpr int threads_per_block = 256;
    const int blocks = (pixel_count - 1) / threads_per_block;

    invert_kernel <<<blocks, threads_per_block>>>(device_image, pixel_count);

    cudaDeviceSynchronize();

}