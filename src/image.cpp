#include "image.hpp"
#include "stdexcept"
#include "stb/stb_image.h"
#include "stb_image_write.h"

Image load_image( const char* path ) {
    int width { 0 };
    int height { 0 };
    int channels { 0 };

    unsigned char* raw = stbi_load( path, &width, &height, &channels, 3 );

    if (!raw) {
        throw std::runtime_error(stbi_failure_reason());
    }

    Image image{ static_cast<std::size_t>(width), static_cast<std::size_t>(height) };

    const std::size_t pixel_count = image.width() * image.height();

    for( std::size_t i = 0; i < pixel_count; ++i ) {
        image.data()[i].r = raw[ i * 3 + 0 ];
        image.data()[i].g = raw[ i * 3 + 1 ];
        image.data()[i].b = raw[ i * 3 + 2 ];
    }

    stbi_image_free(raw);

    return image;
}

void save_image( const Image& image, const char* path ) {
    const int width = static_cast<int>(image.width());
    const int height = static_cast<int>(image.height());

    const int channels = 3;
    const int stride = width * channels;

    const int result = stbi_write_png( path, width, height, channels, image.data(), stride);

    if (!result) {
        throw std::runtime_error("Failed to save image.");
    }
}