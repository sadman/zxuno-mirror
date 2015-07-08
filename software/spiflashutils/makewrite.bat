@echo off
del writespi.bin
del writespi.ihx
del writespi

sdcc -mz80 --reserve-regs-iy --opt-code-size --max-allocs-per-node 10000 ^
--nostdlib --nostdinc --no-std-crt0 --code-loc 8192 --data-loc 12288 writespi.c

makebin -p writespi.ihx writespi.bin
dd if=writespi.bin of=WRITESPI bs=1 skip=8192


