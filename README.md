# s5p6818_u-boot

> The u-boot source code structure for the gec6818 board (open-source code only for personal study, borrowed from the source code of Friendly Arm)

Build Step:

1.Go in to the docker

```shell
./run.sh
```

2.Build

```shell
./build.sh
```

3.Outcome

```shell
  u-boot.bin								# uboot main part
  fip-nonsecure.bin							# uboot.bin + fip head
  target/output/gec6818_u-boot_with_fip.img	# final product:spl/bl1,bl2,head,uboot
```


