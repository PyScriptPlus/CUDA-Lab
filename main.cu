#include <iostream>
#include <stdio.h>
#include <cuda_runtime.h>
//#include <cuda_runtime_api.h>

__global__ void welcomeGPU() {
	printf("GPU run!\n");
	printf("Welcome GPU 3070Ti SUPRIM X :) thread: %d\n", threadIdx.x);
	return;
}

int main() {

	welcomeGPU<<<1,3>>>();

	// wait for kernel execution to complete
    cudaDeviceSynchronize();

	std::cout << "\nCpu run!\n";
	return 0;
}
