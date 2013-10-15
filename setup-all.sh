#!/bin/bash -
set -e
echo ---- Fetching webconnect dependencies into $(dirname `pwd`)/prereqs ----
cd ..
mkdir -p prereqs
mkdir -p $HOME/local
cd prereqs
echo '---- Checking out ehs trunk code ----'
svn checkout svn://svn.code.sf.net/p/ehs/code/trunk ehs-code
cd ehs-code
make -f Makefile.am
./configure --with-ssl --prefix=$HOME/local
echo '---- Starting ehs build ----'
make
echo '---- Finished building ehs ----'
make install
echo '---- Finished installing ehs ----'
cd ..
echo '---- Checking out freerdp master ----'
git clone https://github.com/FreeRDP/FreeRDP.git
cd FreeRDP
mkdir -p build && cd build && cmake -DCMAKE_INSTALL_PREFIX=$HOME/local ..
echo '---- Building freerdp ----'
make
echo '---- Finished building freerdp ----'
make install
echo '---- Finished installing freerdp ----'
read -p "Press [Enter] key to start backup..."
echo '---- Going back to webconnect ----'
cd ../../../FreeRDP-WebConnect/wsgate/
make -f Makefile.am
./configure
echo '---- Building webconnect ----'
make
echo '---- Finished successfully ----'
echo '---- To run please use `cd wsgate && ./wsgate -c wsgate.mrd.ini` and connect on localhost:8888 ----'