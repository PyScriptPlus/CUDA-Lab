#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <random>
#include <time.h>
#include <chrono>

__host__ void generateRandomC() {

	srand(time(NULL));
	for(int i = 1; i <= 20; ++i)
	{
		printf("Random number: %d\t", (rand() % (10 - 0 + 1) + 0));
		if(i % 5 == 0) printf("\n");
	}
}
__host__ int generateRandomCplus() {
	std::mt19937 rnd{
		static_cast<unsigned int>
		(std::chrono::steady_clock::now().time_since_epoch().count())};
	std::uniform_int_distribution number{0,9};
	return number(rnd);
}

__device__ int increment(int x) {
	return ++x;
}

__global__ void rnd(int *res) {
	printf("Number increment with GPU: %d", increment(*res));
}


int main() {

	int number = generateRandomCplus();
	std::cout << "Number before increment: " << number << '\n';

	int *deviceNumber;
	cudaMalloc(&deviceNumber, sizeof(int));
	cudaMemcpy(deviceNumber, &number, sizeof(int), cudaMemcpyHostToDevice);

	rnd<<<1,1>>>(deviceNumber);
	cudaDeviceSynchronize();
	cudaFree(deviceNumber);

	std::cout << "\n\n\n";

	// Cpu:
	generateRandomC();

	return 0;
}
