#pragma once

#include "image.hpp"
#include <cstddef>
#include <cuda_runtime.h>

class DeviceImage {

    public:
        explicit DeviceImage(const Image& image);

        ~DeviceImage();

        DeviceImage(const DeviceImage&) = delete;
        DeviceImage& operator = (const DeviceImage&) = delete;

        DeviceImage( DeviceImage&& other ) noexcept;
        DeviceImage& operator = ( DeviceImage&& other ) noexcept;

        void download(Image& image) const;

        [[nodiscard]]
        std::size_t width() const noexcept;

        [[nodiscard]]
        std::size_t height() const noexcept;
        
        [[nodiscard]]
        std::size_t pixel_count() const noexcept;

        [[nodiscard]]
        Pixel* data() noexcept;

        cudaStream_t stream() const noexcept;

    
    private:
        std::size_t width_;
        std::size_t height_;
        Pixel* data_;
        cudaStream_t stream_;
};