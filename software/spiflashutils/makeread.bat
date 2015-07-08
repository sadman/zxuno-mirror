@echo off
del readspi.bin
del readspi.ihx
del readspi

sdcc -mz80 --reserve-regs-iy --opt-code-size --max-allocs-per-node 10000 ^
--nostdlib --nostdinc --no-std-crt0 --code-loc 8192 --data-loc 12288 readspi.c

makebin -p readspi.ihx readspi.bin
dd if=readspi.bin of=READSPI bs=1 skip=8192


