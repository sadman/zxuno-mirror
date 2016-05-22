cd ..
call  make_v1.bat
cd roms
..\sjasmplus 2b500.asm
copy /b ESXMMC.BIN+                   ^
        2b500.bin+                    ^
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
    roms_29500.bin
call promgen -w -spi -p mcs -o tld_zxuno.mcs -s 4096 -u 0 ..\..\cores\spectrum_v1_spartan3\test15\tld_zxuno.bit
srec_cat  tld_zxuno.mcs   -Intel                    ^
          roms_29500.bin  -binary -offset 0x29500   ^
          -o prom.mcs     -Intel                    ^
          -line-length=44                           ^
          -line-termination=nl
srec_cat  tld_zxuno.mcs     -Intel  ^
          -o tld_zxuno.bin  -binary
copy /b tld_zxuno.bin+    ^
        ESXMMC.BIN+       ^
        2b500.bin+        ^
        ..\firmware.rom   ^
    machine.bin
GenRom 0 202 0 0 0 'BIOS' ..\firmware.rom firmware.tap
GenRom 0 0 0 0 0 'Machine' machine.bin  machine.tap
CgLeches firmware.tap firmware.wav
CgLeches machine.tap  machine.wav
