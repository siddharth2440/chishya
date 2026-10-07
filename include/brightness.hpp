#pragma once

#include "image_op.hpp"

class Brightness final: public ImageOperation {
    public:
        explicit Brightness(int amount) noexcept;
        void apply( DeviceImage& image ) override;

    private:
        int amount_;

};