SETLOCAL EnableDelayedExpansion
tzx2wav "tzx\%~1.tzx" temp.wav
ticks 48rp.rom -r -i 69888 -t temp.wav -e %6 -o file.mem -c 0
fcut file.mem 4000 1b00 file.scr
rcs file.scr file.rcs
if not "%7"=="%6" ticks file.mem -r -i 69888 -t temp.wav -e %7 -o file.mem -c 0
if exist "bat\%~1.bat" call "bat\%~1.bat"
ticks file.mem -o "sna\%~1.sna" -c 1
fcut file.mem   %3   %4 file.bin
call compress b3- 5b00 file.rcs file.bin
echo  define  startpc $%5         >  define.asm
echo  define  address $%3         >> define.asm
echo  define  binsize $%4         >> define.asm
call :getfilesize file.bin.exo.opt
echo  define  exosize %_filesize% >> define.asm
sjasmplus compress_tap.asm
gentape "tap\%~1.tap" basic %2 0 compress_tap.bin ^
                      data      file.bin.exo.opt
del temp.wav file.mem file.scr file.rcs file.rcs.exo file.rcs.exo.opt file.bin ^
    file.bin.exo file.bin.exo.opt define.asm compress_tap.bin
ENDLOCAL
goto :eof

:getfilesize
set _filesize=%~z1
goto :eof
