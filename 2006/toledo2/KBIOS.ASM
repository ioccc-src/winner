title KAYPRO CBIOS for CP/M 2.2
;###############################################################
;##      KAYPRO         CBIOS for CP/M 2.2                    ##
;##      Copyright (C) 1982 By Non-Linear Systems, Inc.       ##
;##      No warranty is made, expressed or implied.           ##
;###############################################################
;##	Last Update: july 7,1982	[001]		      ##
;##		by  jim nickerson
;##		changes:				      ##
;##		 -allow redefinition of kpd in cbios          ##
;##		 -change to allow test of serial on liststatus##
;##		 -default ul1: to tty on list		      ##
;###############################################################

	.Z80			; Z80 CPU
msize	equ	64		; system memory size in k
vers	equ	22		; CP/M version number
bias	equ	(msize-20)*1024	; bias for systems larger than 20k
ccp	equ	3400H+bias	; start of CCP
bdos	equ	ccp+806H	; start of BDOS (The resident portion of CP/M)
bios	equ	ccp+1600H	; start of Basic I/O Subsystem (BIOS)
cpml	equ	bios-ccp	; length of CP/M system in bytes (less BIOS)
nsects	equ	cpml/128	; length of CP/M system in sectors (less BIOS)
trksec	equ	40		; sectors/track

bitport	equ	1CH		; status/control bit maped port
iobyte	equ	3		; logical to physical map
rom	equ	00000H		; base of rom
ram	equ	0FC00H		; scratch ram
dmaadr	equ	ram+14H		; dma address

	jp	boot		; arrive here from cold start
	jp	wboot		; arrive here for warm start
	jp	const		; console status return in A FF=ready, 00=not
	jp	conin		; console char in
	jp	conout		; console char out
	jp	list		; listing char out
	jp	punch		; punch char out
	jp	reader		; reader char in
	jp	home		; move to track 0 on selected disk drive
	jp	seldsk		; select disk drive
	jp	settrk		; set track #
	jp	setsec		; set sector #
	jp	setdma		; set DMA address
	jp	read		; read selected sector
	jp	write		; write selected sector
	jp	listst		; list status (Ready to print a char)
	jp	sectran		; sector translate
ioconfig: defb	10000001B	; initial value for i/o byte (may be patched)
wrtsafe: defb	0		; write safe flage 0=false
vtab:	defb	11, 10, 8, 12	; vector pad xlate table ^k ^j ^h ^l
	defb	'0', '1', '2', '3'
	defb	'4', '5', '6', '7'
	defb	'8', '9', '-', ','
	defb	0DH, '.'
subttl Cold and Warm boot entry points
page
; Cold boot entry point, set up system pointers and pass control to the CCP
boot:	call	diskint
	xor	a		; clear system disk number
	ld	(4),a
	ld	a,(ioconfig)	; init value for i/o byte
	ld	(iobyte),a
	call	print
	defb	1AH, 0DH, 0AH
	defb	'KAYPRO II '
	defb	0DH, 0AH
	DEFB	  msize/10+'0', msize mod 10+'0'
	defb	'k CP/M v '
	defb	vers/10+'0', '.', vers mod 10+'0'
	defb	0DH, 0AH, 00H

goccp:	ld	a,0C3H		; set up CP/M jumps to bdos and wboot

	ld	hl,bios+3	; wboot entry point
	ld	(0),a
	ld	(1),hl

	ld	hl,bdos		; entry point to bdos
	ld	(5),a
	ld	(6),hl

	ld	a,(4)		; last logical disk unit used
	ld	c,a		; pass to ccp to select
	jp	ccp		; pass control to ccp

; Warm boot entry point, re-load the CCP and BDOS
wboot:	call	diskint
	call	print
	defb	0DH, 0AH, 'Warm Boot', 0DH, 0AH, 00H
wb0:	ld	sp,100H		; re-set stack
	ld	c,0		; select drive A:
	call	seldsk
	ld	bc,0		; set track
	call	settrk
	ld	hl,ccp		; first memory location to load
	ld	(dmaadr),hl
	ld	bc,nsects*256+1
wb1:	push	bc		; save sector count and current sector
	call	setsec		; select sector
	call	read
	pop	bc
	or	a
	jr	nz,wb0		; oops, error on warm boot
	ld	hl,(dmaadr)	; update dma address for next sector
	ld	de,128		; new dma address
	add	hl,de
	ld	(dmaadr),hl
	dec	b
	jp	z,goccp		; done loading
	inc	c		; bump sector count
	ld	a,trksec	; on to next track?
	cp	c
	jp	nz,wb1
	ld	c,16		; first sector on next track
	push	bc		; save counters
	ld	c,1
	call	settrk		; set track
	pop	bc
	jr	wb1
subttl logical to physical devices CON:, PUN:, RDR:, and LST:
page
; logical devices are con: rdr: pun: and lst:
; physical devices are:
;	crt:	video and kbd
;	tty:	serial
;	lpt:	centronics
;	ul1:	serial with cts as busy
;	pun:	same as ul1
;
;con:	tty, crt
;rdr:	tty
;pun:	tty, pun
;lst:	tty, crt, lpt, ul1

const:	ld	a,(iobyte)	; get i/o byte
	and	03H		; strip to con bits
	ld	hl,rom+33H	; serial status
	jp	z,callrom
	ld	hl,rom+2AH	; assume CRT
	jp	callrom

conin:	in	a,(bitport)	; turn disk off
	bit	6,a
	ld	hl,rom+27H	; disk off routine
	call	z,callrom
	ld	a,(iobyte)
	and	03H		; check i/o byte
	ld	hl,rom+36H	; serial input
	jp	z,callrom
	ld	hl,rom+2DH	; assume input from kbd
	call	callrom		; go get char
	or	a
	ret	p		; msb not set
;	and	03H		; form table index to vtab
	AND	01FH		;FORM TABLE INDEX TO VTAB
	ld	hl,vtab
	ld	c,a
	ld	b,0
	add	hl,bc
	ld	a,(hl)		; pick up xlated character
	ret

conout: ld	a,(iobyte)	; check i/o byte
	and	03H
	ld	hl,rom+39H	; serial output
	jp	z,callrom
	ld	hl,rom+45H	; assume video
	jp	callrom

reader:	ld	hl, rom+36H	; serial input
	jp	callrom

;punch:	ld	a,(iobyte)	; check i/o byte
;	and	30H
;	ld	hl,rom+39H	; serial punch
;	jp	z,callrom
;	ld	hl, rom+42H	; serial with cts as busy
;	jp	callrom
punch:
	ld	hl,rom+39h	;serial punch
	jp	callrom
;

list:	ld	a,(iobyte)
	and	0C0H		; check i/o byte
	ld	hl,rom+39H	;  serial
	jp	z,callrom
	ld	hl,rom+3FH	; centronics
	cp	80H
	jp	z,callrom
	ld	hl,rom+45H	; video
	cp	40H
	jp	z,callrom
;	ld	hl, rom+42H	; assume serial with cts as busy
	ld	hl, rom+39h	;ul1: default to serial
	jp	callrom

listst:	ld	a,(iobyte)	; check i/o byte
	and	0C0H
	ld	hl,rom+42H	; serial
	jp	z,callrom
	ld	hl,rom+3CH	; centronics
	cp	80H
	jp	z,callrom
	xor	a		; 0=ready
	ret
subttl Disk I/O and ROM dispatch
page
diskint:ld	hl,rom+03H	; re-set disk software sub-system
	jr	callrom

home:	ld	hl,rom+0CH	; home disk drive rom routine
	jr	callrom

seldsk:	ld	hl,rom+0FH	; select disk drive
	jr	callrom

settrk:	ld	hl,rom+12H	; seek track
	jr	callrom

setsec:	ld	hl,rom+15H	; set sector number
	jr	callrom

setdma:	ld	hl,rom+18H	; set dma address
	jr	callrom

read:	ld	hl,rom+1BH	; read a logical sector
	jr	callrom

write:	ld	hl,rom+1EH	; write a logical sector
	ld	a,(wrtsafe)	; write safe flag
	or	a		; true or false
	jr	z,callrom	; normal operation
	ld	c,1		; directory write code (forces write op)
	jr	callrom

sectran:ld	hl,rom+21H	; xlate logical to physical sector
	jr	callrom

callrom:exx			; save cp/m arguments
	in	a,(bitport)	; turn rom on
	set	7,a
	out	(bitport),a	
	ld	(savsp),sp	; save current stack (may be under rom)
	ld	sp,stack	; set a local stack
	ld	de,biosret	; rom to "RET" here
	push	de
	exx			; restore cp/m arguments and call loc
	jp	(hl)		; to rom routine specified in hl
biosret:ex	af,af'		; save reg A
	ld	sp,(savsp)	; restore stack
	in	a,(bitport)	; off the rom
	res	7,a
	out	(bitport),a
	ex	af,af'		; restore reg A
	ret			; done with rom routine

print:
	ex	(sp),hl	; pop return address, points to text to print
	ld	a,(hl)	; get a byte of text, stop on zero byte
	inc	hl
	ex	(sp),hl	; save new return address
	or	a	; is it a zero byte?
	ret	z
	ld	c,a	; no, so print it
	call	conout
	jr	print

savsp:	defs	2	; current spact pointer during rom call
stack	equ	bios+512 ; a local stack

	end
