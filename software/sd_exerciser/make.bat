@echo off
sdcc -mz80 --reserve-regs-iy --opt-code-size --max-allocs-per-node 30000 ^
--nostdlib --nostdinc --no-std-crt0 --out-fmt-s19 ^
--code-loc 32768 --data-loc 0 --stack-loc 65535 sdexert.c
s19tozx -i sdexert.s19 -o sdexert.tap
copy sdexert.tap t:\
rem cgleches sdexert.tap sdexert.wav

rem sdcc -mz80 --reserve-regs-iy --opt-code-size --max-allocs-per-node 10000 ^
rem --nostdlib --nostdinc --no-std-crt0 --code-loc 8192 joyconf.c
rem makebin -p joyconf.ihx joyconf.bin
rem dd if=joyconf.bin of=JOYCONF bs=1 skip=8192 status=noxfer


