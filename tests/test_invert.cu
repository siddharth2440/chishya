#include <cassert>
#include <iostream>

#include "device_image.hpp"
#include "invert.hpp"

int main() {
    Image image{ 2, 2 };

    image.data()[0] = Pixel { 10, 20, 30 };
    image.data()[1] = Pixel { 40, 50, 60 };
    image.data()[2] = Pixel { 70, 80, 90 };
    image.data()[3] = Pixel { 100, 110, 120 };

    DeviceImage device_image{ image };

    Invert invert;

    invert.apply(device_image);
    device_image.download( image );


    assert( image.data()[0].r == 245 );
    assert( image.data()[0].g == 235 );
    assert( image.data()[0].b == 225 );

    assert( image.data()[1].r == 215 );
    assert( image.data()[1].g == 205 );
    assert( image.data()[1].b == 195 );

    assert( image.data()[2].r == 185 );
    assert( image.data()[2].g == 175 );
    assert( image.data()[2].b == 165 );

    assert( image.data()[3].r == 155 );
    assert( image.data()[3].g == 145 );
    assert( image.data()[3].b == 135 );


    std::printf("test_invert: PASS\n");
}