#pragma once

#include <cstddef>
#include <cstdint>
#include <vector>

struct Pixel {
    std::uint8_t r;
    std::uint8_t g;
    std::uint8_t b;
};

class Image {
    private:
        std::size_t height_;
        std::size_t width_;
        std::vector<Pixel> pixels_;

    public:
        Image(std::size_t width, std::size_t height) 
            : width_{ width },
            height_{ height },
            pixels_{ width * height } {}

        [[nodiscard]]
        std::size_t height() const noexcept { 
            return height_; 
        }

        [[nodiscard]]
        std::size_t width() const noexcept { 
            return width_; 
        }

        [[nodiscard]]
        Pixel* data() noexcept {
            return pixels_.data();
        }

        [[nodiscard]]
        const Pixel* data() const noexcept {
            return pixels_.data();
        }

};


Image load_image( const char* path );
void save_image( const Image& image, const char* path );