#!/bin/sh


work_dir=".temp"


mkdir --parents $work_dir/cortex-m4/fpv4-sp-d16-hard

obj_files_path="./lib/DPS"
archive_name="dps_slave.a"

current_dir=$(pwd)

cd ./lib/DPS

make CC=arm-none-eabi-gcc C_EXFLAGS="-mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16"
arm-none-eabi-ar rcs $archive_name dps_slave.o c_check_input.o c_vector.o -o
make clean

cd $current_dir
cp ./lib/DPS/$archive_name ./.temp
cp -r ./lib/DPS/dps_slave.h ./lib/DPS/common ./keyword.txt ./library.properties $work_dir

cd $work_dir/cortex-m4/fpv4-sp-d16-hard
echo $(pwd)
ln -s ../../$archive_name $archive_name

cd $current_dir
zip -r dps_slave.zip ./.temp/*

rm -r ./.temp
