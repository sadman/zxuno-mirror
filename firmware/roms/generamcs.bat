cd ..
echo  define version 4 > version.asm
call  make.bat
cd roms
Bit2Bin ..\..\cores\spectrum_v2_spartan6\test21\v4\tld_zxuno_v4.bit tmp.bin
fpad 400000 00 FLASH.ZX1
fpoke FLASH.ZX1 00000 file:header.bin      ^
                04000 file:esxdos.rom      ^
                07000 40xFF                ^
                07044 g0203020202          ^
                08000 file:..\firmware.rom ^
                58000 file:tmp.bin
..\fcut tmp.bin 0 53f00 sd_binaries\SPECTRUM.ZX1
GenRom 0 sm1ta Machine tmp.bin core_taps\SPECTRUM.TAP
rem CgLeches core_taps\SPECTRUM.TAP core_wavs\SPECTRUM.WAV 4
call :CreateMachine CORE2 "Sam Coupe"        sam_coupe_spartan6\test4\tld_sam_v4.bit
call :CreateMachine CORE3 "Jupiter ACE"      jupiter_ace_spartan6\test2\tld_jace_spartan6_v4.bit
call :CreateMachine CORE4 "Master System"    sms_v2_spartan6\test4\sms_final_v4.bit
call :CreateMachine CORE5 "Oric Atmos"       oric_spartan6\test1\build\oric_v4.bit
call :CreateMachine CORE6 "BBC Micro"        BBCMicro\test3\working\bbc_micro_v4.bit
call :CreateMachine CORE7 "Apple 2 (VGA)"    Apple2_spartan6\test2\build\apple2_top_v4.bit
call :CreateMachine CORE8 "Acorn Atom (VGA)" acorn_atom_spartan6\test2\working\atomic_top_zxuno_v4.bit
call :CreateMachine CORE9 "NES (VGA)"        nes_v2_spartan6\test1_v4\xilinx\nes_zxuno_v4.bit
copy /y esxdos.rom sd_binaries\ESXDOS.ZX1
copy /y ..\firmware.rom sd_binaries\FIRMWARE.ZX1
GenRom 0 sm1t BIOS ..\firmware.rom core_taps\FIRMWARE.TAP
GenRom 0 0    ESXDOS esxdos.rom core_taps\ESXDOS.TAP
call :CreateRom 0  "ZX Spectrum 48K Cargando Leches" leches         dn   lh
call :CreateRom 1  "ZX +2A 4.1"                    plus3en41        t    0
call :CreateRom 5  "SE Basic IV 4.0 Anya"          se               d    h
call :CreateRom 7  "ZX Spectrum 48K"               48               dn   lh17
AddItem ROM     8   rom_taps\rooted.tap
call :CreateRom 9  "Jet Pac (1983)"                JetPac           0    lh17
call :CreateRom 10 "Pssst (1983)"                  Pssst            0    lh17
call :CreateRom 11 "Cookie (1983)"                 Cookie           0    lh17
call :CreateRom 12 "Tranz Am (1983)"               TranzAm          0    lh17
call :CreateRom 13 "Master Chess (1983)"           MasterChess      0    lh17
call :CreateRom 14 "Backgammon (1983)"             Backgammon       0    lh17
call :CreateRom 15 "Hungry Horace (1983)"          HungryHorace     0    lh17
call :CreateRom 16 "Horace & the Spiders (1983)"   HoraceSpiders    0    lh17
call :CreateRom 17 "Planetoids (1983)"             Planetoids       0    lh17
call :CreateRom 18 "Space Raiders (1983)"          SpaceRaiders     0    lh17
call :CreateRom 19 "Deathchase (1983)"             Deathchase       0    lh17
call :CreateRom 20 "Manic Miner (1983)"            ManicMiner       0    lh17
call :CreateRom 21 "Misco Jones (2013)"            MiscoJones       0    lh17
call :CreateRom 22 "Jet Set Willy (1984)"          JetSetWilly      0    lh17
call :CreateRom 23 "Lala Prologue (2010)"          LalaPrologue     0    lh17
srec_cat  FLASH.ZX1 -binary   ^
          -o prom.mcs -Intel  ^
          -line-length=44     ^
          -line-termination=nl
del tmp.bin
move /y FLASH.ZX1 sd_binaries
goto :eof

:CreateMachine
Bit2Bin ..\..\cores\%3 sd_binaries\%1.ZX1
GenRom 0 0 %2 sd_binaries\%1.ZX1 core_taps\%1.TAP
AddItem %1 core_taps\%1.tap
rem CgLeches core_taps\%1.TAP core_wavs\%1.WAV 4
goto :eof

:CreateRom
GenRom %4 %5 %2 %3.rom rom_taps\%3.tap
AddItem ROM %1 rom_taps\%3.tap
rem CgLeches rom_taps\%3.tap rom_wavs\%3.wav 4
:eof
