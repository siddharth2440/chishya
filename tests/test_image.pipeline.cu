#include <cassert>
#include <iostream>

#include "image.hpp"
#include "device_image.hpp"
#include "pipeline.hpp"

#include "invert.hpp"
#include "grayscale.hpp"
#include "brightness.hpp"

int main() {

    Image img { 1, 1 };
    img.data()[0] = Pixel{ 255, 0, 0 };

    DeviceImage device_img { img };
    ImagePipeline pipeline {};

    pipeline.add(std::make_unique<Invert>());
    pipeline.add(std::make_unique<GrayScale>());
    pipeline.add(std::make_unique<Brightness>(20));

    pipeline.process(device_img);
    device_img.download( img );

    const Pixel result = img.data()[0];
    std::printf("Pipeline result: {%d, %d, %d}\n", result.r, result.g, result.b );

    assert(result.r == 198);

    assert( result.r == 198 );
    assert( result.g == 198 );
    assert( result.b == 198 );

    std::cout << "tst_image_pipeline: PASS\n";
}