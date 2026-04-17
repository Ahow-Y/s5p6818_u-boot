#########################################################################
# File Name: build.sh
# Author: csgec
# mail: 12345678@qq.com
# Created Time: 2025年10月27日 星期一 16时54分08秒
#########################################################################
#!/bin/bash
make s5p6818_gec6818_v1_defconfig
make CROSS_COMPILE=aarch64-linux-gnu-
mv fip-nonsecure.img ./target/
cd target
dd if=bl1-mmcboot.bin of=gec6818_u-boot_with_fip.img bs=512 seek=0 conv=fdatasync
dd if=fip-loader.img of=gec6818_u-boot_with_fip.img bs=512 seek=128 conv=fdatasync
dd if=fip-secure.img of=gec6818_u-boot_with_fip.img bs=512 seek=768 conv=fdatasync
dd if=fip-nonsecure.img of=gec6818_u-boot_with_fip.img bs=512 seek=3840 conv=fdatasync
sync
mkdir -p output
mv gec6818_u-boot_with_fip.img ./output/
cd -
