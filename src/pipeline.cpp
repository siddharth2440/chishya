#include "pipeline.hpp"
#include "device_image.hpp"
#include "cuda_check.hpp"

void ImagePipeline::add( std::unique_ptr<ImageOperation> operation ) {
    operations_.push_back(std::move(operation));
}

void ImagePipeline::process( DeviceImage& image ) {
    for (const auto& operation: operations_) {
        operation->apply(image);
    }
    
    cuda_check( cudaStreamSynchronize(image.stream()), "imAge pipeline execution" );
}