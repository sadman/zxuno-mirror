SETLOCAL EnableDelayedExpansion
set _method=%7
if b==%_method:~0,1% (set _back=1) else (set _back=0)
tzx2wav "tzx\%~1.tzx" temp.wav
ticks 48rp.rom -t temp.wav -e %6 -o file.mem -c 0
fcut file.mem 4000 1b00 file.scr
rcs file.scr file.rcs
if not "%5"=="%6" ticks file.mem -t temp.wav -e %5 -o file.mem -c 0
if exist bat\%2.bat call bat\%2.bat
fcut file.mem   %3   %4 file.bin
set /a _fsh= 0x%3+0x%4
if %_fsh% GTR 0xfd80 (
  if 0==%_back% (
    echo Forward not possible
    goto :eof
  )
  set /a _fsh= 0x%3-158
) else set /a _fsh= 0x%3+0x%4+3*(1-%_back%)
call :dec2hex %_fsh%
call compress %7 %_res% file.rcs file.bin
echo  define  back    %_back%  >  define.asm
echo  define  mapbase $%_res%  >> define.asm
echo  define  startpc $%5      >> define.asm
echo  define  address $%3      >> define.asm
echo  define  binsize $%4      >> define.asm
call :getfilesize file.bin.exo.opt
echo  define  exosize %_filesize% >> define.asm
sjasmplus compress_tap.asm
gentape tap\%2.tap basic %2 0 compress_tap.bin ^
                    data      file.bin.exo.opt
del temp.wav file.mem file.scr file.rcs file.rcs.exo file.rcs.exo.opt file.bin ^
    file.bin.exo file.bin.exo.opt define.asm compress_tap.bin
ENDLOCAL
goto :eof

:getfilesize
set _filesize=%~z1
goto :eof

:dec2hex
set /a "_fsh1=%1>>12&15"
set /a "_fsh2=%1>>8&15"
set /a "_fsh3=%1>>4&15"
set /a "_fsh4=%1&15"
set _map=0123456789ABCDEF
set _res=!_map:~%_fsh1%,1!!_map:~%_fsh2%,1!!_map:~%_fsh3%,1!!_map:~%_fsh4%,1!
goto :eof