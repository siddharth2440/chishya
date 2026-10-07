#include <iostream>
#include <print>
#include <cstdio>

#include "image.hpp"

#include <cuda_runtime.h>

#define STB_IMAGE_IMPLEMENTATION
#include "stb/stb_image.h"

#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb/stb_image_write.h"

void invert_image(unsigned char* device_image, int pixel_data);
void gray_scale( unsigned char* device_image, int pixel_count );
void brightness_image( unsigned char* device_image, int pixel_count, int amount );

int main() {

    constexpr auto input_path = "assets/image1.jpg";
    constexpr auto output_path = "assets/image_output.jpg";

    int width {};
    int height {};
    int channels {};

    unsigned char* host_image { stbi_load( input_path, &width, &height, &channels, 3 ) };
    if (!host_image) {
        std::printf( "Failed to load image: {%s}\n", stbi_failure_reason());
        return EXIT_FAILURE;
    }

    const int pixel_count { width * height };

    const std::size_t image_size { static_cast<std::size_t>(pixel_count) * 3 };

    unsigned char* device_image{};
    const auto allocation { cudaMalloc( reinterpret_cast<void**>(&device_image), image_size ) };

    if (allocation != cudaSuccess) {
        std::printf("cudaMalloc failed: {}", cudaGetErrorString(allocation));
        stbi_image_free(host_image);

        return EXIT_FAILURE;
    }

    cudaMemcpy( device_image, host_image, image_size, cudaMemcpyHostToDevice );

    std::printf("IMAGE: {%d}x{%d}", width,height );


    // invert_image( device_image, pixel_count );
    // gray_scale( device_image, pixel_count );

    const int amount { 50 };
    brightness_image( device_image, pixel_count, amount );

    cudaMemcpy( host_image, device_image, image_size, cudaMemcpyDeviceToHost );

    if ( !stbi_write_png( output_path, width, height, 3, host_image, width * 3) ) {
        std::println(stderr, "failed to write output image.");
        cudaFree( device_image );
        stbi_image_free( host_image );

        return EXIT_FAILURE;
    }

    cudaFree( device_image );
    stbi_image_free( host_image );

    std::println("Saved: {}", output_path);

    return EXIT_SUCCESS;

}