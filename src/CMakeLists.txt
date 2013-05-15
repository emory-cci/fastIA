add_subdirectory(common)

set(NS_FEATURES OFF CACHE BOOL "Building Features Extraction")
set(NS_SEGMENT OFF CACHE BOOL "Building Segmentation")

if(NS_FEATURES OR NS_SEGMENT)
    #### OpenCV
    find_path(OpenCV_CMAKE_DIR NAMES FindOpenCV.cmake OpenCVConfig.cmake
    	HINTS ${CMAKE_MODULE_PATH} ENV OPENCV_HOME
    	DOC "path to FindOpenCV.cmake or OpenCVConfig.cmake file") 
    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${OpenCV_CMAKE_DIR})
    find_package( OpenCV REQUIRED )
    #message(STATUS "openCV lib = ${OpenCV_LIBS}")
    
    #### CUDA
    set(USE_CUDA OFF CACHE BOOL "Include NVidia Cuda Runtime support")
    if(USE_CUDA)
        find_package(CUDA 4.0)
        
        if(CUDA_FOUND) 		
            message(STATUS "CUDA detected: " ${CUDA_VERSION})
    
            # These vars will be processed in other scripts
         	set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} --use_fast_math -arch=sm_20 -DPREFIX_SUM)
         #	set(CUDA_NVCC_FLAGS_DEBUG ${CUDA_NVCC_FLAGS_DEBUG} -G)  # too slow...
           set(CUDA_NVCC_FLAGS_DEBUG ${CUDA_NVCC_FLAGS_DEBUG} -DTHRUST_DEBUG)
            message(STATUS "CUDA NVCC target flags: ${CUDA_NVCC_FLAGS}")
    	add_definitions( -DWITH_CUDA )
        endif(CUDA_FOUND)
    else(USE_CUDA)
    	set(CUDA_FOUND 0)
    endif(USE_CUDA)
    
endif(NS_FEATURES OR NS_SEGMENT)

if (NS_FEATURES)
    add_subdirectory(features)
endif(NS_FEATURES)
    

if (NS_SEGMENT)
    add_subdirectory(segment)
endif(NS_SEGMENT)


