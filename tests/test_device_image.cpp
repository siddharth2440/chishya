#include <iostream>

#include <cassert>
#include <device_image.hpp>

int main() {

    Image original { 2, 2 };

    original.data()[0] = Pixel { 10, 20, 30 };
    original.data()[1] = Pixel { 40, 50, 60 };
    original.data()[2] = Pixel { 70, 80, 90 };
    original.data()[3] = Pixel { 100, 110, 120 };

    DeviceImage device_image{ original };

    Image downloaded { 2, 2 };

    device_image.download(downloaded);

    for ( std::size_t i = 0; i < original.height() * original.width(); ++i ) {
        assert( downloaded.data()[i].r == original.data()[i].r );
        assert( downloaded.data()[i].g == original.data()[i].g );
        assert( downloaded.data()[i].b == original.data()[i].b );
    }

    std::printf("Test: test_device_image: PASS\n");

}