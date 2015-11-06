call generate_tap %1 tap\%5.tap  %2 %3 %4 %5
call generate_tap %1 tzx\%5.tzx  %2 %3 %4 %5
call generate_dsk %1 dsk\%5.dsk  %2 %3 %4 %5
rem call generate_ult %1 %5c.dsk %2 %3 %4 %5
call compress_tap %1 ctap\%5.tap %2 %3 %4 %5 %6
call compress_tap %1 ctzx\%5.tzx %2 %3 %4 %5 %6
call compress_dsk %1 cdsk\%5.dsk %2 %3 %4 %5 %7
call compress_ult %1 %5c.dsk %2 %3 %4 %5 %8
