cd ..
call  make.bat
cd roms
..\sjasmplus 03000.asm
call promgen  -w -p mcs -r boot_header.hex -o boot_header.mcs
srec_cat  boot_header.mcs     -Intel       ^
          -o boot_header.bin  -binary
..\fcut boot_header.bin 0 038 boot_header.cut
..\fcut zeros.bin       0 fc8 boot_header_fill.cut
copy /b boot_header.cut+              ^
        boot_header_fill.cut+         ^
        ESXMMC086b4.BIN+              ^
        03000.bin+                    ^
        ..\firmware.rom+              ^
        48.rom+                       ^
        128en.rom+                    ^
        plus3es40zxmmc.rom+           ^
        se.rom+                       ^
        leches.rom+                   ^
        ManicMiner.rom+               ^
        JetSetWilly.rom+              ^
        LalaPrologue.rom+             ^
        Chess.rom+                    ^
        Backgammon.rom+               ^
        HungryHorace.rom+             ^
        HoraceSpiders.rom+            ^
        Planetoids.rom+               ^
        SpaceRaiders.rom+             ^
        MiscoJones.rom                ^
    roms_00000.bin
call promgen  -w -spi -p mcs -o tld_zxuno.mcs       ^
              -s 4096 -u 0 ..\..\cores\spectrum_v2_spartan6\test19\tld_zxuno.bit
call promgen  -w -spi -p mcs -o tld_sam.mcs       ^
              -s 4096 -u 0 ..\..\cores\sam_coupe_spartan6\test4\tld_sam.bit
..\fcut zeros.bin       0 001 zero1byte.cut
srec_cat  roms_00000.bin  -binary -offset 0x00000   ^
          tld_zxuno.mcs   -Intel  -offset 0x59000   ^
          tld_sam.mcs     -Intel  -offset 0xAC800   ^
          zero1byte.cut   -binary -offset 0xfffff   ^
          -o prom_multiboot.mcs     -Intel          ^
          -line-length=44                           ^
          -line-termination=nl
srec_cat  prom_multiboot.mcs     -Intel       ^
          -o tld_zxuno_multiboot.bin  -binary
..\fcut tld_zxuno_multiboot.bin 59000 53800 machine1.bin
..\fcut tld_zxuno_multiboot.bin AC800 53800 machine2.bin
..\fcut zeros.bin 0 800 zeros800.bin
copy /b machine1.bin+zeros800.bin machine1.rom
copy /b machine2.bin+zeros800.bin machine2.rom
GenRom 0 202 0 0 0 BIOS ..\firmware.rom firmware.tap
GenRom 0 0 0 0 0 ESXDOS ESXMMC086b4.BIN  esxdos.tap
GenRom 0 0 0 0 0 Machine machine1.rom  machine1.tap
GenRom 0 0 0 0 0 Machine2 machine2.rom  machine2.tap
CgLeches firmware.tap firmware.wav
CgLeches machine1.tap  machine1.wav
CgLeches machine2.tap  machine2.wav
