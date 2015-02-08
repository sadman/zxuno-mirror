cd ..
call  make.bat
cd roms
..\sjasmplus aa000.asm
copy /b ESXMMC.BIN+                   ^
        aa000.bin+                    ^
        ..\firmware.rom+              ^
        leches.rom+                   ^
        plus3es40zxmmc.rom+           ^
        se.rom+                       ^
        48.rom+                       ^
        ManicMiner.rom+               ^
        JetSetWilly.rom+              ^
        LalaPrologue.rom+             ^
        Deathchase.rom+               ^
        Chess.rom+                    ^
        Backgammon.rom+               ^
        HungryHorace.rom+             ^
        HoraceSpiders.rom+            ^
        Planetoids.rom+               ^
        SpaceRaiders.rom+             ^
        MiscoJones.rom                ^
    roms_a8000.bin
call promgen  -w -spi -p mcs -o tld_zxuno_es.mcs       ^
              -s 4096 -u 0 ..\..\cores\spectrum_v2_spartan6\test14\tld_zxuno_es.bit
call promgen  -w -spi -p mcs -o tld_zxuno_av.mcs          ^
              -s 4096 -u 0 ..\..\cores\spectrum_v2_spartan6\test15\tld_zxuno.bit
srec_cat  tld_zxuno_es.mcs   -Intel                 ^
          roms_a8000.bin  -binary -offset 0xa8000   ^
          -o prom_es.mcs     -Intel                 ^
          -line-length=44                           ^
          -line-termination=nl
srec_cat  tld_zxuno_av.mcs   -Intel                 ^
          roms_a8000.bin  -binary -offset 0xa8000   ^
          -o prom_av.mcs     -Intel                 ^
          -line-length=44                           ^
          -line-termination=nl
srec_cat  prom_av.mcs     -Intel     ^
          -o tld_zxuno.bin  -binary
rem ..\fcut tld_zxuno.bin 54000 5c000 machine.bin
..\fcut tld_zxuno.bin 00000 54000 machine1.bin
..\fcut tld_zxuno.bin a8000 08000 machine2.bin
copy /b machine1.bin+machine2.bin machine.bin
GenRom 0 202 0 0 0 'BIOS' ..\firmware.rom firmware.tap
GenRom 0 0 0 0 0 'ESXDOS' ESXMMC.BIN  esxdos.tap
GenRom 0 0 0 0 0 'Machine' machine.bin  machine.tap
CgLeches firmware.tap firmware.wav
CgLeches machine.tap  machine.wav
