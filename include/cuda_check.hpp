#pragma once

#include <stdexcept>
#include <cuda_runtime.h>

inline void cuda_check(cudaError_t res, const char* operation) {
    if (res == cudaSuccess) {
        return;
    }

    throw std::runtime_error(std::string{ operation } + ":" + cudaGetErrorString(res) );    
}