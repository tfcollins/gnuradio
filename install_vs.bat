@echo off

cd C:\deps
wget https://github.com/tfcollins/gr-win-dependencies/releases/download/v0.2/boost.7z -q -O boost.7z
7z x boost.7z
rm boost.7z
dir
cd c:\
    
cd C:\deps
wget https://github.com/tfcollins/gr-win-dependencies/releases/download/v0.2/Qwt_6_1_5.7z -q -O Qwt_6_1_5.7z
7z x Qwt_6_1_5.7z
rm Qwt_6_1_5.7z
cd C:\
"SET PATH=C:\\deps\\Qwt-6.1.5-svn\\lib;%PATH%"
"SET PATH=C:\\deps\\Qwt-6.1.5-svn\\include;%PATH%"

wget https://github.com/tfcollins/gr-win-dependencies/releases/download/v0.2/log4cpp.7z -q -O "log4cpp.7z"
mkdir C:\deps\log4cpp
7z x log4cpp.7z -oC:\deps\
rm log4cpp.7z
    
wget https://github.com/tfcollins/gr-win-dependencies/releases/download/v0.2/mpir.7z -q -O "mpir.7z"
mkdir C:\deps\mpir
7z x mpir.7z -oC:\deps\
rm mpir.7z
    
wget https://dl.bintray.com/zeromq/generic/libzmq-v141-x64-4_3_2.zip -q -O libzmq.zip
mkdir C:\deps\libzmq
unzip -qq libzmq.zip -d C:\deps\libzmq

wget https://github.com/tfcollins/gr-win-dependencies/releases/download/v0.2/swig.7z -q -O "swig.7z"
mkdir C:\deps\swig
7z x swig.7z -oC:\deps\
rm swig.7z
dir C:\deps\swig

wget https://github.com/tfcollins/gr-win-dependencies/releases/download/v0.2/uhd.7z -q -O "uhd.7z"
mkdir C:\deps\uhd
7z x uhd.7z -oC:\deps\
rm uhd.7z

wget https://github.com/tfcollins/gr-win-dependencies/releases/download/v0.2/gvsbuild-vs15-x64.7z -q -O "gvsbuild-vs15-x64.7z"
mkdir C:\deps\gtk
7z x gvsbuild-vs15-x64.7z -oC:\deps\gtk
rm gvsbuild-vs15-x64.7z   
mv C:\deps\gtk C:\\gvsbuild
"SET PATH=C:\\gvsbuild;%PATH%"
"SET PATH=C:\\gvsbuild\\lib;%PATH%"
"SET PATH=C:\\gvsbuild\\bin;%PATH%"
"SET PYTHONPATH=C:\\gvsbuild;%PYTHONPATH%"
"SET PYTHONPATH=C:\\gvsbuild\\lib;%PYTHONPATH%"
"SET PYTHONPATH=C:\\gvsbuild\\bin;%PYTHONPATH%"
pip install C:\gvsbuild\python\pycairo-1.18.2-cp37-cp37m-win_amd64.whl
pip install C:\gvsbuild\python\PyGObject-3.34.0-cp37-cp37m-win_amd64.whl 

cd C:\tools\vcpkg
git pull > nul 2>&1
.\bootstrap-vcpkg.bat > nul 2>&1
vcpkg integrate install
cd %APPVEYOR_BUILD_FOLDER%
vcpkg install fftw3:x64-windows
vcpkg install gsl:x64-windows
vcpkg install sdl1:x64-windows

