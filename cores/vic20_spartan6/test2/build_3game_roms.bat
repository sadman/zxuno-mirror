@echo off
set rom_path=source\roms\

tools\romgen %rom_path%choplifter.bin VIC20_CARTRIDGE 13 l r e> %rom_path%vic20_cartridge.vhd
tools\romgen %rom_path%Frogger.bin VIC20_CARTRIDGE2 13 l r e> %rom_path%vic20_cartridge2.vhd
tools\romgen %rom_path%avenger.bin VIC20_CARTRIDGE3 13 l r e> %rom_path%vic20_cartridge3.vhd

echo done
