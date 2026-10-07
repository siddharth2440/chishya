#include "image.hpp"
#include "stdexcept"
#include "stb/stb_image.h"

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