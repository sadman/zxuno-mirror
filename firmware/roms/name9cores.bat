@echo off
SETLOCAL ENABLEEXTENSIONS
SETLOCAL DISABLEDELAYEDEXPANSION

SET "zBLOCKS=        block   32-($ ^& 31), $20"

copy 06000.asm 06000_tmp.asm /Y

echo         block   $1100-$ >> 06000_tmp.asm 
if defined zCORE2 (echo         defm    '%zCORE2%' >> 06000_tmp.asm) ELSE echo         defm    '2: [Load core]' >> 06000_tmp.asm
echo %zBLOCKS% >> 06000_tmp.asm
if defined zCORE3 (echo         defm    '%zCORE3%' >> 06000_tmp.asm) ELSE echo         defm    '3: [Load core]' >> 06000_tmp.asm
echo %zBLOCKS% >> 06000_tmp.asm
if defined zCORE4 (echo         defm    '%zCORE4%' >> 06000_tmp.asm) ELSE echo         defm    '4: [Load core]' >> 06000_tmp.asm
echo %zBLOCKS% >> 06000_tmp.asm
if defined zCORE5 (echo         defm    '%zCORE5%' >> 06000_tmp.asm) ELSE echo         defm    '5: [Load core]' >> 06000_tmp.asm
echo %zBLOCKS% >> 06000_tmp.asm
if defined zCORE6 (echo         defm    '%zCORE6%' >> 06000_tmp.asm) ELSE echo         defm    '6: [Load core]' >> 06000_tmp.asm
echo %zBLOCKS% >> 06000_tmp.asm
if defined zCORE7 (echo         defm    '%zCORE7%' >> 06000_tmp.asm) ELSE echo         defm    '7: [Load core]' >> 06000_tmp.asm
echo %zBLOCKS% >> 06000_tmp.asm
if defined zCORE8 (echo         defm    '%zCORE8%' >> 06000_tmp.asm) ELSE echo         defm    '8: [Load core]' >> 06000_tmp.asm
echo %zBLOCKS% >> 06000_tmp.asm
if defined zCORE9 (echo         defm    '%zCORE9%' >> 06000_tmp.asm) ELSE echo         defm    '9: [Load core]' >> 06000_tmp.asm
echo %zBLOCKS% >> 06000_tmp.asm
echo         block   $2000-$ >> 06000_tmp.asm

exit /b