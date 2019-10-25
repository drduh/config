#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/split-rom.sh

cd util/nvramtool
./nvramtool -C ../../build/coreboot.rom -w gfx_uma_size=224M
./nvramtool -C ../../build/coreboot.rom -w bluetooth=Disable
./nvramtool -C ../../build/coreboot.rom -w wwan=Disable
./nvramtool -C ../../build/coreboot.rom -w wlan=Disable

cd ../../build
rm -fv coreboot-bottom.rom coreboot-top.rom
dd if=coreboot.rom of=coreboot-bottom.rom bs=1M count=8
dd if=coreboot.rom of=coreboot-top.rom bs=1M skip=8
