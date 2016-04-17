sjasmplus example.asm
gentape example.tap basic "EXAMPLE" 0 example.bin
cd \_Downloads\ZEsarUX_win-4.0\
zesarux --nosplash --noautoload --nowelcomemessage ^
        --zxunospiwriteenable --quickexit --enableulaplus ^
        --mmc-file divmmcesx087.mmc --enable-mmc --enable-divmmc ^
        --tape \zxuno\firmware\example.tap
cd \zxuno\firmware
