.PHONY: build run test

build:
	cmake -S . -B build
	cmake --build build

run: build
	./build/cuda_image

test: build
	./build/test_image
	./build/test_device_image
	./build/test_invert
	./build/test_grayscale
	./build/test_brightness
	./build/test_image_pipeline