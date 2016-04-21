rem zx7b      logo256x192.rcs       logo256x192.rcs.zx7b
rem zx7b      ES  es.zx7b
rem zx7b      US  us.zx7b
rem zx7b      AV  av.zx7b
sjasmplus firmware.asm
fcut      firmware_strings.rom  7e00 -7e00  strings.bin
zx7b      strings.bin           strings.bin.zx7b
sjasmplus firmware.asm
fcut      firmware_strings.rom  0000  4000  firmware.rom
