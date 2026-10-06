.PHONY: build run

build:
	cmake -S . -B build
	cmake --build build

run: build
	./build/cuda_image