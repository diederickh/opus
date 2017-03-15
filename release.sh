#!/bin/sh
bd=${PWD}
if [ ! -d ${bd}/build ] ; then
    mkdir ${bd}/build
fi

cd ${bd}/build
cmake -DCMAKE_INSTALL_PREFIX=${bd}/installed \
      ..

if [ $? -ne 0 ] ; then
    echo "Error"
    exit
fi

cmake --build . --target install



