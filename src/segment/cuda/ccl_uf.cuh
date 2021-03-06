/*
 * kernel for utility functions
  */
#include <cuda.h>
#include <cuda_runtime.h>


namespace nscale { 
namespace gpu {

void CCL(unsigned char* img, int w, int h, int* d_label, int bgval, int connectivity, cudaStream_t stream);
int relabel(int w, int h, int* d_label, int bgval, cudaStream_t stream);
int areaThreshold(int w, int h, int* d_label, int bgval, int minSize, int maxSize, cudaStream_t stream);
int areaThreshold2(int w, int h, int* d_label, int bgval, int minSize, int maxSize, cudaStream_t stream);
int* boundingBox(const int w, const int h, int* d_label, int bgval, int &compcount, cudaStream_t stream);
int* boundingBox2(const int w, const int h, int* d_label, int bgval, int &compcount, cudaStream_t stream);


}}
