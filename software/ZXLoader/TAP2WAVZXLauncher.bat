rem Convierte el fichero tap a wav de CargandoLeches
cd bin
CgLeches.exe %1 salidaZXLoader.wav

rem Espera 5 segundos.
rem Esto solo funciona en Windows 2000 en adelante
timeout /t 5

rem Reproduce el archivo. Sustituye aqui por tu reproductor favorito.
"C:\Program Files (x86)\VideoLAN\VLC\vlc.exe" salidaZXLoader.wav

