SET Z80_OZFILES=C:\MINGW\MSYS\1.0\HOME\SAM\88\Z88DK\lib\
SET ZCCCFG=C:\MINGW\MSYS\1.0\HOME\SAM\88\Z88DK\lib\config\
SET PATH=C:\MINGW\MSYS\1.0\HOME\SAM\88\Z88DK\bin;%PATH%
SET Z88DK_ENV_id272041=true

del *.o
del *.mem
del *.map
del *.def
make
cat font.mem > vram.mem
make
cat boot.mem vram.mem > all.mem
