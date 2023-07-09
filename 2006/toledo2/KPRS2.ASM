title KAYPRO RESIDENT SOFTWARE PACKAGE 2.0 , Copyright (C) 1982 NLS, Inc.
subttl Cold start and configure
	aseg
	ORG	0
.comment %
########################################################
##                                                    ##
##      Cold start routine, reset and configure       ##
##      system for power up condition.                ##
##                                                    ##
##      Copyright (C) 1982 By Non-Linear Systems, Inc ##
##      No warranty is made, expressed or implied.    ##
##                                                    ##
########################################################
##	Last update: july 13/1982    [001]	      ##
##		by JIM NICKERSON                      ##
##		change list out with busy jump to     ##
##		 to check status of serial port       ##
########################################################
%
	.xlist
;	extrn	stack, diskinit, vidinit, devinit, print, dmaadr, dpha
;	extrn	home, seldsk, settrk, setsec, setdma, read, write
;	extrn	sectran, kbdstat, kbdin, kbdout, ttystat, ttyin, ttyout, TTYOSTAT
;	extrn	liststat, list, vidout, diskoff, diskon, thnsd
	.list
	.z80

; ROM master jump table

jp	start		; start up computer
jp	diskinit	; disk initialize
jp	vidinit		; video initialize
jp	devinit		; device initialize

jp	home		; home selected disk drive
jp	seldsk		; select a disk drive
jp	settrk		; seek a track
jp	setsec		; set sector number to read
jp	setdma		; set dma address
jp	read		; read logical sector
jp	write		; write logical sector
jp	sectran		; xlate sector number
jp	diskon		; turn on disk
jp	diskoff		; turn off disk

jp	kbdstat		; KeyBoarD character ready
jp	kbdin		; input from keyboard
jp	kbdout		; output to keyboard (used to ring bell)
jp	ttystat		; status of serial input port
jp	ttyin		; serial input
jp	ttyout		; serial output
jp	liststat	; list output status (Centronics)
jp	list		; list output
JP	TTYOSTAT	;TESTSTATUS OF SERIAL OUTPUT
jp	vidout		; video output
jp	thnsd		; short delay

start:	di			; stop interupts while setup
	ld	sp,stack	; rom stack point
	ld	b,10		; a delay to let the hardware stabilize
	call	thnsd
	call	devinit		; init device sub-system
	call	vidinit		; init video sub-system
	call	diskinit	; init disk sub-system
	jr	bootsys		; boot system
	org	66H		; nmi vector
	ret			; return from "halt", NMI sequence when in rom
page
; boot system, the first sector (1) of the first track (0)
; hold system boot information. It does NOT hold a short boot routine!
; the image is:
;	self:	jr	self	; hang if booted and run
;		defw	loadpt	; where to load the opsys image
;		defw	bios	; where to go after booting system
;		defw	length	; length of image in 128 byte sectors
;	(* the rest of the sector is not used *)
;
; This sector image is loaded and inspected at 0FA00H during the boot process

crlf	equ	0D0AH		; new line codes
esc	equ	1BH		; ascii esc
bell	equ	07H		; kbd bell

bootsys:call	print
	defb	esc,'=',20H+10,20H+31
	DEFB	'*    KAYPRO II    *'
	defb	esc,'=',20H+13,20H+20
	defb	'Please insert your diskette into Drive A',8,0
	ld	c,0
	call	seldsk		; select disk, set density, do home after diskinit
	ld	bc,0		; set track
	call	settrk
	ld	c,0		; read the first sector
	call	setsec
	ld	bc,0FA00H	; header sector to go here
	call	setdma
	call	read		; read sector to FA00
	di			; read does EI upon exit
	or	a		; trouble reading?
	jr	nz,booterr	; tell crt
	ld	bc,(0FA02H)	; where to load system image
	ld	(dmaadr),bc
	ld	bc,(0FA04H)	; where to go after loading system
	push	bc		; save for latter use
	ld	bc,(0FA06H)	; length of system in 128 byte sectors
	ld	b,c		; reg B holds # of sectors to load
	ld	c,1		; initial sector (0 was header sector)
cb1:	push	bc		; save sector count and current sector
	call	setsec		; select sector
	call	read
	di			; read does EI upon exit
	pop	bc
	or	a
	jr	nz,booterr	; bad read of sector
	ld	hl,(dmaadr)	; update dma address for next sector
	ld	de,128		; new dma address
	add	hl,de
	ld	(dmaadr),hl
	dec	b
	ret	z		; done booting goto system
	inc	c		; bump sector count
	ld	a,40		; over sectors/track?
	cp	c
	jr	nz,cb1		; fetch another sector
	ld	c,16		; first sector to read on next track
	push	bc		; save counts
	ld	bc,1		; set for next track
	call	settrk
	pop	bc
	jr	cb1

booterr:call	print
	defw	crlf, crlf
	defb	bell,'I cannot read your diskette.',0
	call	diskoff		; turn off disk drive
self:	jr	self		; hang till user pushes reset

page
subttl Disk Equate and Parameters
.comment %
###############################################################
##                                                           ##
##       Disk support routines (Deblocking)                  ##
##                                                           ##
###############################################################
##       Last Update:06/08/82           [001]                ##
###############################################################
%
.z80
	.xlist
;	extrn	sekdsk, sektrk, seksec, hstdsk, hsttrk, hstsec
;	extrn	sekhst, hstact, hstwrt, unacnt, unadsk, unatrk
;	extrn	unasec, erflag, rsflag, readop, wrtype, dmaadr
;	extrn	hstbuf, dsk, denflag, tracka, trackb, dirbuf
;	extrn	csva, alva, csvb, alvb, dpha, dphb, dpbs, dpbd, tbl1
;	extrn	move, rd128, rd512, wrt128, wrt512
;
;	public	home, seldsk, settrk, setsec, setdma, read, write, sectran
;	public	diskinit, diskon, diskoff, thnsd
	.list

bitport	equ	01CH		; bit port (m80 does not support extrn bytes)
drvmask	equ	0FCH		; drive select mask
denmask	equ	0DFH		; density bit mask
ddbit	equ	00H		; double density bit
sdbit	equ	20H		; single density bit
control	equ	10H		; I/O port of disk controller
status	equ	control+0	; status register
cmnd	equ	control+0	; command register
track	equ	control+1	; track register
sector	equ	control+2	; sector register
data	equ	control+3	; data register
ficmd	equ	11010000B	; force interrupt (Abort current command)
rdcmd	equ	10000000B	; read command
wrtcmd	equ	10100000B	; write command
seekcmd	equ	00010000B	; seek command
rstcmd	equ	00000000B	; home (restore) command
adrcmd	equ	11000000B	; read track address
rdmask	equ	10011100B	; read status mask
wrtmask	equ	11111100B	; write status mask
tries1	equ	4		; re-home on bad sector # of tries+1
tries2	equ	15		; re-read/write # of retries+1
retcod	equ	0C9H		; return op code
nmivec	equ	0066H		; non-maskable interupt vector (used in rd/wt loop)
page
; This section defines the disk parameters (dph's are images moved to RAM)
dph0:	defw	0,0,0,0		; dph for unit A:
	defw	dirbuf,dpbd	; directory buffer, Disk Parameter Block
	defw	csva, alva	; check sum pointer, allocation map pointer
	defb	ddbit		; density flag for this drive

	defw	0,0,0,0		; dph for unit B:
	defw	dirbuf,dpbd	; directory buffer, Disk Parameter Block
	defw	csvb, alvb	; check sum pointer, allocation map pointer
	defb	ddbit		; density flag for this drive

;dpbs:	;( single density );
	defw	18		; (spt) sectors per track
	defb	3		; (bsh) block shift factor
	defb	7		; (blm) block mask
	defb	0		; (exm) extent mask
	defw	82		; (dsm) max logical block #
	defw	31		; (drm) max directory #
	defb	80H		; (al0) directory allocation map
	defb	00H		; (al1)
	defw	8		; (cks) size of directory check vector
	defw	3		; (off) reserved tracks
;dpbd:	;( double density );
	defw	40		; (spt) sectors per track
	defb	3		; (bsh) block shift factor
	defb	7		; (blm) block mask
	defb	0		; (exm) extent mask
	defw	194		; (dsm) max logical block #
	defw	63		; (drm) max directory #
	defb	0F0H		; (al0) directory allocation map & BIOS space
	defb	00H		; (al1)
	defw	16		; (cks) size of directory check vector
	defw	1		; (off) reserved tracks

; sector interleave table  ( single density )
;tbl1:
	defb	1,6,11,16
	defb	3,8,13,18
	defb	5,10,15,2
	defb	7,12,17,4
	defb	9,14
enddph:
subttl Logical BIOS entry points & Deblocking
page
.8080
;*****************************************************
;*      Logical BIOS entry points                    *
;*      Sector Deblocking Algorithms                 *
;*****************************************************
blksiz	equ	1024		;CP/M allocation size
hstsiz	equ	512		;host disk sector size
hstspt	equ	10		;host disk sectors/trk
hstblk	equ	hstsiz/128	;CP/M sects/host buff
cpmspt	equ	hstblk * hstspt	;CP/M sectors/track
secmsk	equ	hstblk-1	;sector mask
secshf	equ	2		;log2(hstblk) sector mask
wrall	equ	0		;write to allocated
wrdir	equ	1		;write to directory
wrual	equ	2		;write to unallocated

single	macro	lbl
	lda	denflag
	ora	a
	jnz	lbl
	endm

diskinit:	;enter here on system boot to initialize
.z80
	ld	hl,ioimage	;move rd/wrt routines into RAM
	ld	de,move
	ld	bc,imaglen
	ldir
	ld	hl,dph0		; set dph's
	ld	de,dpha
	ld	bc,enddph-dph0
	ldir
.8080
	xra	a		;0 to accumulator
	sta	hstact		;host buffer inactive
	sta	unacnt		;clear unalloc count
	mvi	a,ddbit		;set double density flag
	sta	denflag
	mvi	a,255		;set track numbers to 255
	sta	dsk		;clear disk number
	sta	tracka
	sta	trackb
	ret

seldsk:				;select disk
	mov	a,c		;selected disk number
	sta	sekdsk		;seek disk number
	jmp	dsksel		;physical disk select (If needed to check den)

setsec:				;set sector given by register c 
	mov	a,c
	sta	seksec		;sector to seek
	single	secset
	ret

.z80
setdma:	ld	(dmaadr),bc	;set dma address given by BC
	ret

settrk:	ld	(sektrk),bc	;set track given by registers BC
.8080
	single	trkset
	ret

home:	single	dohome		; if single goto dohome
	lda	hstwrt		; patch by DRI
	ora	a
	jnz	homed
	sta	hstact
homed:	jmp	dohome		; go do home disk drive

read:				;read the selected CP/M sector
	single	rd128		;128 byte sector?
	xra	a		; a patch by DRI
	sta	unacnt
	mvi	a,1
	sta	readop		;read operation
	sta	rsflag		;must read data
	mvi	a,wrual
	sta	wrtype		;treat as unalloc
	jmp	rwoper		;to perform the read

write:				;write the selected CP/M sector
	single	wrt128		;128 byte sector?
	xra	a		;0 to accumulator
	sta	readop		;not a read operation
	mov	a,c		;write type in c
	sta	wrtype
	cpi	wrual		;write unallocated?
	jnz	chkuna		;check for unalloc

;	write to unallocated, set parameters
	mvi	a,blksiz/128	;next unalloc recs
	sta	unacnt
	lda	sekdsk		;disk to seek
	sta	unadsk		;unadsk = sekdsk
	lhld	sektrk
	shld	unatrk		;unatrk = sectrk
	lda	seksec
	sta	unasec		;unasec = seksec

chkuna:
	;check for write to unallocated sector
	lda	unacnt		;any unalloc remain?
	ora	a
	jz	alloc		;skip if not

;	more unallocated records remain
	dcr	a		;unacnt = unacnt-1
	sta	unacnt
	lda	sekdsk		;same disk?
	lxi	h,unadsk
	cmp	m		;sekdsk = unadsk?
	jnz	alloc		;skip if not

;	disks are the same
	lxi	h,unatrk
	call	sektrkcmp	;sektrk = unatrk?
	jnz	alloc		;skip if not

;	tracks are the same
	lda	seksec		;same sector?
	lxi	h,unasec
	cmp	m		;seksec = unasec?
	jnz	alloc		;skip if not

;	match, move to next sector for future ref
	inr	m		;unasec = unasec+1
	mov	a,m		;end of track?
	cpi	cpmspt		;count CP/M sectors
	jc	noovf		;skip if no overflow

;	overflow to next track
	mvi	m,0		;unasec = 0
	lhld	unatrk
	inx	h
	shld	unatrk		;unatrk = unatrk+1

noovf:
	;match found, mark as unnecessary read
	xra	a		;0 to accumulator
	sta	rsflag		;rsflag = 0
	jmp	rwoper		;to perform the write

alloc:
	;not an unallocated record, requires pre-read
	xra	a		;0 to accum
	sta	unacnt		;unacnt = 0
	inr	a		;1 to accum
	sta	rsflag		;rsflag = 1

;*	Common code for READ and WRITE follows       *;

rwoper:
	;enter here to perform the read/write
	xra	a		;zero to accum
	sta	erflag		;no errors (yet)
	lda	seksec		;compute host sector
	ora	a		;carry = 0
	rar			;shift right
	ora	a		;carry = 0
	rar			;shift right
	sta	sekhst		;host sector to seek

;	active host sector?
	lxi	h,hstact	;host active flag
	mov	a,m
	mvi	m,1		;always becomes 1
	ora	a		;was it already?
	jz	filhst		;fill host if not

;	host buffer active, same as seek buffer?
	lda	sekdsk
	lxi	h,hstdsk	;same disk?
	cmp	m		;sekdsk = hstdsk?
	jnz	nomatch

;	same disk, same track?
	lxi	h,hsttrk
	call	sektrkcmp	;sektrk = hsttrk?
	jnz	nomatch

;	same disk, same track, same buffer?
	lda	sekhst
	lxi	h,hstsec	;sekhst = hstsec?
	cmp	m
	jz	match		;skip if match

nomatch:
	;proper disk, but not correct sector
	lda	hstwrt		;host written?
	ora	a
	cnz	writehst	;clear host buff

filhst:
	;may have to fill the host buffer
	lda	sekdsk
	sta	hstdsk
	lhld	sektrk
	shld	hsttrk
	lda	sekhst
	sta	hstsec
	lda	rsflag		;need to read?
	ora	a
	cnz	readhst		;yes, if 1
	xra	a		;0 to accum
	sta	hstwrt		;no pending write

match:
	;copy data to or from buffer
	lda	seksec		;mask buffer number
	ani	secmsk		;least signif bits
	mov	l,a		;ready to shift
	mvi	h,0		;double count
	dad	h		;shift left 7
	dad	h
	dad	h
	dad	h
	dad	h
	dad	h
	dad	h
;	hl has relative host buffer address
.z80
	ld	de,hstbuf
	add	hl,de		;hl = host address
	ld	de,(dmaadr)	;de = dma address
	ld	bc,128		;length
	ld	a,(readop)	;which way?
	or	a
	jr	nz,rwmove	;skip if read

;	write operation, mark and switch direction
	ld	a,1
	ld	(hstwrt),a	;hstwrt = 1
	ex	de,hl		;source/dest swap

rwmove:	call	move		;move a logical sector to/from buffer

.8080
;	data has been moved to/from host buffer
	lda	wrtype		;write type
	cpi	wrdir		;to directory?
	lda	erflag		;in case of errors
	rnz			;no further processing

;	clear host buffer for directory write
	ora	a		;errors?
	rnz			;skip if so
	xra	a		;0 to accum
	sta	hstwrt		;buffer written
	call	writehst
	lda	erflag
	ret

;*	Utility subroutine for 16-bit compare        *;

sektrkcmp:			;HL = .unatrk or .hsttrk, compare with sektrk
;	.z80
;	ld	bc,(sektrk)
;	or	a		; clear carry
;	sbc	hl,bc		; hl=hl-bc
;	ret			; return status
	xchg
	lxi	h,sektrk
	ldax	d		;low byte compare
	cmp	m		;same?
	rnz			;return if not
;	low bytes equal, test high 1s
	inx	d
	inx	h
	ldax	d
	cmp	m	;sets flags
	ret
subttl Physical disk routines
page
.z80
; select disk drive, C=drive number 0=A:, 1=B:
; return HL=dph for selected drive, or HL=0 for non-existent drive
dsksel:	ld	hl,0	; hl = 0 for non-existent drive
	ld	a,c
	cp	2
	ret	nc	; drive number >B:
	or	a	; zero flag set => A: drive else B: drive
	ld	hl,dpha	; select proper dph for drive
	jr	z,sel0
	ld	hl,dphb
sel0:	ld	a,(dsk)	; selecting disk already selected?
	cp	c
	ret	z	; yes, no further action needed
	ld	a,c	; save new disk number
	ld	(dsk),a
	or	a	; set zero flag if A: drive
	push	hl	; hl=dph of disk to be selected
	ld	de,16	; to density bit in dph
	add	hl,de
	ld	a,(hl)	; move into A then store into denflag
	ld	(denflag),a
	ld	hl,trackb ;now find proper track(x)
	jr	z,sel1
	dec	hl
sel1:	ld	a,(hl)	; have we been on the disk we are "leaving"
	cp	255	; if not do not update trackx
	jr	z,selnot
	in	a,(track)
	ld	(hl),a	; save track of disk we are leaving
selnot:	ld	a,c	; set zero flag if A: drive
	or	a
	ld	hl,tracka
	jr	z,sel2
	inc	hl
sel2:	ld	a,(hl)
	out	(track),a ; track of disk we are selecting
	ex	de,hl
	pop	hl	; address of dph for disk we are selecting
density:cp	255		; first time for this drive?
	ret	nz		; need to check density?
	call	ready		; physical disk select
	call	home		; seek track 0
	in	a,(bitport)	; test double density first
	and	denmask		; or in density flag
	or	ddbit		; set density flag
	out	(bitport),a
	call	dcheck		; see if we can read address
	jr	z,dend		; density is double?
	in	a,(bitport)	; set density flag to single
	and	denmask
	or	sdbit
	out	(bitport),a
	call	dcheck		; see if we can read address
	ret	nz		; can't read single or double so don't change
	jr	dens
dend:	push	hl		; (* double density *)   hl^ to dph
	push	de
	ld	de,0		; no xlate table (done by FORMAT program)
	ld	(hl),e		; store table^ into dph
	inc	hl
	ld	(hl),d
	ld	de,9		; move foward in dph to dpb pointer
	add	hl,de
	ld	de,dpbd		; double density dpb
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	de,5		; to desity flag in dph
	add	hl,de
	ld	a,ddbit		;  double density bit flag
	ld	(hl),a
	ld	(denflag),a
	jr	den1		; exit
dens:	push	hl		; (* single density *)   hl^ to dph
	push	de
	ld	de,tbl1		; single density sector xlate table
	ld	(hl),e		; store table^ into dph
	inc	hl
	ld	(hl),d
	ld	de,9		; move foward in dph to dpb pointer
	add	hl,de
	ld	de,dpbs		; single density dpb
	ld	(hl),e
	inc	hl
	ld	(hl),d
	ld	de,5		; to desity flag in dph
	add	hl,de
	ld	a,sdbit		; single density bit flag
	ld	(hl),a
	ld	(denflag),a
den1:	pop	de		; restore pointer to dph
	pop	hl		; pointer to track(x) bios register
	in	a,(sector)	; update track register
	out	(track),a
	ld	(de),a
	ret
dcheck:	ld	a,adrcmd	; get address command
	out	(cmnd),a	; issue command to controller
	call	busy		; wait for command done
	bit	4,a		; record not found flag
	ret			; return status

; home disk head
dohome:	call	ready	; make sure drive is on and ready
	ld	a,rstcmd; restore command
	out	(cmnd),a; issue command
	jr	busy	; test and wait for not busy

; seek track #, BC=Track #
trkset:	call	ready		; make sure drive is on and ready
	ld	a,c		; move track number to A
	out	(data),a	; track # to seek to
	ld	a,seekcmd	; seek command
	out	(cmnd),a	; issue command
	jr	busy		; test and wait for not busy

; select sector #, BC=Sector #
secset:	ld	a,c		; move sector number to A
	out	(sector),a	; to controller register
	ret

; perform logical to physical sector translation.
; logical sector number in BC, table address in DE
; return physical sector number in HL
sectran:ld	a,d	; table address 0?
	or	e
	ld	h,b	; if so no xlate
	ld	l,c
	ret	z
	ex	de,hl	; table address in hl
	add	hl,bc	; index by logical sector number
	ld	l,(hl)
	ld	h,0
	ret

; ready disk drive, perform physical disk select, set density bit
ready:	push	hl		; save hl
	push	de		; and de
	push	bc
	ld	a,ficmd		; abort any controller action
	out	(cmnd),a
	call	diskon		; turn drive motor on
	ld	a,(dsk)		; A=drive #
	ld	e,a		; save drive # in E
	in	a,(bitport)	; A=bit port
	and	0FCH		; strip current drive bits
	or	e		; or in requested drive
	inc	a		; bump, 01=A:    10=B:
	and	denmask		; set density bit
	ld	hl,denflag	; hl^ to density bit for this drive
	or	(hl)
	out	(bitport),a	; to bit port
	pop	bc
	pop	de
	pop	hl
	ret

; turn disk motor on, delay for drive speed
diskon:	in	a,(bitport)	; get current drive motor status
	bit	6,a		; is motor on?
	ret	z		; motor on, do nothing
	res	6,a		; motor on bit
	out	(bitport),a	; turn motor on
	ld	b,50		; delay
	call	thnsd
	ret

; turn disk motor off
diskoff:in	a,(bitport)
	set	6,a		; motor off bit
	out	(bitport),a
	ret
; delay for B th's @ 4Mhz
thnsd:	ld	de,1670
tlp:	dec	de
	ld	a,d
	or	e
	jp	nz,tlp
	djnz	thnsd
	ret

; check status of controller, wait for command to finish executing
busy:	halt			; wait for command done
bsy:	in	a,(status)	; now wait for not busy
	bit	0,a
	jr	nz,bsy
	ret
subttl Writehst and Readhst logical to Physical routines
page
;*	WRITEHST performs the physical write to      *;
;*	the host disk, READHST reads the physical    *;
;*	disk.					     *;

writehst:;hstdsk = host disk #, hsttrk = host track #,
	;hstsec = host sect #. write "hstsiz" bytes
	;from hstbuf and return error flag in erflag.
	;return erflag non-zero if error
	ld	de,tries1*256+tries2	; retry error counts
wrthst:	push	de		; save error counts
	call	hstcom		; set track and sector
	call	wrt512		; read sector
	ld	(erflag),a	; error return flag
	pop	de		; restore error flags
	ret	z		; good op
	dec	e		; retry count
	jr	nz,wrthst	; try again
	dec	d		; home and reseek count
	ret	z		; can't recover
	call	dohome		; re seek
	ld	e,tries2	; reset retry count
	jr	wrthst

readhst:;hstdsk = host disk #, hsttrk = host track #,
	;hstsec = host sect #. read "hstsiz" bytes
	;into hstbuf and return error flag in erflag.
	ld	de,tries1*256+tries2	; retry error counts
rdhst:	push	de		; save error counts
	call	hstcom		; set track and sector
	call	rd512		; read sector
	ld	(erflag),a	; error return flag
	pop	de		; restore error flags
	ret	z		; good op
	dec	e		; retry count
	jr	nz,rdhst	; try again
	dec	d		; home and reseek count
	ret	z		; can't recover
	call	dohome		; re seek
	ld	e,tries2	; reset retry count
	jr	rdhst

hstcom:	ld	a,(hstdsk)	; select disk
	ld	c,a
	call	dsksel
	ld	bc,(hsttrk)	; set track to hsttrk
	call	trkset		; physical seek
	ld	a,(hstsec)	; set physical sector
	ld	c,a		; c=sector
	call	secset
	ret
subttl Physical disk I/O, RAM image
page
ioimage:
;move:				; block memory move, turn rom on/off
	in	a,(bitport)	; turn rom off
	res	7,a
	out	(bitport),a
	ldir			; move logical sector from hstbuf
	in	a,(bitport)	; turn rom back on
	set	7,a
	out	(bitport),a
	ret			; back to rom

;rd128:
	ld	hl,(dmaadr)	; address of operation
	ld	b,1		; read a 128 byte sector
	jr	rd
;rd512:
	ld	hl,hstbuf
	ld	b,4		; read a 512 byte sector
; read a sector, return A=0 for no errors, A=1 for non-recoverable error
; if b=1 128, b=2 256, b=3 384, b=4 512   bytes/sector
rd:	ld	de,rdmask*256+rdcmd	; d=read status mask, e=read command
	jr	action

;wrt128:
	ld	hl,(dmaadr)
	ld	b,1		; write a 128 byte sector
	jr	wrt
;wrt512:
	ld	hl,hstbuf
	ld	b,4		; write a 512 byte sector
; write a sector, return as per read
wrt:	ld	de,wrtmask*256+wrtcmd ; d=status mask, e=write command
	;fall through to action

action:	call	ready			; make sure drive is on and ready
	di				; no interrupts during disk I/O operations
	in	a,(bitport)		; turn rom off
	res	7,a
	out	(bitport),a
	push	hl			; save address of disk buffer
	ld	hl,nmivec		; set up nmi vector
	ld	a,(hl)			; save current contents
	ex	af,af'
	ld	(hl),retcod		; this is a return after HALT in loop
	pop	hl			; hl = dma address
	ld	a,b			; sector multiple
	ld	bc,128*256+data		; b=sector length, c=data port
	bit	0,a			; if 0 then 256 or 512 bytes/sector
	jr	nz,actn			; b set for 128 or 384 bytes/sector
	ld	b,0			; b set for 256 or 512 bytes/sector
actn:	cp	1			; compute entry point 1st or 2nd loop
	push	psw			; save as Z flag
	ld	a,e			; i/o command
	cp	wrtcmd			; a write?
	jr	z,wstart		; start write command

	out	(cmnd),a		; fall through to read loop
	pop	psw
	jr	z,rl2
rl1:	halt				; wait for controller
	ini
	jr	nz,rl1
rl2:	halt
	ini
	jr	nz,rl2
	jr	done			; read loop done, exit

wstart:	out	(cmnd),a		; write loop
	pop	psw
	jr	z,wl2
wl1:	halt
	outi
	jr	nz,wl1
wl2:	halt
	outi
	jr	nz,wl2

done:	ex	af,af'			; byte at nmi vector address
	ld	(nmivec),a		; restore it
	in	a,(bitport)		; turn rom back on
	set	7,a
	out	(bitport),a
	ei				; turn interrupts on
	call	busy			; get status when contoller not busy
	and	d			; status mask
	ret	z			; no bit set, return operation ok
	ld	a,1			; cp/m error return
	ret

imaglen	equ	$-ioimage		; length of this image
page
subttl SIO, PIO, and CTC equates
.comment %
###############################################################
##                                                           ##
##       System device I/O routines for KBD, TTY and LST     ##
##                                                           ##
###############################################################
##	LAST UPDATE: JULY 7,1982	[001]		     ##
##		BY JIM NICKERSON			     ##
##		CHANGED SIOA REGISTER 3 INIT TO AUTO ENABLE  ##
##		ADDED LIST STATUS FOR THE SERIAL PORT	     ##
##		TTYOUT NOW THE SAME AS OUT WITH STATUS CHK   ##
##		CHANGE VECTOR PAD MAPING                     ##
###############################################################
%
.z80
.xlist
;	public	kbdstat, kbdin, kbdout, ttystat, ttyin, ttyout, TTYOSTAT
;	public	liststat, list, devinit
	.list

;***************
;* sio equates *
;***************

sio	equ	04H	; base address of sio
sioa0	equ	sio+2	; channel a command/status
sioa1	equ	sio+0	; channel a data
siob0	equ	sio+3	; channel b command/status
siob1	equ	sio+1	; channel b data

; write registers 0-7 and control bits
; init registers in the following order 0,2,4,3,5,1

WR0	equ	0	; command register, crc reset, reg pointer
; bits 0-2 are register pointers to WRx and RRx
; bits 3-5 and commands as given bellow
null	equ	0	; null command
extrset	equ	10H	; reset ext/status interrupts
reset	equ	18H	; channel reset
ienrc	equ	20H	; Enable Int on Next Rx Character
rtip	equ	21H	; reset transmitter interrupt pending
errset	equ	30H	; error reset
retint	equ	31H	; return from interrupt

WR1	equ	1H	; interrupt enable and Wait/Ready modes
esie	equ	1H	; external/status interrupt enable
tie	equ	2H	; transmitter interrupt enable
tid	equ	0	; transmitter interrupt disable
statav	equ	4H	; Status affects vector (z80 mode 2) (see WR2)
; bits 3-4 affect receive interrupt mode
rid	equ	0	; receive interrupts disabled
rifc	equ	8H	; receive interrupt on first char only
riep	equ	10H	; recv interrupts enabled, parity err Special Recv Cond
rie	equ	18H	; same as riep but parity error not Special Recv Cond

WR2	equ	2	; interrupt vector address/pointer (chan b only)
; interrupt address (z80 reg I+WR2=interrupt address)
; returned as is if not statav above in wr1
; if statav then bits 1-3 are modified as bellow:
;	000	ch b transmit buffer empty
;	001	ch b external/status change
;	010	ch b receive char available
;	011	ch b special receive condition (parity error, Rx overrun,
;			framing error, end of frame(sdlc) )
;	1xx	ch a (* same vectors as for channel b above *)

WR3	equ	3	; receiver logic control and parameters
re	equ	1	; receiver enable
autoe	equ	20H	; auto enable (use dcd and cts to enable recv and xmt
; bits 6-7 are receiver bits/character
rbits5	equ	0	; 5 bits/character
rbits7	equ	40H	; 7 bits/character
rbits6	equ	80H	; 6 bits/character
rbits8	equ	0C0H	; 8 bits/character

WR4	equ	4	; control bits that affect both xmt and recv
pon	equ	1	; enable parity (parity on)
pstate	equ	2	; parity even   not pstate = parity odd
; bits 2-3 are number of stop bits
syncmd	equ	0	; sync mode is to be selected
sbits1	equ	4	; 1 stop bit
sbits5	equ	8H	; 1.5 stop bits
sbits2	equ	0CH	; 2 stop bits
; bits 6-7 control clock rate
cr1	equ	0	; data rate x1=clock rate
cr16	equ	40H	;           x16
cr32	equ	80H	;           x32
cr64	equ	0CH	;           x64

WR5	equ	5	; control bits that affect xmt
te	equ	8H	; transmit enable
break	equ	10H	; send break
; bits 5-6 are number of bits/character to transmit
tbits5	equ	0	; 5 or less bits/character
tbits7	equ	20H	; 7 bits/character
tbits6	equ	40H	; 6 bits/character
tbits8	equ	60H	; 8 bits/character
rts	equ	2	; RTS output
dtr	equ	80H	; DTR output

WR6	equ	6	; sdlc transmit sync character
WR7	equ	7	; sdlc receive sync character

; read registers 0-2 and status bits
rr0	equ	0	; general recv and xmt status
rca	equ	1	; receive character available
intped	equ	2	; interrupt pending (ch a only)
tbe	equ	4	; transmit buffer empty
synhnt	equ	10H	; sync/hunt
dcd	equ	8H	; DCD input
cts	equ	20H	; CTS input
xmtundr	equ	40H	; transmit underrun/ EOM
brk	equ	80H	; break/abort status

rr1	equ	1	; Special Receive conditions and Residue codes
; bits 4-7 are special receive conditions
rpe	equ	10H	; parity error
rovr	equ	20H	; Rx overrun error
framerr	equ	40H	; framing error

rr2	equ	2	; interrupt vector address/pointer

;***************
;* pio equates *
;***************

pio	equ	08H	; base address of pio
pioac	equ	pio+1	; pio a control
pioad	equ	pio+0	; pio a data
piobc	equ	pio+3	; pio b control
piobd	equ	pio+2	; pio b data

spio	equ	01CH	; base address of pio (system status bits port)
spioac	equ	spio+1	; pio a control
spioad	equ	spio+0	; pio a data
spiobc	equ	spio+3	; pio b control
spiobd	equ	spio+2	; pio b data

bitport	equ	spioad	; system bit port for status and control
;0 drive sel A:
;1 drive sel B:
;2 n/c
;3 centronics i/o ready line
;4 centronics i/o data strobe
;5 single density  (not 5 is double density)
;6 drive motor off (not 6 is motor on)
;7 rom enable (not 7 is rom off)

; control register
setiv	equ	0	; set interrupt vector, bits 1-7 are vector address

som	equ	0FH	; set operating mode. bits 6-7 specify mode
mode0	equ	0	; output
mode1	equ	40H	; input
mode2	equ	80H	; bidirectional
mode3	equ	0C0H	; control (bit by bit i/o, mode3 command is followed by
			;	byte where bit pattern specifies i/o bits
			;	1=input, 0=output

sicw	equ	7H	; set interrupt control word, bits 4-7 are parameters
imask	equ	10H	; bit mask follows		  )
hghlow	equ	20H	; high/low			  ) mode 3 only
andor	equ	40H	; and/or of bits to gen interrupt )
intena	equ	80H	; enable interrupt (bit low disable interrupts)

intcmd	equ	03H	; set interrupt enable/disable without changing status as sicw

;***************
;* ctc equates *
;***************

ctc	equ	18H	; ctc base address
ctc0	equ	ctc+0	; ctc channel 0
ctc1	equ	ctc+1	; ctc channel 1
ctc2	equ	ctc+2	; ctc channel 2
ctc3	equ	ctc+3	; ctc channel 3

; channel control register bits
ctccmd	equ	01H	; ctc command byte
ctcint	equ	80H	; interrupt enable
ctcm1	equ	40H	; set ctc mode is counter
ctcm0	equ	00H	; set ctc mode is timer
range	equ	20H	; timer prescaler factor is 256 (not range is 16)
slope	equ	10H	; edge triger positive (not slope is negative edge)
trigger	equ	8H	; ext trigger
ltc	equ	4H	; load time constant (followed by time constant)
rsetctc	equ	2H	; reset channel

ctcivec	equ	0	; set ctc interrupt vector, bits 3-7 are vector addr
ctcvmsk	equ	0F8H	; interrupt vector mask to strip bits 0-2

;***************
;* baud rate   *
;***************

bauda	equ	00H	; baud rate generator for serial chan a
baudb	equ	0CH	; baud rate generator for serial chan b

; baud rate factors, output to baudx to select baud rate
baud10	equ	02H	; 110 baud rate
baud30	equ	05H	; 300 baud rate
baud12	equ	07H	; 1200 baud rate
baud24	equ	0AH	; 2400 baud rate
baud48	equ	0CH	; 4800 baud rate
baud96	equ	0EH	; 9600 baud rate
baud19k	equ	0FH	; 19.2k baud rate
subttl I/O configuration tables
page
iotabint:		; i/o device initialization table
			; first byte is port #
			; second byte is byte to send to port
	defb	(iotblend-iotabint)/2	; table length in arguments

; init sio channel b
defb	siob0, reset			; reset sio channel
defb	baudb, baud30			; 300 baud
defb	siob0, wr4
defb	siob0, sbits1 or cr16		; one stop bit, 16x clock
defb	siob0, wr3
defb	siob0, re or rbits8		; recv enable, 8 bits/char
defb	siob0, wr5
defb	siob0, te or tbits8 or dtr	; xmt enable, 8bits/char, assert dtr
defb	siob0, wr1
defb	siob0, tid or rid		; xmt & recv interrupts disabled

; init sio channel a
defb	sioa0, reset			; reset sio channel
defb	bauda, baud30			; 300 baud
defb	sioa0, wr4
defb	sioa0, sbits1 or cr16		; one stop bit, 16x clock
defb	sioa0, wr3
defb	sioa0, re or rbits8 or autoe	; recv enable, 8 bits/char, auto enable
defb	sioa0, wr5
defb	sioa0, te or tbits8 or dtr	; xmt enable, 8bits/char, assert dtr
defb	sioa0, wr1
defb	sioa0, tid or rid		; xmt & recv interrupts disabled

; init pio used form system control bits
defb	spioac, intcmd			; disable interrupts
defb	spioad, 10000001B		; set system status bits (before setting mode!)
defb	spioac, som or mode3		; set mode to #3
defb	spioac, 00001100B		; bit pattern for mode 3

; init pio used to drive printer
defb	pioac, intcmd			; disable interrupts
defb	pioac, som or mode0		; set mode to #0  (output)
defb	piobc, intcmd			; disable interrupts
defb	piobc, som or mode1		; set mode to #1 (input)
iotblend:				; end of table

devinit:ld	hl,iotabint	; initialize i/o devices
	ld	b,(hl)		; number of bytes to send to i/o devices
iolp:	inc	hl
	ld	c,(hl)		; port to send
	inc	hl
	ld	a,(hl)		; byte to send
	out	(c),a
	djnz	iolp
	ret			; done
subttl Device I/O handlers
page
kbdstat:in	a,(siob0)	; kbd char avail?
	and	rca
	ret	z		; 0=no char
	ld	a,0FFH		; FF=char avail
	ret

kbdin:	call	kbdstat		; loop till char avail
	jr	z,kbdin
	in	a,(siob1)	; get char
	call	kbdmap		; map out funny chars of vector pad and #'s
	ret

kbdout:	in	a,(siob0)	; xmit buffer empty?
	and	tbe
	jr	z,kbdout
	ld	a,c		; out character
	out	(siob1),a
	ret

kbdmap:	ld	hl,mapin	; input map table
	ld	bc,mapout-mapin	; table length
	cpir			; search table
	ret	nz		; not found
	ld	de,mapin	; make hl=table index
	or	a		; hl-mapin=index
	sbc	hl,de
	ld	de,mapout-1	; index
	add	hl,de
	ld	a,(hl)		; get char from mapout
	ret

mapin:	defb	0F1H, 0F2H, 0F3H, 0F4H	; up, down, left, right arrows
	defb	0B1H, 0C0H, 0C1H, 0C2H	; 0,1,2,3
	defb	0D0H, 0D1H, 0D2H, 0E1H	; 4,5,6,7
	defb	0E2H, 0E3H, 0E4H, 0D3H	; 8,9, '-', ','
	defb	0C3H, 0B2H		; return, '.'
	defb	0FFH			; end of mapin table
mapout:	defb	80H, 81H, 82H, 83H	; vector pad, xlate in bios
	defb	84H, 85H, 86H, 87H
	defb	88H, 89H, 8AH, 8BH
	defb	8CH, 8DH, 8EH, 8FH
	defb	90H, 91H

ttystat:in	a,(sioa0)		; serial port status input
	and	rca
	JR	COMOUT

ttyin:	call	ttystat			; is a char ready?
	jr	z,ttyin
	in	a,(sioa1)
	ret

ttyout:	in	a,(sioa0)		; output a char to serial port
	and	tbe
	jr	z,ttyout		; xmit buffer full?
	ld	a,c
	out	(sioa1),a		; xmit character
	ret

;
TTYOSTAT:	;TEST STATUS OF SERIAL OUTPUT
	IN	A,(SIOA0)
	AND	TBE			;TX BUF FULL ?
	JR	COMOUT
;
; list port centronics equates
pready	equ	3			; bit in bit port
pstrob	equ	4			; bit in bit port

liststat:in	a,(bitport)		; centronics printer port status
	bit	pready,a
COMOUT:	ret	z			; 0=busy
	ld	a,0FFH			; FF=ready
	ret

list:	call	liststat		; is printer busy?
	jr	z,list
	ld	a,c
	out	(pioad),a		; output char to printer
	in	a,(bitport)		; strb. printer
	set	pstrob,a
	out	(bitport),a
	res	pstrob,a
	out	(bitport),a
	ret

page
subttl Memory maped video output driver
.comment %
##################################################################
##								##
##	Memory maped video output driver			##
##								##
##################################################################
##	Last Update : july 13 1982				##
##		by jim nickerson				##
##################################################################
%
;
.xlist
;	extrn	leadflg, row, cursor, chrmsk, kbdout
;	public	vidout, vidinit, print
.list

.z80
jmpif	macro	j,k	;SHORT JUMP
	cp	j
	JR	z,k
	endm
;
LJMPIF	macro	j,k	;LONG JUMP
	cp	j
	jp	z,k
	endm


colcp	macro	x
	ld	a,l
	and	not colum-1
	cp	x
	endm

SPACE	equ	20H		; space char
cr	equ	0DH		; move cursor to beginning of line
bs	equ	08H		; move cursor left (control h)
fs	equ	0CH		; move cursor right (control l)
lf	equ	0AH		; move cursor down (control j)
rlf	equ	0BH		; move cursor up (control k)
eol	equ	18H		; clear to end of line (control x)
eos	equ	17H		; clear to end of screen (control w)
clr	equ	1AH		; clear screen char (control z)
homec	equ	1EH		; home cursor
esc	equ	1BH		; escape, lead-in character
bell	equ	07H		; ascii bell
curchr	equ	'_' or 80H	; character for cursor
ascii	equ	7FH		; ascii mask
greek	equ	1FH		; greek character set mask

base	equ	03000H			;start of video ram
linlen	equ	80			;logical line length
colum	equ	128			;physical line length
lines	equ	24			;lines per display
line1	equ	base			;start of first line
line2	equ	base+colum		;start of second line
last1	equ	base+(lines-1)*colum	;start of last line
last	equ	(base+lines*colum)-1	;last char of display
bitport	equ	1CH			;system bit port

vidinit:ld	a,space		; clear row #
	ld	(row),a
	call	clear		; clear screen and home cursor
	ld	(cursor),hl
	xor	a
	ld	(leadflg),a	; no leadin sequence
	ld	a,17H		; re-set scroll register
	out	(14H),a
	ld	a,ascii		; set ascii mask
	ld	(chrmsk),a
	ret

vidout:
	ld	a,(leadflg)	; processing a lead-in sequence?
	or	a
	jp	nz,leadin
	ld	a,bell		; ring bell, no display?
	cp	c
	JR	nz,nobell
	ld	c,04H		; kbd bell code
	jp	kbdout		; ring bell

nobell:	call	clrcur		; clear (remove) cursor
	ld	de,finsh	; set up return to finish
	push	de
	ld	a,c		; char to print
	jmpif	lf,lfcd		; line feed (down arrow)
	LJMPIF	cr,return	; return
	jmpif	bs,back		; back space (left arrow)
	jmpif	fs,fowrd	; right arrow
	jmpif	rlf,up		; up arrow
	LJMPIF	esc,doesc	; lead-in
	LJMPIF	eol,cleol	; clear to eol
	jmpif	eos,cleos	; clear to eos
	jmpif	clr,clear	; clear screen, home currsor
	jmpif	homec,hmcsr	; home cursor
	cp	60H		; lower case?
	jr	c,vout
	ld	a,(chrmsk)	; if lower do we print greek chr set?
	and	c
vout:	ld	(hl),a		; display character
	inc	hl		; inc cursor position
	ld	a,l		; off end of line?
	and	not colum
	cp	linlen		; logical line length
	ret	c		; not past colum-1
	call	return
	jr	lfcd

vovr:	ld	de,last		; off display memory?
	ld	a,d
	cp	h
	jr	c,scroll
	ret	nz
	ld	a,e
	cp	l
	ret	nc
scroll:	ld	b,lines-1	; number of lines to scroll
	ld	hl,line2
	ld	de,line1
scr1:	push	bc		; save line count
	ld	bc,linlen	; logical line length
	ldir			; scroll one line
	ld	bc,colum-linlen	; to beginning of next line
	add	hl,bc
	ex	de,hl
	add	hl,bc
	ex	de,hl
	pop	bc		; line count
	djnz	scr1		; do another line
	ld	hl,last1		; to last line of display
	JR	cleol		; clear it

;
; process a line feed (cursor down)
;
lfcd:	ld	de,colum	; to next line, same column
	add	hl,de
	JR	vovr
;
; back space the cursor
;
back:	ld	a,l		; is column # 0?
	and	not colum
	ret	z		; at beginning of line
	dec	hl		; back space
	ret
;
; move cursor foward
;
fowrd:	ld	a,l		; right most column?
	and	07FH		;INSTEAD OF not colum-1
	cp	79
	ret	nc
	inc	hl		; bump cursor address
	ret
;
; move cursor up one line
;
up:	push	hl		; save current position
	ld	de,-colum	; move up one line
	add	hl,de
	push	hl		; save new cursor position
	or	a		; clear carry
	ld	de,line1	; first char of display
	sbc	hl,de		; if carry set we are off display
	pop	hl		;	hl = new pos
	pop	de		;	de = old pos
	ret	nc
	ex	de,hl
	ret
;
; clear screen
;
clear:	ld	hl,line1	; clear screen
	ld	de,line1+1
	ld	bc,last-base
	ld	(hl),space
	ldir
	ld	hl,line1	; home cursor
	ret
;
; home cursor
;
hmcsr:	ld	hl,line1	; line one of display
	ret
;
; clear to end of screen
;
cleos:
; patch by jim
	push	hl	;save current position
	call	cleol
	ld	de,colum
	ld	a,l
	and	080H
	ld	l,a
	add	hl,de	;begining of next line
	ld	a,03CH		;after last line now ?
	cp	h		;h holds page (3B) is last line
	jr	z,cleos1	;yes so no more to blank get out
;
	ld	e,l		; copy hl to de
	ld	d,h
	or	a		; clear carry
	ld	hl,last		; last pos of screen
	sbc	hl,de		; last-current position
	ld	c,l		; move count to bc
	ld	b,h
	ld	h,d		; move current position into hl
	ld	l,e
	inc	de
	ld	(hl),space
	ldir
;
;patch by jim
cleos1:
;
	pop	hl		; restore cursor position
	ret
;
; clear to end of line
;
cleol:
;
;patch by jim
;
	ld	a,l
	and	07FH
	cp	linlen-1
	jr	c,cleol1
	ld	(hl),space
	ret
cleol1:
;
;
	push	hl		; save current position
	push	hl
	ld	a,l		; find beginning of line
	and	not colum-1
	ld	l,a
;
;patch by jim
	ld	de,linlen-1
;
	add	hl,de		; hl points to end of line
	pop	de		; current position in de
	push	de
	or	a		; clear carry
	sbc	hl,de		; hl=# of bytes to clear
	ld	c,l		; move count into bc
	ld	b,h
	pop	hl		; current position
	ld	e,l		; copy to de
	ld	d,h
	inc	de
	ld	(hl),space
	ldir
	pop	hl		; restore cursor address
	ret

clrcur:	ld	hl,(cursor)	; get cursor location
	ld	a,(hl)		; undo cursor
	cp	curchr		; is it a cursor on a blank field?
	ld	a,space
	jr	nz,clr1
	ld	(hl),a
clr1:	res	7,(hl)		; undo cursor
	ret
;
; process a return
;
return:	ld	a,l
	and	not colum-1
	ld	l,a
	ret
;
; escape lead-in sequence start up
;
doesc:	ld	a,1		; leadflg is a counter of chars processed
	ld	(leadflg),a
	ret
;
; process second, third and fourth characters of lead-in sequence
;
leadin:	ld	hl,exit		; fake ret to exit
	push	hl
	ld	hl,leadflg
	ld	(hl),0		; clear lead-in counter in case error
	cp	1		; second char? (leadflg=1 processed first char)
	jr	nz,l1
	ld	a,c		; what type of esc sequence?
	res	7,a
	cp	'G'		; greek character set?
	jr	z,dogreek
	cp	'A'		; ascii character set?
	jr	z,doascii
	cp	'R'		; delete line?
	jr	z,dodel
	cp	'E'		; insert line?
	jr	z,doinst
	cp	'='		; esc =   sequence (cursor positioning)
	ret	nz		; error, exit
	ld	(hl),2		; have processed second character of sequence
	ret
l1:	cp	2		; third character?
	jr	nz,l2
	ld	a,c		; row number+space
	ld	(row),a		; save for later use
	ld	(hl),3		; have processed third character
	ret
l2:	cp	3		; fourth character?
	ret	nz		; error, leadflg trashed by someone

	call	clrcur		; remove cursor then move it
	pop	hl		; ret to exit not needed
	ld	hl,line1	; process col #
	ld	a,c
	sub	' '		; remove ascii space bias
;patch by jim
;
l3:	sub	linlen
;
	jr	nc,l3
	add	a,linlen
	ld	l,a
	ld	a,(row)
	sub	' '		; remove ascii space bias
l4:	sub	lines		; range 0 - lines
	jr	nc,l4
	add	a,lines
	ld	de,colum	; add column to cursor pos till
l5:	jp	z,finsh		; # lines = 0
	add	hl,de
	dec	a
	jr	l5
;
FINSH:	LD	A,(HL)		; MAKE A CURSOR
	CP	SPACE		; SPACE
	JR	NZ,FIN1		; IF SO THEN SPECIAL CURSOR CHAR
	LD	A,CURCHR
FIN1:	SET	7,a
	ld	(hl),a
	ld	(cursor),hl	; save location
exit:	ret			; all done

;
; switch from ascii to greek
;
dogreek:ld	a,greek		; greek char mask
	ld	(chrmsk),a
	ret
;
; switch from greek to ascii
;
doascii:ld	a,ascii		; ascii mask
	ld	(chrmsk),a
	ret
;
; delete line, scroll up to current line, blank 24'th line
;
dodel:	pop	hl		; ret to exit not needed
	call	setup		; setup cpu regs for ldir
	push	de		; current line
	jr	z,delscr	; if setup set Z flag no scroll
	ldir
delscr:	ld	hl,last1	; blank last line
	call	cleol
	pop	hl		; current line
	JR	finsh
;
; insert a blank line at current row address, 24'th line lost
;
doinst:	pop	hl		; ret to exit not needed
	call	setup
	push	de		; current line
	jr	z,inscr		; no scroll
	ld	de,last1+127
	ld	hl,last1-1
	lddr
inscr:	pop	hl		; current line
	push	hl
	call	cleol		; clear it
	pop	hl		; current row, colum=0
	JR	finsh

setup:	call	clrcur		; get current cursor position
	call	return		; to beginning of line
	push	hl		; save it
	ex	de,hl		; compute amount to move
	ld	hl,last1	; last line of display
	or	a
	sbc	hl,de
	ld	b,h		; bc=length
	ld	c,l
	pop	hl		; current pos
	push	hl
	ld	de,128		; set a pointer to beginning of next line
	add	hl,de		; hl=current+128 (next line)
 	pop	de		; de=current
	ld	a,b		; is bc zero
	or	c
	ret 

print:	ex	(sp),hl	; pop return address, points to text to print
	ld	a,(hl)	; get a byte of text, stop on zero byte
	inc	hl
	ex	(sp),hl	; save new return address
	or	a	; is it a zero byte?
	ret	z
	ld	c,a	; no, so print it
	call	vidout
	jr	print
	defb	0FFH		; because L80 tends to drop the last byte

page
subttl RAM storage
.comment %
###############################################################
##                                                           ##
##       System scratch RAM used by ROM software             ##
##                                                           ##
###############################################################
##       Last Update:05/31/82           [001]                ##
###############################################################
%
.z80
.xlist
;	public	sekdsk, sektrk, seksec, hstdsk, hsttrk, hstsec
;	public	sekhst, hstact, hstwrt, unacnt, unadsk, unatrk
;	public	unasec, erflag, rsflag, readop, wrtype, dmaadr
;	public	hstbuf, dsk, denflag, tracka, trackb, dirbuf, move
;	public	csva, alva, csvb, alvb, dpha, dphb, rd128, rd512
;	public	leadflg, row, cursor, chrmsk, wrt128, wrt512, stack
;	public	dpbs, dpbd, tbl1, tbl2
.list

ramscratch	equ	0FC00H	; scratch ram

sekdsk	equ	ramscratch	;seek disk number
sektrk	equ	sekdsk+1	;seek track number
seksec	equ	sektrk+2	;seek sector number
hstdsk	equ	seksec+1	;host disk number
hsttrk	equ	hstdsk+1	;host track number
hstsec	equ	hsttrk+2	;host sector number
sekhst	equ	hstsec+1	;seek shr secshf
hstact	equ	sekhst+1	;host active flag
hstwrt	equ	hstact+1	;host written flag
unacnt	equ	hstwrt+1	;unalloc rec cnt
unadsk	equ	unacnt+1	;last unalloc disk
unatrk	equ	unadsk+1	;last unalloc track
unasec	equ	unatrk+2	;last unalloc sector
erflag	equ	unasec+1	;error reporting
rsflag	equ	erflag+1	;read sector flag
readop	equ	rsflag+1	;1 if read operation
wrtype	equ	readop+1	;write operation type
dmaadr	equ	wrtype+1	;last dma address
hstbuf	equ	dmaadr+2	;host buffer
dsk	equ	hstbuf+512	; current disk drive
denflag	equ	dsk+1		; density flag for current drive
tracka	equ	denflag+1	; track of disk A	(255=density unknown)
trackb	equ	tracka+1	; track of disk B
csva	equ	trackb+1	; directory check
alva	equ	csva+16		; allocation map
csvb	equ	alva+25
alvb	equ	csvb+16
leadflg	equ	alvb+25		; video leadin sequence count
row	equ	leadflg+1	; temp store of rom number
cursor	equ	row+1		; cursor address
chrmsk	equ	cursor+2	; ascii/greek character set switch
dpha	equ	chrmsk+1	; DPH for A
dphb	equ	dpha+17		; DPH for B
dpbs	equ	dphb+17		; single density dpb
dpbd	equ	dpbs+15		; double density dpb
tbl1	equ	dpbd+15		; single density skew table
tbl2	equ	tbl1+18		; 512 byte sector skew table
move	equ	tbl2+10		; move logical sector from hstbuf
rd128	equ	move+15		; routine to read 128 byte sector
rd512	equ	rd128+7		; routine to read 512 byte sector
wrt128	equ	rd512+10	; routine to write 128 byte sector
wrt512	equ	wrt128+7	; routine to wrtie 512 byte sector
rdwrtend equ	rd128+150	; end of read and write routines
dirbuf	equ	rdwrtend+1	; bdos directory buffer

stack	equ	0FFFFH		; boot up stack space
	end
