; Music loader, (C) 2007 Patrik Rak - Raxoft

	org	40000

main	di
loop	ld	ix,16384
	ld	de,6912
	ld	a,255
	call	ldtune
	jr	nc,loop
	ei
	ret

ldedge1	equ	0x5e7
ldedge2	equ	0x5e3

ldtune	ld	h,a
	ld	a,15
	out	(254),a
	in	a,(254)
	rra
	and	32
	or	2
	ld	c,a
	cp	a

ldbreak	ret	nz
ldstart	call	ldedge1
	jr	nc,ldbreak
	ld	b,0
	ld	l,b
	call	ldedge2
	jr	nc,ldbreak

ldlead	ld	b,156
	call	ldedge2
	jr	nc,ldbreak
	ld	a,198
	cp	b
	jr	nc,ldstart
	inc	l
	jr	nz,ldlead

ldsync	ld	b,201
	call	ldedge1
	jr	nc,ldbreak
	ld	a,b
	cp	212
	jr	nc,ldsync
	call	ldedge1
	ret	nc

	ld	a,c
	xor	3
	ld	c,a

	call	ldbyte
	ret	nc
	ld	a,h
	xor	l
	ret	nz

ldloop	call	ldbyte
	ret	nc
	ld	a,h
	xor	l
	ld	h,a
	ld	(ix+0),l
	inc	ix
	dec	de
	ld	a,d
	or	e
	jr	nz,ldloop

	call	ldbyte
	ret	nc
	ld	a,h
	xor	l
	cp	1
	ret

ldbyte	ld	l,1
ldbits	push	hl
	call	ldbit
	pop	hl
	ret	nc
	add	a,a
	rl	l
	jr	nc,ldbits
	ret

;ldbit	ld	b,176
;	call	ldedge2
;	ret	nc
;	ld	a,203
;	cp	b
;	rra
;	scf
;	ret

ldbit	call	ldbit1
	ret	nc
	ex	af,af'
	call	ldbit1
	ret	nc
	ld	b,a
	ex	af,af'
	xor	b
	scf
	ret

ldbit1	call	ldwave
	ret	nc
	ld	h,a
	call	ldwave
	ret	nc
	sub	h
	scf
	ret

ldwave	ld	b,0
	call	ldedge1
	ret	nc
	ld	l,b
	ld	b,0
	call	ldedge1
	ret	nc
	ld	a,b
	sub	l
	scf
	ret

