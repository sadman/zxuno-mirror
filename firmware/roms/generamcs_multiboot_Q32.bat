SETLOCAL ENABLEEXTENSIONS
SETLOCAL DISABLEDELAYEDEXPANSION
SET "zCORE2=Sam Coupe"
SET "zCORE3=Master System"
SET "zCORE4=Jupiter ACE"
SET "zCORE5=Oric Atmos"
SET "zCORE6=VIC-20"
SET "zCORE7=Apple II"
SET "zCORE8=Acorn Atom"
SET "zCORE9="
SET "path_ZXCORE=..\..\cores\spectrum_v2_spartan6\test20\tld_zxuno_v3.bit"
SET "path_zCORE2=..\..\cores\sam_coupe_spartan6\test4\tld_sam_v3.bit"
SET "path_zCORE3=..\..\cores\sms_v2_spartan6\test2\sms_rgb_final_v3.bit"
SET "path_zCORE4=..\..\cores\jupiter_ace_spartan6\test2\tld_jace_spartan6.bit"
SET "path_zCORE5=..\..\cores\oric_spartan6\test1\build\oric.bit"
SET "path_zCORE6=..\..\cores\vic20_spartan6\test1\ise\vic20.bit"
SET "path_zCORE7=..\..\cores\Apple2_spartan6\test2\build\apple2_top_v3.bit"
SET "path_zCORE8=..\..\cores\acorn_atom_spartan6\test2\working\atomic_top_zxuno_v3.bit"
SET "path_zCORE9="
call name9cores.bat
cd ..
call  make.bat
cd roms
..\sjasmplus 06000_tmp.asm
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

call promgen  -w -spi -p mcs -o tld_zxuno.mcs -s 4096 -u 0 %path_ZXCORE%
if defined path_zCORE2 (call promgen  -w -spi -p mcs -o core2.mcs -s 4096 -u 0 %path_zCORE2%) ELSE ^
srec_cat -generate 0x57FFF 0x58000 -constant 0 -o core2.mcs -Intel -line-length=44 -line-termination=nl
if defined path_zCORE3 (call promgen  -w -spi -p mcs -o core3.mcs -s 4096 -u 0 %path_zCORE3%) ELSE ^
srec_cat -generate 0x57FFF 0x58000 -constant 0 -o core3.mcs -Intel -line-length=44 -line-termination=nl
if defined path_zCORE4 (call promgen  -w -spi -p mcs -o core4.mcs -s 4096 -u 0 %path_zCORE4%) ELSE ^
srec_cat -generate 0x57FFF 0x58000 -constant 0 -o core4.mcs -Intel -line-length=44 -line-termination=nl
if defined path_zCORE5 (call promgen  -w -spi -p mcs -o core5.mcs -s 4096 -u 0 %path_zCORE5%) ELSE ^
srec_cat -generate 0x57FFF 0x58000 -constant 0 -o core5.mcs -Intel -line-length=44 -line-termination=nl
if defined path_zCORE6 (call promgen  -w -spi -p mcs -o core6.mcs -s 4096 -u 0 %path_zCORE6%) ELSE ^
srec_cat -generate 0x57FFF 0x58000 -constant 0 -o core6.mcs -Intel -line-length=44 -line-termination=nl
if defined path_zCORE7 (call promgen  -w -spi -p mcs -o core7.mcs -s 4096 -u 0 %path_zCORE7%) ELSE ^
srec_cat -generate 0x57FFF 0x58000 -constant 0 -o core7.mcs -Intel -line-length=44 -line-termination=nl
if defined path_zCORE8 (call promgen  -w -spi -p mcs -o core8.mcs -s 4096 -u 0 %path_zCORE8%) ELSE ^
srec_cat -generate 0x57FFF 0x58000 -constant 0 -o core8.mcs -Intel -line-length=44 -line-termination=nl
if defined path_zCORE9 (call promgen  -w -spi -p mcs -o core9.mcs -s 4096 -u 0 %path_zCORE9%) ELSE ^
srec_cat -generate 0x57FFF 0x58000 -constant 0 -o core9.mcs -Intel -line-length=44 -line-termination=nl

srec_cat  boot_header.bin -binary  ^
          roms_04000.bin  -binary -offset 0x004000   ^
	  tld_zxuno.mcs   -Intel  -offset 0x058000   ^
          core2.mcs     -Intel  -offset 0x0AC000   ^
          core3.mcs     -Intel  -offset 0x100000   ^
          core4.mcs     -Intel  -offset 0x154000   ^
          core5.mcs     -Intel  -offset 0x1A8000   ^
          core6.mcs     -Intel  -offset 0x1FC000   ^
          core7.mcs     -Intel  -offset 0x250000   ^
          core8.mcs     -Intel  -offset 0x2A4000   ^
	  core9.mcs	-Intel	-offset 0x2F8000   ^
 	  -generate 0x3FFFFF 0x400000 -constant 0 	    ^
          -o zxuno_multiboot_Q32.bin     -binary

srec_cat  zxuno_multiboot_Q32.bin     -binary       ^
          -o prom_multiboot_Q32.mcs     -Intel	    ^
          -line-length=44                           ^
          -line-termination=nl
..\fcut zxuno_multiboot_Q32.bin 58000 54000 ZXCore.bin

if defined zCORE2 (
..\fcut zxuno_multiboot_Q32.bin AC000 54000 core2.bin
GenRom 0 0 0 0 0 "%zCORE2%" core2.bin  core2.tap
CgLeches core2.tap core2.wav 7
)

if defined zCORE3 (
..\fcut zxuno_multiboot_Q32.bin 100000 54000 core3.bin
GenRom 0 0 0 0 0 "%zCORE3%" core3.bin  core3.tap
CgLeches core3.tap core3.wav 7
)

if defined zCORE4 (
..\fcut zxuno_multiboot_Q32.bin 154000 54000 core4.bin
GenRom 0 0 0 0 0 "%zCORE4%" core4.bin  core4.tap
CgLeches core4.tap core4.wav 7
)

if defined zCORE5 (
..\fcut zxuno_multiboot_Q32.bin 1A8000 54000 core5.bin
GenRom 0 0 0 0 0 "%zCORE5%" core5.bin  core5.tap
CgLeches core5.tap core5.wav 7
)

if defined zCORE6 (
..\fcut zxuno_multiboot_Q32.bin 1FC000 54000 core6.bin
GenRom 0 0 0 0 0 "%zCORE6%" core6.bin  core6.tap
CgLeches core6.tap core6.wav 7
)

if defined zCORE7 (
..\fcut zxuno_multiboot_Q32.bin 250000 54000 core7.bin
GenRom 0 0 0 0 0 "%zCORE7%" core7.bin  core7.tap
CgLeches core7.tap core7.wav 7
)

if defined zCORE8 (
..\fcut zxuno_multiboot_Q32.bin 2A4000 54000 core8.bin
GenRom 0 0 0 0 0 "%zCORE8%" core8.bin  core8.tap
CgLeches core8.tap core8.wav 7
)

if defined zCORE9 (
..\fcut zxuno_multiboot_Q32.bin 2F8000 54000 core9.bin
GenRom 0 0 0 0 0 "%zCORE9%" core9.bin  core9.tap
CgLeches core9.tap core9.wav 7
)

GenRom 0 202 0 0 0 BIOS ..\firmware.rom firmware.tap
GenRom 0 0 0 0 0 ESXDOS ESXMMC086b4.BIN  esxdos.tap
GenRom 0 203 0 0 0 Machine ZXCore.bin  ZXCore.tap
CgLeches firmware.tap firmware.wav 7
CgLeches ZXCore.tap  ZXCore.wav 7

