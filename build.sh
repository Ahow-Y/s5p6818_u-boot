#########################################################################
# File Name: build.sh
# Author: csgec
# mail: 12345678@qq.com
# Created Time: 2025年10月27日 星期一 16时54分08秒
#########################################################################
#!/bin/bash
make s5p6818_gec6818_v1_defconfig
if [ $? != 0 ];then
	exit 1
fi
make CROSS_COMPILE=aarch64-linux-gnu-
if [ $? != 0 ];then
	exit 1
fi
mv -f fip-nonsecure.img ./target/
if [ $? != 0 ];then
	exit 1
fi
cd target
dd if=bl1-mmcboot.bin of=gec6818_u-boot_with_fip.img bs=512 seek=0 conv=fdatasync
dd if=fip-loader.img of=gec6818_u-boot_with_fip.img bs=512 seek=128 conv=fdatasync
dd if=fip-secure.img of=gec6818_u-boot_with_fip.img bs=512 seek=768 conv=fdatasync
dd if=fip-nonsecure.img of=gec6818_u-boot_with_fip.img bs=512 seek=3840 conv=fdatasync
sync
mkdir -p output
mv -f gec6818_u-boot_with_fip.img ./output/
cd -
