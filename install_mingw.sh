#!/usr/bin/bash.exe

# Exit immediately if an error occurs
set -e

export PATH=/bin:/usr/bin:/${MINGW_VERSION}/bin:/c/Program\ Files/Git/cmd:/c/Windows/System32

WORKDIR=${PWD}

JOBS=-j3

CC=/${MINGW_VERSION}/bin/${ARCH}-w64-mingw32-gcc.exe
CXX=/${MINGW_VERSION}/bin/${ARCH}-w64-mingw32-g++.exe
CMAKE_OPTS="-DCMAKE_BUILD_TYPE=Release \
	-DCMAKE_INSTALL_PREFIX=/${MINGW_VERSION} \
	-DCMAKE_C_COMPILER:FILEPATH=${CC} \
	-DCMAKE_CXX_COMPILER:FILEPATH=${CXX} \
	-DCMAKE_C_STANDARD=11 \
	-DPKG_CONFIG_EXECUTABLE:FILEPATH=/${MINGW_VERSION}/bin/pkg-config.exe"

DEPENDENCIES="
	mingw-w64-${ARCH}-boost \
	mingw-w64-${ARCH}-fftw \
	mingw-w64-${ARCH}-orc \
	glib2 \
	mingw-w64-${ARCH}-qwt-qt5 \
	mingw-w64-${ARCH}-swig \
	mingw-w64-${ARCH}-gtk3 \
	python3-mako \
	python3-six \
	mingw-w64-${ARCH}-cmake \
"

$CC --version
pacman --force --noconfirm -Sy ${DEPENDENCIES}

build_log4cpp() {
	git clone https://github.com/orocos-toolchain/log4cpp ${WORKDIR}/log4cpp
	mkdir ${WORKDIR}/log4cpp/build-${ARCH}
	cd ${WORKDIR}/log4cpp/build-${ARCH}

	# this is a fix for MINGW long long long is too long - patch the config-MingW32.h
	# probably not the cleanest patch - deletes this line
	# https://github.com/orocos-toolchain/log4cpp/blob/359be7d88eb8a87f618620918c73ef1fc6e87242/include/log4cpp/config-MinGW32.h#L27
	# we need a better patch here or maybe use another repo
	sed '27d' ../include/log4cpp/config-MinGW32.h > temp && mv temp ../include/log4cpp/config-MinGW32.h

	cmake -G 'Unix Makefiles' \
	${CMAKE_OPTS} ${WORKDIR}/log4cpp
	make ${JOBS} install
	DESTDIR=${WORKDIR} make ${JOBS} install

	# LOG4CPP puts dll in wrong file for MINGW - it should be in bin, but it puts it in lib so we copy it
	mkdir -p ${WORKDIR}/msys64/${MINGW_VERSION}/bin
	cp ${WORKDIR}/msys64/${MINGW_VERSION}/lib/liblog4cpp.dll ${WORKDIR}/msys64/${MINGW_VERSION}/bin/liblog4cpp.dll
}

build_log4cpp
