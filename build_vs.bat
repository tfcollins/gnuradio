
mkdir c:\projects\gnuradio\build
cd c:\projects\gnuradio\build
cmake -G "%VS%" \
        -DCMAKE_TOOLCHAIN_FILE="c:/tools/vcpkg/scripts/buildsystems/vcpkg.cmake" \
        -DBOOST_ROOT=C:\deps\boost_out \
        -DSWIG_EXECUTABLE:FILEPATH=C:/deps/swig/swigwin-3.0.8/swig.exe \
        -DLOG4CPP_INCLUDE_DIR:PATH=C:/deps/log4cpp/Library/include \
        -DLOG4CPP_LIBRARY:FILEPATH=C:/deps/log4cpp/Library/lib/log4cpp.lib \
        -DMPIR_INCLUDE_DIR:PATH=C:/deps/mpir/Library/include \
        -DMPIR_LIBRARY:FILEPATH=C:/deps/mpir/Library/lib/mpir_static.lib \
        -DMPIRXX_LIBRARY:FILEPATH=C:/deps/mpir/Library/lib/mpirxx_static.lib \
        -DQWT_INCLUDE_DIRS:PATH=C:/deps/Qwt-6.1.5-svn/include \
        -DQWT_LIBRARIES:FILEPATH=C:/deps/Qwt-6.1.5-svn/lib/qwt.lib \
        -DUHD_INCLUDE_DIRS:PATH=C:/deps/uhd/include \
        -DUHD_LIBRARIES:FILEPATH=C:/deps/uhd/lib/uhd.lib \
        -DENABLE_INTERNAL_VOLK:BOOL=ON \
        -DENABLE_DOXYGEN:BOOL=OFF \
        -DENABLE_GR_UHD:BOOL=ON \
        -DENABLE_GR_ZEROMQ:BOOL=OFF \
        -DENABLE_GR_AUDIO:BOOL=ON \
        -DENABLE_GR_VOCODER:BOOL=ON \
        -DENABLE_GR_DTV:BOOL=ON \
        -DENABLE_GR_TRELLIS:BOOL=ON \
        -DENABLE_GR_CHANNELS:BOOL=ON \
        -DENABLE_GR_WAVELET:BOOL=ON \
        -DENABLE_GR_VIDEO_SDL:BOOL=ON \
        -DENABLE_GR_QTGUI:BOOL=ON ..
cmake --build . --config Release -j 2 --target INSTALL
# Collect libs
mkdir .\gnuradio\deps
copy C:\Tools\vcpkg\installed\x64-windows\lib\*.lib .\gnuradio\deps\
copy c:\tools\vcpkg\installed\x64-windows\bin\*.dll .\gnuradio\deps\
xcopy c:\deps\* .\gnuradio\deps\ /s /e
# Create archives
7z a "c:\gnuradio-deps-x64.zip" .\gnuradio\deps
appveyor PushArtifact c:\gnuradio-deps-x64.zip
cd "c:\Program Files"
7z a "c:\gnuradio-x64.zip" gnuradio
appveyor PushArtifact c:\gnuradio-x64.zip

