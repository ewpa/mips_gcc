#!/bin/bash 

source include.sh

#################
### gdb #########
#################
gdb_ver=8.3.1
arch_url=http://ftp.gnu.org/gnu/gdb/gdb-$gdb_ver.tar.xz
arch_dir=gdb-8.3.1
arch_name=gdb-$gdb_ver.tar.xz

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

xzcat -T`getconf _NPROCESSORS_ONLN` $arch_name | tar -xvf -
did_it_work $? 

cd $arch_dir
did_it_work $? 

mkdir build
did_it_work $? 
cd build
did_it_work $? 
../configure --target=mipsel-sde-elf \
                      --prefix=$TOOLPATH_STM32  \
                      --enable-languages=c,c++ \
                      --enable-interwork \
                      --enable-tui \
                      --with-newlib \
                      --disable-werror \
                      --disable-libada \
                      --disable-libssp 
did_it_work $? 

make $PARALLEL 
did_it_work $? 
make install 
did_it_work $? 

cd $TOOLPATH_STM32/bin
did_it_work $? 
mv mipsel-sde-elf-gdb    mipsel-sde-elf-gdb-$gdb_ver
did_it_work $? 
mv mipsel-sde-elf-gdbtui mipsel-sde-elf-gdbtui-$gdb_ver
did_it_work $? 
mv mipsel-sde-elf-run    mipsel-sde-elf-run-$gdb_ver
did_it_work $? 

ln -s mipsel-sde-elf-gdb-$gdb_ver    mipsel-sde-elf-gdb
did_it_work $? 
ln -s mipsel-sde-elf-gdbtui-$gdb_ver mipsel-sde-elf-gdbtui
did_it_work $? 
ln -s mipsel-sde-elf-run-$gdb_ver    mipsel-sde-elf-run
did_it_work $? 


echo "Done:"$0
exit 0
