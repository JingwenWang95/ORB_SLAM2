# Install OpenGL and GLEW (used for Pangolin)
sudo apt-get install -y \
    libgl1-mesa-dev \
    libglew-dev

cd Thirdparty
# Install OpenCV
echo "Configuring and building OpenCV ..."
git clone --branch 3.2.0 --depth=1 https://github.com/opencv/opencv.git
cd opencv
mkdir -p build
cd build
# Specify the path where you want to install OpenCV, in this case it is "CURRENT_DIR/../install",
# i.e. "ORB-SLAM2-DIR/Thirdparty/opencv/install". You can change it to your prefered location
# by specifying a difierent path after -DCMAKE_INSTALL_PREFIX=
cmake \
    -DCMAKE_INSTALL_PREFIX="`pwd`/../install" \
    -DCMAKE_BUILD_TYPE=Release \
    -DWITH_CUDA=OFF  \
    -DBUILD_DOCS=OFF  \
    -DBUILD_PACKAGE=OFF \
    -DBUILD_TESTS=OFF  \
    -DBUILD_PERF_TESTS=OFF  \
    -DBUILD_opencv_apps=OFF \
    -DBUILD_opencv_calib3d=ON  \
    -DBUILD_opencv_cudaoptflow=OFF  \
    -DBUILD_opencv_dnn=OFF  \
    -DBUILD_opencv_dnn_BUILD_TORCH_IMPORTER=OFF  \
    -DBUILD_opencv_features2d=ON \
    -DBUILD_opencv_flann=ON \
    -DBUILD_opencv_java=ON  \
    -DBUILD_opencv_objdetect=ON  \
    -DBUILD_opencv_python2=OFF  \
    -DBUILD_opencv_python3=OFF  \
    -DBUILD_opencv_photo=ON \
    -DBUILD_opencv_stitching=ON  \
    -DBUILD_opencv_superres=ON  \
    -DBUILD_opencv_shape=ON  \
    -DBUILD_opencv_videostab=OFF \
    -DBUILD_PROTOBUF=OFF \
    -DWITH_1394=OFF  \
    -DWITH_GSTREAMER=OFF  \
    -DWITH_GPHOTO2=OFF  \
    -DWITH_MATLAB=OFF  \
    -DWITH_NVCUVID=OFF \
    -DWITH_OPENCL=OFF \
    -DWITH_OPENCLAMDBLAS=OFF \
    -DWITH_OPENCLAMDFFT=OFF \
    -DWITH_TIFF=OFF  \
    -DWITH_VTK=OFF  \
    -DWITH_WEBP=OFF  \
    -DWITH_FFMPEG=OFF \
    ..
make -j
make install
cd ../../

# Install Eigen
echo "Configuring and building Eigen ..."
git clone https://gitlab.com/libeigen/eigen.git
cd eigen
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j 
make install
cd ../../

# Install Pangolin
echo "Downloading and building Pangolin ..."
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j 
make install
cd ../../

# Build DBoW2
echo "Configuring and building Thirdparty/DBoW2 ..."
cd DBoW2
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j
cd ../../

# Build g2o
echo "Configuring and building Thirdparty/g2o ..."
cd g2o
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j
cd ../../../

# Extract vocabulary
echo "Uncompress vocabulary ..."
cd Vocabulary
tar -xf ORBvoc.txt.tar.gz
cd ..

# Build ORB-SLAM2
echo "Configuring and building ORB_SLAM2 ..."
mkdir build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j




