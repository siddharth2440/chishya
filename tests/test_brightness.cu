#include "brightness.hpp"
#include "device_image.hpp"

#include <cassert>
#include <iostream>

int main() {
    Image image{ 2, 1 };

    image.data()[0] = Pixel{ 100, 150, 200 };
    image.data()[1] = Pixel{ 240, 10, 20 };

    DeviceImage device_image{ image };
    Brightness brightness{ 30 };

    brightness.apply(device_image);
    device_image.download(image);

    assert( image.data()[0].r == 130 );
    assert( image.data()[0].g == 180 );
    assert( image.data()[0].b == 230 );

    assert( image.data()[1].r == 255 );
    assert( image.data()[1].g == 40 );
    assert( image.data()[1].b == 50 );

    std::cout << "test_brightness: PASS\n";
}