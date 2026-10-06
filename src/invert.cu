#include <cuda_runtime.h>

__global__ void invert_kernel( unsigned char* image, int pixel_count ) {

    const int pixel = blockIdx.x * blockDim.x + threadIdx.x;
    if (pixel >= pixel_count) {
        return;
    }

    const int index = pixel * 3;

    /*
        image_inversion_formula:  "new_value = 255 − old_value"
    */
    image[ index + 0 ] = 255 - image[index + 0];
    image[ index + 1 ] = 255 - image[index + 1];
    image[ index + 2 ] = 255 - image[index + 2];
    
}

__global__ void grayscale_kernel( unsigned char* image, int pixel_count ) {

    const int pixel = blockIdx.x * blockDim.x + threadIdx.x;
    if (pixel >= pixel_count) {
        return;
    }

    const int idx = pixel * 3;

    const unsigned char r = image[idx + 0];
    const unsigned char g = image[idx + 1];
    const unsigned char b = image[idx + 2];
   
    
    /*
        gray = 0.299R + 0.587G + 0.114B
    */ 
    const unsigned char gray { static_cast<unsigned char>(0.299 * r + 0.587 * g + 0.114 * b) };

    image[idx + 0] = gray;
    image[idx + 1] = gray;
    image[idx + 2] = gray;

}


__global__ void brightness_kernel( unsigned char* image, int pixel_count, int amout ) {
    const int pixel = blockIdx.x * blockDim.x + threadIdx.x;

    if ( pixel >= pixel_count ) {
        return;
    }

    const int index = pixel * 3;

    for (int channel = 0; channel < 3; channel++ ) {
        int value = image[index + channel];
        value += amout;
        
        if ( value > 255 ) {
            value = 255;
        }

        if ( value < 0 ) {
            value = 0;
        }
        
        image[index + channel] = static_cast<unsigned char>(value);

    }
}

void invert_image(unsigned char* device_image, int pixel_count) {

    constexpr int threads_per_block = 256;
    const int blocks = (pixel_count + threads_per_block - 1) / threads_per_block;

    invert_kernel<<<blocks, threads_per_block>>>(device_image, pixel_count);

    cudaDeviceSynchronize();

}


void gray_scale( unsigned char* device_image, int pixel_count ) {
    constexpr int threads_per_block = 256;
    const int blocks = (pixel_count + threads_per_block - 1) / threads_per_block;

    grayscale_kernel<<<blocks, threads_per_block>>>(device_image, pixel_count);

    cudaDeviceSynchronize();
}

void brightness_image( unsigned char* device_image, int pixel_count, int amount ) {
    constexpr int threads_per_block { 256 };

    const int blocks = ( pixel_count  + threads_per_block - 1 ) / threads_per_block ;

    brightness_kernel<<< blocks, threads_per_block >>>( device_image, pixel_count, amount );

    cudaDeviceSynchronize();
}