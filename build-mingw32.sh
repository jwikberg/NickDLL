rm -rf build
mkdir build && cd build
cmake --log-level=ERROR -DCMAKE_TOOLCHAIN_FILE=../toolchain-clang-mingw32.cmake -DCMAKE_BUILD_TYPE=Release ..
cmake --build . -j$(nproc)
