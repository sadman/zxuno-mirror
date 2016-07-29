	device zxspectrum48
        ORG #9000
begin
 di
  ld sp,$8EFF
;---------clear memory
 dec b
clm:
 ld a,15
 ld (bc),a
 dec bc
 ld a,b
 cp $3f
 jr nz,clm

;----------------calcsin-------
_data_wave equ $8F00

				;*** Precalc 256 bytes exp-based sin-like wave ***
				ld hl,_data_wave
				ld de,_data_wave + 127
				ld b,64
_sinGen
				ld a,b
				exx
				ld hl,0
				ld d,h
				ld e,a
_exp				add hl,de
				dec a
				jr nz,_exp
				add hl,hl
				ld a,h
				exx

				ld (hl),a
				ld (de),a
				neg
				add 64
				set 7,l
				set 7,e
				ld (hl),a
				ld (de),a
				res 7,l
				res 7,e
				dec e
				inc l
				
				djnz _sinGen
;------------------------------
;mode hires
 ld a,2
 out (255),a

wai:
 ei:halt:di
 push de
; ld de,0
 exx
 ld hl, $601F
 exx
 
 ld (end_sp+1),sp
 ld a,192
line_lp:
 exa
 ld h,_data_wave/256
 ld l,e
 ld a,(hl)
 ld l,d
 add a,(hl)
 inc e
 dec d
 dec d
 ld c,a
 and 16
 out ($FE),a
 ld a,c
 ld hl,colors
 and 7
; out ($FE),a
 add a,l
 ld l,a
 ld sp,hl

 pop bc,hl,ix

 exx
 inc hl
 ld sp,hl
 dec hl
 INC h:LD A,h
 AND 7:jr nz,$+12
 LD A,L:ADD A,#20:LD L,A:jr c,$+6
 LD A,H:SUB 8:LD H,A
 exx

 push ix,hl,bc
 push ix,hl,bc
 push ix,hl,bc
 push ix,hl,bc
 push ix,hl,bc
 push bc

 exa
 dec a
 jp nz, line_lp
end_sp:ld sp,0
 pop de
 inc e
 inc e
 inc e
 dec d
 dec d
 jp wai
colors:

 db $40+0,$40+1*9,$40+5*9,$40+4*9,$40+7*9,$40+6*9,$40+2*9,$40+0
 db $40+1*9,$40+5*9,$40+4*9,$40+7*9,$40+6*9,$40+2*9,$40+0
end
	display /d,end-begin
	savebin "tt.cod",begin,end-begin

