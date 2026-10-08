#include <iostream>
#include <print>
#include <cstdio>

#include "image.hpp"
#include "device_image.hpp"
#include "pipeline.hpp"
#include "brightness.hpp"
#include "grayscale.hpp"
#include "invert.hpp"
#include "timer.hpp"

#include <cuda_runtime.h>

#include "stb/stb_image.h"
#include "stb/stb_image_write.h"

int main() {

    Timer timer;

    constexpr auto input_path = "assets/image.jpg";
    constexpr auto output_path = "assets/image_output.jpg";

    Image image = load_image(input_path);
    std::cout << "Loaded Image: " << image.width() << "x" << image.height() << "\n";
    std::cout << "Load: " << timer.elapsed_ms() << " ms\n";

    timer = Timer{};

    DeviceImage device_image{ image };
    std::cout << "Upload H->D: " << timer.elapsed_ms() << " ms\n";

    ImagePipeline pipeline{};

    pipeline.add( std::make_unique<GrayScale>() );
    // pipeline.add( std::make_unique<Invert>() );
    pipeline.add( std::make_unique<Brightness>(50) );
    pipeline.process( device_image );

    timer = Timer{};
    device_image.download(image);
    std::cout << "GPU pipeline: " << timer.elapsed_ms() << " ms\n";

    timer = Timer{};
    save_image( image, output_path );
    std::cout << "Save: " << timer.elapsed_ms() << " ms\n";

    return EXIT_SUCCESS;

}