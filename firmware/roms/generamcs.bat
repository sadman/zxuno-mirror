cd ..
echo  define version 4 > version.asm
call  make.bat
cd roms
Bit2Bin ..\..\cores\spectrum_v2_spartan6\test20\tld_zxunov4_BL.bit tmp.bin
fpad 2000 00 tmp0.bin
fpad 4c000 00 tmp1.bin
fpad 354000 00 tmp2.bin
copy /b /y header.bin+esxdos.rom+tmp0.bin+..\firmware.rom+tmp1.bin+tmp.bin+tmp2.bin FLASH.ZX1
fpoke FLASH.ZX1 007000 000040xFF 007044 g0203020202
..\fcut tmp.bin 0 53f00 sd_binaries\SPECTRUM.ZX1
GenRom 0 203 0 0 0 Machine tmp.bin core_taps\SPECTRUM.TAP
rem CgLeches core_taps\SPECTRUM.TAP core_wavs\SPECTRUM.WAV 4
call :CreateMachine CORE2 "Sam Coupe"        sam_coupe_spartan6\test4\tld_sam_v4.bit
call :CreateMachine CORE3 "Jupiter ACE"      jupiter_ace_spartan6\test2\tld_jace_spartan6_v4.bit
call :CreateMachine CORE4 "Master System"    sms_v2_spartan6\test4\sms_final_v4.bit
call :CreateMachine CORE5 "Oric Atmos"       oric_spartan6\test1\build\oric_v4.bit
call :CreateMachine CORE6 "BBC Micro"        BBCMicro\test3\working\bbc_micro_v4.bit
call :CreateMachine CORE7 "Apple ][ (VGA)"   Apple2_spartan6\test2\build\apple2_top_v4.bit
call :CreateMachine CORE8 "Acorn Atom (VGA)" acorn_atom_spartan6\test2\working\atomic_top_zxuno_v4.bit
call :CreateMachine CORE9 "NES (VGA)"        nes_v2_spartan6\test1_v4\xilinx\nes_zxuno_v4.bit
copy /y esxdos.rom sd_binaries\ESXDOS.ZX1
copy /y ..\firmware.rom sd_binaries\FIRMWARE.ZX1
GenRom 0 202 0 0 0 BIOS ..\firmware.rom core_taps\FIRMWARE.TAP
GenRom 0 0 0 0 0 ESXDOS esxdos.rom core_taps\ESXDOS.TAP
call :CreateRom 0  "ZX Spectrum 48K Cargando Leches" leches         dn   8  4 0 0
call :CreateRom 1  "ZX +3e DivMMC"                 plus3en40divmmc  t    8  4 0 0
call :CreateRom 5  "SE Basic IV 4.0 Anya"          se               d    8  4 0 0
call :CreateRom 7  "ZX Spectrum 48K"               48               dn   8  4 0 32
call :CreateRom 8  "Jet Pac (1983)"                JetPac           0    8  1 0 32
call :CreateRom 9  "Pssst (1983)"                  Pssst            0    8  1 0 32
call :CreateRom 10 "Cookie (1983)"                 Cookie           0    8  1 0 32
call :CreateRom 11 "Tranz Am (1983)"               TranzAm          0    8  1 0 32
call :CreateRom 12 "Master Chess (1983)"           MasterChess      0    8  1 0 32
call :CreateRom 13 "Backgammon (1983)"             Backgammon       0    8  1 0 32
call :CreateRom 14 "Hungry Horace (1983)"          HungryHorace     0    8  1 0 32
call :CreateRom 15 "Horace & the Spiders (1983)"   HoraceSpiders    0    8  1 0 32
call :CreateRom 16 "Planetoids (1983)"             Planetoids       0    8  1 0 32
call :CreateRom 17 "Space Raiders (1983)"          SpaceRaiders     0    8  1 0 32
call :CreateRom 18 "Deathchase (1983)"             Deathchase       0    8  1 0 32
call :CreateRom 19 "Manic Miner (1983)"            ManicMiner       0    8  1 0 32
call :CreateRom 20 "Misco Jones (2013)"            MiscoJones       0    8  1 0 32
call :CreateRom 21 "Jet Set Willy (1984)"          JetSetWilly      0    8  1 0 32
call :CreateRom 22 "Lala Prologue (2010)"          LalaPrologue     0    8  1 0 32
srec_cat  FLASH.ZX1 -binary   ^
          -o prom.mcs -Intel  ^
          -line-length=44     ^
          -line-termination=nl
del tmp.bin tmp0.bin tmp1.bin tmp2.bin
move /y FLASH.ZX1 sd_binaries
goto :eof

:CreateMachine
Bit2Bin ..\..\cores\%3 sd_binaries\%1.ZX1
GenRom 0 0 0 0 0 %2 sd_binaries\%1.ZX1 core_taps\%1.TAP
AddItem %1 core_taps\%1.tap
rem CgLeches core_taps\%1.TAP core_wavs\%1.WAV 4
goto :eof

:CreateRom
GenRom %4 %5 %6 %7 %8 %2 %3.rom rom_taps\%3.tap
AddItem ROM %1 rom_taps\%3.tap
rem CgLeches rom_taps\%3.tap rom_wavs\%3.wav 4
:eof
