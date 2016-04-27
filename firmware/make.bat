rem zx7b      logo256x192.rcs       logo256x192.rcs.zx7b
rem zx7b      ES  es.zx7b
rem zx7b      US  us.zx7b
rem zx7b      AV  av.zx7b
if not exist strings.bin echo > strings.bin
sjasmplus firmware.asm
fcut      firmware_strings.rom  7e00 -7e00  strings.bin
zx7b      strings.bin           strings.bin.zx7b
sjasmplus firmware.asm
fcut      firmware_strings.rom  0000  4000  firmware.rom

rem roms\GenRom 0 202 0 0 0 BIOS firmware.rom firmware.tap
rem cgleches firmware.tap firmware.wav 3
rem firmware.wav
