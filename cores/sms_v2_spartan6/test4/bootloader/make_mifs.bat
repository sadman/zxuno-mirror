srec_cat vram.mem -vmem -fill 0 0 0x4000 -o vram.bin -binary
cat vram.bin |  xxd -c1 -b | cut -c10-17 > vram.mif


srec_cat boot.mem -vmem -fill 0 0 0x4000 -o boot.bin -binary
cat boot.bin |  xxd -c1 -b | cut -c10-17 > boot.mif


