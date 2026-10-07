#pragma once

#include "image_op.hpp"

#include <memory>
#include <vector>

class DeviceImage;

class ImagePipeline {

    public:
        void add(std::unique_ptr<ImageOperation> op);
        void process(DeviceImage& img);

    private:
        std::vector<std::unique_ptr<ImageOperation>> operations_;

};