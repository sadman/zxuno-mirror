cd ..
call  make.bat
cd roms
..\sjasmplus 06000.asm
copy /b ESXMMC086b4.BIN+              ^
        06000.bin+                    ^
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
        HungryHorace.rom+             ^
        HoraceSpiders.rom+            ^
        Planetoids.rom+               ^
        SpaceRaiders.rom+             ^
        MiscoJones.rom                ^
    roms_04000.bin

call promgen  -w -p bin -s 4 -r boot_header.hex -o boot_header.bin
call promgen  -w -spi -p mcs -o tld_zxuno.mcs       ^
              -s 4096 -u 0 ..\..\cores\spectrum_v2_spartan6\test19\tld_zxuno.bit
call promgen  -w -spi -p mcs -o tld_sam.mcs       ^
              -s 4096 -u 0 ..\..\cores\sam_coupe_spartan6\test4\tld_sam.bit
srec_cat  boot_header.bin -binary  ^
          roms_04000.bin  -binary -offset 0x04000   ^
	  tld_zxuno.mcs   -Intel  -offset 0x58000   ^
          tld_sam.mcs     -Intel  -offset 0xAC000   ^
 	  -generate 0xFFFFF 0x100000 -constant 0 	    ^
          -o tld_zxuno_multiboot.bin     -binary

srec_cat  tld_zxuno_multiboot.bin     -binary       ^
          -o prom_multiboot.mcs     -Intel	    ^
          -line-length=44                           ^
          -line-termination=nl
..\fcut tld_zxuno_multiboot.bin 58000 54000 machine1.bin
..\fcut tld_zxuno_multiboot.bin AC000 54000 machine2.bin
GenRom 0 202 0 0 0 BIOS ..\firmware.rom firmware.tap
GenRom 0 0 0 0 0 ESXDOS ESXMMC086b4.BIN  esxdos.tap
GenRom 0 0 0 0 0 Machine machine1.bin  machine1.tap
GenRom 0 0 0 0 0 Machine2 machine2.bin  machine2.tap
CgLeches firmware.tap firmware.wav
CgLeches machine1.tap  machine1.wav
CgLeches machine2.tap  machine2.wav
