@echo off
sdcc -mz80 --reserve-regs-iy --opt-code-size --max-allocs-per-node 30000 ^
--nostdlib --nostdinc --no-std-crt0 --out-fmt-s19 ^
--code-loc 32768 --data-loc 0 --stack-loc 65535 joyconf.c
s19tozx -i joyconf.s37 -o joyconf.tap
cgleches joyconf.tap joyconf.wav

