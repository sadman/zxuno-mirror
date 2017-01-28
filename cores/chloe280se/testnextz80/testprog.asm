                org 0
                di
                xor a
                out (254),a
                ld l,a
                inc a
                ld e,a
                ld h,58h
                ld d,h
                ld bc,767
                ld (hl),l
                ldir
                halt
