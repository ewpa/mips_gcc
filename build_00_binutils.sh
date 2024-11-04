#!/bin/bash 

export enable_werror=no

source include.sh

ver=binutils-2.22
arch_url=http://ftp.gnu.org/gnu/binutils/$ver.tar.bz2
arch_dir=$ver
arch_name=$ver.tar.bz2

cwd=`pwd`

cd $stm_dir_tools
did_it_work $? 

if [ -f $arch_name ]; then
    echo file exists - $arch_name
else
    wget $arch_url
    did_it_work $? 
fi

if [ -d $arch_dir ]; then
    echo old dir exists - rm -rf $arch_dir
    rm -rf $arch_dir
    did_it_work $? 
fi

tar -xvjf $arch_name
did_it_work $? 

cd $arch_dir
did_it_work $? 

mkdir build
did_it_work $? 
cd build
did_it_work $? 
../configure --target=mipsel-sde-elf  \
             --prefix=$TOOLPATH_STM32  \
             --enable-interwork  \
             --with-gnu-as  \
             --with-gnu-ld  \
             --disable-nls 
did_it_work $? 

make $PARALLEL 
did_it_work $? 
make install 
did_it_work $? 


echo "Done:"$0
exit 0
