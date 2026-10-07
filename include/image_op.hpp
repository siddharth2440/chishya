#pragma once

class DeviceImage;


class ImageOperation {
    public:
        virtual ~ImageOperation() = default;
        virtual void apply(DeviceImage& image) = 0;
};
