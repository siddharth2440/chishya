#pragma once

#include "image_op.hpp"

class Invert final: public ImageOperation {
    public:
        void apply( DeviceImage& image ) override;
};