cd ..
call  make.bat
cd roms
..\sjasmplus aa000.asm
copy /b ESXMMC.BIN+                   ^
        aa000.bin+                    ^
        ..\firmware.rom+              ^
        leches.rom+                   ^
        mmces3eE.rom+                 ^
        se.rom+                       ^
        48.rom+                       ^
        ManicMiner.rom+               ^
        JetSetWilly.rom+              ^
        LalaPrologue.rom+             ^
        Deathchase.rom+               ^
        MasterChess.rom+              ^
        Backgammon.rom+               ^
        HungryHorace.rom+             ^
        HoraceSpiders.rom+            ^
        Planetoids.rom+               ^
        SpaceRaiders.rom+             ^
        MiscoJones.rom                ^
    roms_a8000.bin
call promgen  -w -spi -p mcs -o tld_zxuno.mcs       ^
              -s 4096 -u 0 ..\..\cores\spectrum_v2_spartan6\test14\tld_zxuno.bit
srec_cat  tld_zxuno.mcs   -Intel                    ^
          roms_a8000.bin  -binary -offset 0xa8000   ^
          -o prom.mcs     -Intel                    ^
          -line-length=44                           ^
          -line-termination=nl
srec_cat  prom.mcs     -Intel       ^
          -o tld_zxuno.bin  -binary
..\fcut tld_zxuno.bin 54000 5c000 machine.bin
GenRom 202 0 0 0 'BIOS' ..\firmware.rom firmware.tap
GenRom 0 0 0 0 'Machine' machine.bin  machine.tap
CgLeches firmware.tap firmware.wav
CgLeches machine.tap  machine.wav
