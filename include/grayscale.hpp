#pragma once

#include "image_op.hpp"

class GrayScale final: public ImageOperation {
    public:
        void apply( DeviceImage& image ) override;
};