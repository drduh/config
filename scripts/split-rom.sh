#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/split-rom.sh
cd build/util/nvramtool || exit 1
./nvramtool -C ../../coreboot.rom -w bluetooth=Disable
./nvramtool -C ../../coreboot.rom -w gfx_uma_size=224M
./nvramtool -C ../../coreboot.rom -w wlan=Disable
./nvramtool -C ../../coreboot.rom -w wwan=Disable
cd ../.. || exit 1
rm -f coreboot-bottom.rom coreboot-top.rom
dd if=coreboot.rom of=coreboot-bottom.rom bs=1M count=8
dd if=coreboot.rom of=coreboot-top.rom bs=1M skip=8
mkdir -p "${HOME}/build/coreboot/write/$(date +%F)"
mv ./*.rom "${HOME}/build/coreboot/write/$(date +%F)"
