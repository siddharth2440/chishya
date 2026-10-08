#include "brightness.hpp"
#include "device_image.hpp"
#include "cuda_check.hpp"

__global__ void brightness_kernel( Pixel* image, int pixel_count, int amout ) {
    const std::size_t pixel = blockIdx.x * blockDim.x + threadIdx.x;

    if ( pixel >= pixel_count ) {
        return;
    }

    int r = static_cast<int>(image[pixel].r + amout);
    int g = static_cast<int>(image[pixel].g + amout);
    int b = static_cast<int>(image[pixel].b + amout);

    r = max(0, min(255, r));
    g = max(0, min(255, g));
    b = max(0, min(255, b));

    image[pixel].r = static_cast<uint8_t>(r);
    image[pixel].g = static_cast<uint8_t>(g);
    image[pixel].b = static_cast<uint8_t>(b);

}

Brightness::Brightness(int amount) noexcept:  amount_{ amount } {}

void Brightness::apply( DeviceImage& device_image ) {
    constexpr int threads_per_block { 256 };

    const std::size_t pixel_count = device_image.pixel_count();

    const int blocks = ( device_image.pixel_count()  + threads_per_block - 1 ) / threads_per_block ;

    brightness_kernel<<< blocks, threads_per_block, 0, device_image.stream() >>>( device_image.data(), pixel_count , amount_ );

    cuda_check(cudaGetLastError(), "Brightness kernel execution");
    // cuda_check(cudaDeviceSynchronize(), "Brightness kernel execution");
}