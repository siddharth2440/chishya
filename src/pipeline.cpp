#include "pipeline.hpp"
#include "device_image.hpp"

void ImagePipeline::add( std::unique_ptr<ImageOperation> operation ) {
    operations_.push_back(std::move(operation));
}

void ImagePipeline::process( DeviceImage& image ) {

    std::printf("operations: %zu\n", operations_.size());

    for (const auto& operation: operations_) {
        std::printf("applying operation\n");
        operation->apply(image);
    }
}