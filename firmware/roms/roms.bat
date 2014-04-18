GenRom 8  1 0 32 "'ZX Spectrum 48K Cargando Leches'" leches.rom         leches.tap
GenRom 8  4 0 0  "'ZX +3e DivMMC'"                   mmces3eE.rom       mmces3eE.tap
GenRom 10 2 4 0  "'SE Basic IV 4.0 Anya'"            se.rom             se.tap
GenRom 8  1 0 32 "'ZX Spectrum 48K'"                 48.rom             48.tap
GenRom 8  1 0 32 "'Jet Pac (1983)'"                  JetPac.rom         JetPac.tap
GenRom 8  1 0 32 "'Pssst (1983)'"                    Pssst.rom          Pssst.tap
GenRom 8  1 0 32 "'Cookie (1983)'"                   Cookie.rom         Cookie.tap
GenRom 8  1 0 32 "'Tranz Am (1983)'"                 TranzAm.rom        TranzAm.tap
GenRom 8  1 0 32 "'Master Chess (1983)'"             MasterChess.rom    MasterChess.tap
GenRom 8  1 0 32 "'Backgammon (1983)'"               Backgammon.rom     Backgammon.tap
GenRom 8  1 0 32 "'Hungry Horace (1983)'"            HungryHorace.rom   HungryHorace.tap
GenRom 8  1 0 32 "'Horace & the Spiders (1983)'"     HoraceSpiders.rom  HoraceSpiders.tap
GenRom 8  1 0 32 "'Planetoids (1983)'"               Planetoids.rom     Planetoids.tap
GenRom 8  1 0 32 "'Space Raiders (1983)'"            SpaceRaiders.rom   SpaceRaiders.tap
GenRom 8  1 0 32 "'Deathchase (1983)'"               Deathchase.rom     Deathchase.tap
GenRom 8  1 0 32 "'Manic Miner (1983)'"              ManicMiner.rom     ManicMiner.tap

sjasmplus 2b500.asm
copy /b ESXMMC.BIN+                   ^
        2b500.bin+                    ^
        \zxuno\firmware\firmware.rom+ ^
        leches.rom+                   ^
        mmces3eE.rom+                 ^
        se.rom+                       ^
        48.rom+                       ^
        JetPac.rom+                   ^
        Pssst.rom+                    ^
        Cookie.rom+                   ^
        TranzAm.rom+                  ^
        MasterChess.rom+              ^
        Backgammon.rom+               ^
        HungryHorace.rom+             ^
        HoraceSpiders.rom+            ^
        Planetoids.rom+               ^
        SpaceRaiders.rom+             ^
        ManicMiner.rom+               ^
        Deathchase.rom                ^
    roms_29500.bin