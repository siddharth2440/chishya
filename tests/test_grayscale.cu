#include <iostream>
#include <cassert>

#include "grayscale.hpp"
#include "device_image.hpp"

int main() {
    Image image{ 1, 1 };
    image.data()[0] = Pixel { 255, 0, 0 };

    DeviceImage device_image{ image };
    GrayScale grayscale{};

    grayscale.apply( device_image );

    device_image.download( image );

    const Pixel result = image.data()[0];

    assert( result.r == 76 );
    assert( result.g == 76 );
    assert( result.b == 76 );

    std::cout << "test grayscale: PASS\n";
}