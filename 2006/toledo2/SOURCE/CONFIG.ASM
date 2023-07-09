false	equ	0
true	equ	not false
debug	equ	false
	.list	;begin listing
title KAYPRO CONFIG (custom configuration utility program) 2.0 Copyright (C) 1982 NLS, Inc.
page
;###############################################################
;##	KAYPRO II CONFIG PROGRAM			      ##
;##	 containing within it the new cbios image so that     ##
;##	 if this is run against a disk with the old cbios     ##
;##	 it is updated at the same time.		      ##
;##      KAYPRO         CBIOS for CP/M 2.2                    ##
;##      Copyright (C) 1982 By Non-Linear Systems, Inc.       ##
;##      No warranty is made, expressed or implied.           ##
;###############################################################
;##	Last Update: july 11,1982			      ##
;##		by jim nickerson			      ##
;##		-allow redefinition of cursor keys	      ##
;##		-allow redifinition of keypad keys	      ##
;##		-allow redefinition of default i/o byte       ##
;##		-allow changing of the baud rate	      ##
;##		-write these changes to disk		      ##
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

;
; begining of the config program
;
	jp	config	;begining of program
;
mprint:
	ld	a,(de)	;get char
	cp	0FFH	;end
	ret	z	;finished
	push	de
	ld	c,2
	ld	e,a
	call	5
	pop	de
	inc	de
	jr	mprint
;
sprint	macro	arg
	ld	de,arg	;pointer to print line
	call	mprint
	endm
;
;
printone macro
	push	af	;save char
	ld	c,2	;console output
	ld	e,a	;char
	call	5
	pop	af	;recover char
	endm
;
;
inone	macro
	local	loop
loop:
	ld	c,6	;direct console input
	ld	e,0FFH
	call	5
	cp	0	;0=nochar
	jr	z,loop	;wait for char
	endm
;
;
jmpif	macro	arg, adr
	cp	arg
	jp	z, adr
	endm
;
;print a message using bdos call
cr	equ	0DH
lf	equ	0AH
uprint	macro	x
	ld	c,9
	ld	de,x	;message pointer
	call	5	;pass it to bdos
	endm
;
;get a char from the console, up case
input	macro
	ld	c,1	;console input
	call	5	;pass it to bdos
	endm
;
;***************************************************************
;***************************************************************
;
config:	;begining of the config program with main menu
;
;****************************************************************
;****************************************************************
;
	ld	a,1
	ld	(disk),a	;force drive B
	ld	a,0FFH
	ld	(change),a	;changes flag 0=yes some changes
;
first:
	uprint	menuheader
	uprint	menu0
	input		;get an answer
	push	af	;save char
	uprint	crlf
	pop	af
	jmpif	'1',setio	;menu1
	jmpif	'2',setwr	;menu2
	jmpif	'3',setcur	;menu3
	jmpif	'4',setnum	;menu4
	jmpif	'5',setbaud	;menu5
	jmpif	01BH,go$out
	jp	first
;
setbaud:
	uprint	menuheader
	uprint	menu5
	input
	push	af
	uprint	crlf
	pop	af
	jmpif	'1',hbaud
	jmpif	01BH,first
	jmpif	'2',dobaud
	jp	setbaud
;
dobaud:
	uprint	baudinst
dob1:
	ld	a,0
	ld	(curline),a	;which choice
	uprint	firstchoice
dob2:
	inone		;get a key
	cp	01BH
	jr	z,setbaud
	cp	lf
	jp	z,db1
	cp	cr
	jr	nz,dob2
	;was a cr so we have a choice
	ld	a,(curline)
	cp	16		;wants to exit
	jp	nc,dob2
	out	(0),a		;set baud rate
	jp	setbaud
;
db1:
	ld	a,(curline)	;where are we
	inc	a		;bump pointer
	ld	(curline),a	;save for future use
	cp	17		;end of choices
	jr	z,dob1
	uprint	nextline	;advance one line
	jr	dob2		;next line
curline: defb	0
baudinst:
	defb	1AH
	defb	'   50',cr,lf
	defb	'   75',cr,lf
	defb	'  110		Move the cursor to the baud rate which',cr,lf
	defb	'  134.5',cr,lf
	defb	'  150		you want to use by typing the [LINE FEED] key.',cr,lf
	defb	'  300',cr,lf
	defb	'  600',cr,lf
	defb	' 1200		When the cursor is at the rate you want',cr,lf
	defb	' 1800',cr,lf
	defb	' 2000		type the RETURN key and it will be set.',cr,lf
	defb	' 2400',cr,lf
	defb	' 3600		The new baud rate will be effective now.',cr,lf
	defb	' 4800',cr,lf
	defb	' 7200',cr,lf
	defb	' 9600',cr,lf
	defb	'19200',cr,lf
	defb	'Type [ESC] key to return to the previous menu (no changes)',cr,lf
	defb	cr,lf,lf
	defb	'(* NOTE: The baud rate will always default to 300 baud  *)',cr,lf
	defb	'(*       after the power is first turned on and when    *)',cr,lf
	defb	'(*       the RESET button is pressed.                   *)',cr,lf
	defb	'$'
firstchoice:
	01EH,0CH,0CH,0CH,0CH,0CH,'$'
nextline:
	0AH,'$'
;
hbaud:	;tell him about baud rates
	uprint	baudmsg
	uprint	crtocont
	input
	jp	setbaud
;
setnum:
	uprint	menuheader
	uprint	menu4
	input
	push	af
	uprint	crlf
	pop	af
	jmpif	'1',hnum
	jmpif	'2',donum
	jmpif	01BH,first
	jp	setnum
;
getone:
	ld	a,(curline)
	inc	a
	ld	(curline),a	;bumped pointer
	call	hex2in	;get 2 hex chars in c
	jr	nz,gadj
;wants to exit maybe
	cp	lf	;move cursor
	ret	z
	;must be esc then
	pop	hl	;clean stack
	ld	hl,(gohere)
	jp	(hl)	;oblidge him
	ret	z
;adjust changes flag
gadj:
	ld	a,0
	ld	(change),a	;yes some changes
;
;record changes in mem image of cbios
	ld	de,0
	ld	a,(curline)	;put here -1
	dec	a
	ld	e,a
	ld	hl,(puthere)	;where to put changes
	add	hl,de		;hl points to char
	ld	a,c		;get char
	ld	(hl),a		;put him in mem
	ret
;
; get two hex chars
hex2in:
	inone	;get one key
	cp	0AH	;move to next position
	ret	z
	cp	01BH
	ret	z	;exit on esc
	cp	030H	;0 the lowest one allowed
	jr	c,hex2in
	cp	03AH	;tween 0 and 9
	jr	c,setone
	res	5,a	;make upper case if lower
	cp	047H	;F the highest allowed
	jr	nc,hex2in
	cp	041H	;must not be less than A
	jr	c,hex2in
	printone
	sub	7	;remove bias
	jr	seta
setone:
	printone
seta:
	sub	030H	;take off bias
	rlc	a	;slowly
	rlc	a	;shift the
	rlc	a	;low nible
	rlc	a	;to the high nible
	and	0F0H	;mask off the low nible
	push	af	;save it
settwo:	;force him to enter second char in hex
	inone	;get one key
	cp	0AH
	jr	z,s2
	cp	01BH
	jr	nz,s3
s2:
	pop	hl	;clean stack
	ret		;with z set to exit
s3:
	cp	030H
	jr	c,settwo	;not acceptable
	cp	03AH	;tween 0-9
	jr	c,set3
	res	5,a	;make upper case if lower
	cp	047H
	jr	nc,settwo	;not acceptable
	cp	041H
	jr	c,settwo	;nogood
	printone
	sub	7	;remove bias
	jr	set4
set3:	;got second char in hex
	printone
set4:
	sub	030H
	and	0FH	;ONLY WANT LOW NIBLE
	ld	c,a	;save it
	pop	af	;recover high nible
	or	c	;assembled char
	ld	c,a	;save char in a
	ret	nz
	inc	a	;must ret not zero
	ret
;
;
donum:
	ld	hl,setnum
	ld	(gohere),hl	;where to exit to on esc
	ld	hl,cbios+039H
	ld	(puthere),hl
	uprint	numchoices
donum1:
	ld	a,0	;first choice
	ld	(curline),a
	sprint	key0
	call	getone
	sprint	key1
	call	getone
	sprint	key2
	call	getone
	sprint	key3
	call	getone
	sprint	key4
	call	getone
	sprint	key5
	call	getone
	sprint	key6
	call	getone
	sprint	key7
	call	getone
	sprint	key8
	call	getone
	sprint	key9
	call	getone
	sprint	key10	;-
	call	getone
	sprint	key11	;,
	call	getone
	sprint	key12	;enter
	call	getone
	sprint	key13	;.
	call	getone
	sprint	key14	;return
numpat:
	inone
	cp	01BH	;ESC
	jp	z,setnum
	cp	lf
	jr	nz,numpat
	jp	donum1
;
numchoices:
	defb	01AH
	defb	'-----------------------------	Move the cursor to the key you wish',cr,lf
	defb	':      :      :      :      :',cr,lf
	defb	':   7  :   8  :   9  :   -  :	to change. Use the [LINE FEED] key.',cr,lf
	defb	':      :      :      :      :',cr,lf
	defb	':  37  :  38  :  39  :  2D  :	The default HEXADECIMAL code will be',cr,lf
	defb	';------;------;------;------:',cr,lf
	defb	':      :      :      :      :	the number which is flashing.',cr,lf
	defb	':   4  :   5  :   6  :   ,  :',cr,lf
	defb	':      :      :      :      :',cr,lf
	defb	':  34  :  35  :  36  :  2C  :	When you reach the key you wish to change.',cr,lf
	defb	':------:------:------:------:',cr,lf
	defb	':      :      :      :      :	Type in the new HEXADECIMAL code.',cr,lf
	defb	':   1  :   2  :   3  :      :',cr,lf
	defb	':      :      :      :      :',cr,lf
	defb	':  31  :  32  :  33  : ENTER:	(* NOTE: you must enter both digits *)',cr,lf
	defb	':------:------:------:      :',cr,lf
	defb	':             :      :  0D  :	(*       to change the code.        *)',cr,lf
	defb	':      0      :   .  :      :',cr,lf
	defb	':             :      :      :',cr,lf
	defb	':     30      :  2E  :      : Type the [ESC] key to return to the previous menu',cr,lf
	defb	'-----------------------------',cr,lf
	defb	'$'
;
key0:	defb	01BH,'=',19+20H,6+20H,0FFH
key1:	defb	01BH,'=',14+20H,3+20H,0FFH
key2:	defb	01BH,'=',14+20H,10+20H,0FFH
key3:	defb	01BH,'=',14+20H,17+20H,0FFH
key4:	defb	01BH,'=',9+20H,3+20H,0FFH
key5:	defb	01BH,'=',9+20H,10+20H,0FFH
key6:	defb	01BH,'=',9+20H,17+20H,0FFH
key7:	defb	01BH,'=',4+20H,3+20H,0FFH
key8:	defb	01BH,'=',4+20H,10+20H,0FFH
key9:	defb	01BH,'=',4+20H,17+20H,0FFH
key10:	defb	01BH,'=',4+20H,24+20H,0FFH
key11:	defb	01BH,'=',9+20H,24+20H,0FFH
key12:	defb	01BH,'=',16+20H,24+20H,0FFH
key13:	defb	01BH,'=',19+20H,17+20H,0FFH
key14:	defb	01BH,'=',19+20H,41+20H,0FFH
hnum:
	uprint	nummsg
	uprint	crtocont
	input
	jp	setnum
;
setcur:
	uprint	menuheader
	uprint	menu3
	input
	push	af
	uprint	crlf
	pop	af
	jmpif	'1',hcur
	jmpif	01BH,first
	jmpif	'2',docur
	jr	setcur
;
;
docur:
	ld	hl,cbios+035H	;WHERE TO PUT CHANGES
	ld	(puthere),hl
	ld	hl,setcur
	ld	(gohere),hl	;ret here on esc
	uprint	curinst
doc1:
	ld	a,0
	ld	(curline),a	;item to change
	sprint	cur0	;left cursor key
	call	getone	;input etc
	sprint	cur1
	call	getone
	sprint	cur2
	call	getone
	sprint	cur3
	call	getone
	sprint	cur4	;type esc to exit
doc4:
	inone		;get one key
	cp	0AH
	jp	z,doc1
	cp	01BH
	jr	nz,doc4
	jp	setcur
;
	jp	doc1	;again
hcur:
	uprint vecmsg
	uprint	crtocont
	input
	jp	setcur
;
;
curinst:
	defb	01AH
	defb	cr,lf
	defb	cr,lf
	defb	'            ---------------------------------',cr,lf
	defb	'            :       :       :       :       :',cr,lf
	defb	'            :   ^   :   :   :  <-   :  ->   :',cr,lf
	defb	'            :   :   :   v   :       :       :',cr,lf
	defb	'            :       :       :       :       :',cr,lf
	defb	'            :  0B   :  0A   :  08   :  0C   :',cr,lf
	defb	'            ---------------------------------',cr,lf
	defb	cr,lf
	defb	cr,lf
	defb	'       Type the [ESC] key to return to the previous menu.',cr,lf
	defb	cr,lf
	defb	' Move the cursor to the key which you wish to change by pressing',cr,lf
	defb	' the [LINE FEED] key. The default HEXADECIMAL code will be the flashing number.',cr,lf
	defb	' Type the new HEXADECIMAL number you wish to assign to the key.',cr,lf
	defb	cr,lf
	defb	' You must type both digits to effect the change.',cr,lf
	defb	cr,lf
	defb	'$'
;
cur0:	defb	01BH,'=',7+20H,15+20H,0FFH
cur1:	defb	01BH,'=',7+20H,23+20H,0FFH
cur2:	defb	01BH,'=',7+20H,31+20H,0FFH
cur3:	defb	01BH,'=',7+20H,39+20H,0FFH
cur4:	defb	01BH,'=',11+20H,18+20H,0FFH
setwr:
	uprint	menuheader
	uprint	menu2
	input
	push	af
	uprint	crlf
	pop	af
	jmpif	'1',hwr
	jmpif	'2',dowr
	jmpif	01BH,first
	jp	setwr
;
dowr:
	uprint	wrinst
dow0:
	sprint	wr0
	inone
	cp	0AH
	jr	z,dow1
	cp	01BH
	jp	z,setwr
	cp	0DH
	jr	nz,dow0
;got cr so do it set yes
	ld	a,0FFH	;set it on
	ld	(cbios+034H),a
	ld	a,0
	ld	(change),a
	jp	setwr
dow1:
	sprint	wr1
	inone
	cp	lf
	jr	z,dow2
	cp	01BH
	jr	z,setwr
	cp	cr
	jr	nz,dow1
;have choice set = 0
	ld	a,0
	ld	(cbios+034H),a
	ld	(change),a
	jp	setwr
dow2:
	sprint	wr2
	inone
	cp	01BH
	jp	z,setwr
	cp	lf
	jp	nz,dow2
	jp	dow0
;
;
hwr:
	uprint	safmsg
	uprint	crtocont
	input
	jp	setwr
;
wrinst:
	defb	01AH,cr,lf
	defb	cr,lf,cr,lf
	defb	'Yes I want Write Safe enabeled.',cr,lf
	defb	cr,lf
	defb	'No do not enable Write Safe.	This is the default mode on your KAYPRO II .',cr,lf
	defb	cr,lf
	defb	'Type the [ESC] key to return to the previous menu.',cr,lf
	defb	cr,lf,cr,lf
	defb	'Use the [LINE FEED] key to move the cursor to the mode',cr,lf
	defb	'which you wish to use and then type the [RETURN] key to',cr,lf
	defb	'enter your choice.',cr,lf
	defb	cr,lf
	defb	'**** PLEASE read the help file before you enable Write Safe. ****',cr,lf
	defb	'****        If you do not understand it ASK your dealer.     ****',cr,lf
	defb	'$'
;
wr0:	defb	01BH,'=',3+20H,20H,0FFH
wr1:	defb	01BH,'=',5+20H,20H,0FFH
wr2:	defb	01BH,'=',7+20H,11+20H,0FFH
;
setio:
	uprint	menuheader
	uprint	menu1
	input		;get response
	push	af
	uprint	crlf
	pop	af
	jmpif	'1',hio
	jmpif	'2',doio
	jmpif	01BH,first
	jp	setio
;
doio:
	uprint	ioinst
	ld	hl,cbios+033H
	ld	(puthere),hl
	ld	hl,setio
	ld	(gohere),hl
doio0:
	ld	a,0
	ld	(curline),a
	sprint	io0
	call	inio
	sprint	io1
	call	inio
doioc:	sprint	io2
	call	inio
	sprint	io3
	call	inio
doioe:	sprint	io4
doio1:
	inone
	cp	01BH
	jp	z,setio
	cp	0AH
	jr	nz,doio1
	jp	doio0
;
inio:
	inone	;get a char
	cp	01BH
	jr	nz,inio1
	pop	hl
	ld	hl,(gohere)
	jp	(hl)
inio1:
	cp	0AH
	jr	nz,inio2
;have line feed so bump cur line before returning
	ld	a,(curline)
	inc	a
	ld	(curline),a
	ret
inio2:
	cp	0DH
	jr	nz,inio
; must have a cr now process it
	ld	a,0
	ld	(change),a	;yes some changes
	ld	a,(curline)
	add	a,a
	ld	de,0
	ld	e,a
	ld	hl,ivtab
	add	hl,de	;hl now points to 1 of 4
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ex	de,hl
	ld	de,(puthere)	;where it goes
	jp	(hl)
ivtab:	defw	sio0
	defw	sio1
	defw	sio2
	defw	sio3
sio0:
	ld	a,(de)
	res	1,a
	set	0,a
	ld	(de),a
	ld	hl,doioc
	ld	a,2
	ld	(curline),a
	pop	de
	jp	(hl)
sio1:
	ld	a,(de)
	res	0,a
	res	1,a
	ld	(de),a
	ld	a,(curline)
	inc	a
	ld	(curline),a
	ret
sio2:
	ld	a,(de)
	res	6,a
	set	7,a
	ld	(de),a
	ld	hl,doioe
	jp	(hl)
sio3:
	ld	a,(de)
	res	7,a
	res	6,a
	ld	(de),a
	ret
;
;
hio:
	uprint	iomsg
	uprint	crtocont
	input
	jp	setio
;
;
ioinst:
	defb	01AH
	defb	cr,lf,cr,lf
	defb	'	Default settings	Posibile changes',cr,lf
	defb	'	----------------	----------------',cr,lf
	defb	cr,lf
	defb	'	CON:=CRT:		CON:=TTY:	Type the [LINE FEED] key to ',cr,lf
	defb	'	LST:=LPT:		LST:=TTY:	move the cursor to the mode ',cr,lf
	defb	'	PUN:=TTY:		- none -	you wish to select.',cr,lf
	defb	'	RDR:=TTY:		- none -	Then the RETURN key to enter',cr,lf
	defb	'						your selection.'
	defb	cr,lf
	defb	'	Type the [ESC] key to return to the previous menu.',cr,lf
	defb	cr,lf
	defb	'* CON: If you chose CON:=TTY: then all input and output  will be through the',cr,lf
	defb	'	serial connector on the back of your KAYPRO II instead of through the',cr,lf
	defb	'	keyboard and the CRT.',cr,lf
	defb	cr,lf
	defb	cr,lf
	defb	'* LST:	This setting will decide wether the output directed at a printer',cr,lf
	defb	'	will go through the LPT: (parallel connector) or to the',cr,lf
	defb	'	TTY: (serial connector).',cr,lf
	defb	'$'
;
io0:	defb	01BH,'=',5+20H,12+20H,0FFH
io1:	defb	01BH,'=',5+20H,36+20H,0FFH
io2:	defb	01BH,'=',6+20H,12+20H,0FFH
io3:	defb	01BH,'=',6+20H,36+20H,0FFH
io4:	defb	01BH,'=',10+20H,19+20H,0FFH
;
go$out:	;here to exit  check if any changes so as to
	;know wether to write to disk or not
	ld	a,(change)
	cp	0FFH		;0FFH=nochanges
	jp	nz,askout
bye:
	ld	a,0
	ld	(0FA34H),a	;reset write safe off
	jp	z,0		;exit with no changes
;
;
askout:
	uprint	ask
	input			;get response
	res	5,a		;make upper case
	cp	'N'
	jp	z,bye		;exit
	cp	'Y'
	jr	nz,askout
;
; now to write the changes to the disk
procede:	;get on with it
;reset the disk system for drive B
	ld	a,0FFH
	ld	(0FA34H),a	;set the write safe flag
	ld	c,14		;select disk
	ld	a,(disk)	;find out which disk to use
	ld	e,a
	call	5		;tell bdos
;
;set up initial paramaters
	ld	hl,cbios
	ld	(from),hl	;where to start writing from
;
	ld	bc,0001H
	ld	(track),bc	;track we will be using
;
	ld	bc,21
	ld	(sector),bc	;first sector to write to
;
	ld	a,4
	ld	(count),a	;how many sectors to write
;
	ld	hl,080H
	ld	(secsize),hl	;sector size
;
;now to do the writing on the disk
nextsec:
	ld	bc,(track)
	call	0FA1EH		;set the track required
;
	ld	bc,(from)
	call	0FA24H		;set the dma address
;
	ld	bc,(sector)
	call	0FA21H		;set the sector to write
;
	ld	c,0
	call	0FA2AH		;write the sector
;	check for error's on return
	cp	0		;a=0=no errors
	jr	z,go$on
	uprint	erms		;error message
	uprint	crtocont
	input			;pause for any key to continue
	ld	a,0
	ld	(0FA34H),a	;reset write safe flag
	jp	config		;exit
;
go$on:
	ld	hl,(from)	;dma address
	ld	de,(secsize)
	add	hl,de		;bump dma address
	ld	(from),hl	;save it for reuse
	ld	a,(sector)
	inc	a		;bump sector number
	ld	(sector),a	;save for next write
	ld	a,(count)	;are we
	dec	a		;done yet
	ld	(count),a	;save in case we are not done
	cp	0
	jp	nz,nextsec	;not yet finished
;
	uprint	alldone
	ld	a,0
	ld	(0FA34H),a	;reset write safe flag
	jp	config		;exit
;
change:	defb	0
disk:	defb	0
from:	defw	0
puthere:
	defw	0
track:	defw	0
sector:	defw	0
count:	defb	0
gohere: defw	0
secsize:
	defw	0
crlf:	defb	cr,lf,'$'
alldone:
	defb	cr,lf,'DONE WITH CONFIGURATION',cr,lf,'$'
crtocont:
	defb	cr,lf,'Please type any key to continue','$'
erms:
	defb	cr,lf,'*** I can''t write to your disk ***',cr,lf,'$'
menuheader:
	defb	01AH,cr,lf,cr,lf
	defb	'KAYPRO II  CONFIGURATION PROGRAM   11 July 1982'
;
choices:
	defb	cr,lf
	defb	'-----------------------------------------------'
	defb	cr,lf,cr,lf
	defb	'CHOICES'
	defb	cr,lf
	defb	'-------'
	defb	cr,lf,cr,lf
	defb	'$'
menu0:	;first level menu
	defb	'1 --------> I/O Byte cold boot defaults'
	defb	cr,lf
	defb	'2 --------> Write Safe flag'
	defb	cr,lf
	defb	'3 --------> Cursor Keys definitions'
	defb	cr,lf
	defb	'4 --------> Numerical keypad definitions'
	defb	cr,lf
	defb	'5 --------> Baud rate'
	defb	cr,lf
	defb	cr,lf
	defb	'[ESC] key ----> EXIT this program and return to CP/M'
	defb	cr,lf
	defb	cr,lf
	defb	'(* NOTE: Anything not changed will contain its default value. *)'
	defb	cr,lf
	defb	cr,lf
	defb	'Any changes that this program can make will only affect the disk in drive B.'
	defb	cr,lf
	defb	'These changes will not be seen until you move the disk to drive A and'
	defb	cr,lf
	defb	'push the RESET switch (Cold Boot) or turn the power off and on,'
	defb	cr,lf
	defb	'EXCEPT selection ''5'' (Baud rate) which will have an immediate effect.'
	defb	cr,lf
	defb	'Upon exiting this program you will be asked whether you want to apply'
	defb	cr,lf
	defb	'the changes to the disk in drive B.'
	defb	cr,lf
	defb	'Please enter ''1'' or ''2'' or ''3'' or ''4'' or ''5'' or [ESC] key ====>','$'
menu1:	;I/O BYTE menu
	defb	'1 --------> Help (I/O Byte definitions)'
	defb	cr,lf
	defb	cr,lf
	defb	'2 --------> Change the I/O Byte'
	defb	cr,lf
	defb	cr,lf
	defb	'[ESC] key ----> Return to main menu'
	defb	cr,lf,cr,lf
	defb	'Please enter ''1'' or ''2'' or [ESC] key ==========>'
	defb	'$'
;
menu2:	;write safe flag
	defb	'1 --------> Help (Write safe flag definitions)'
	defb	cr,lf
	defb	cr,lf
	defb	'2 --------> Change the write safe flag'
	defb	cr,lf
	defb	cr,lf
	defb	'[ESC] key ----> Return to main menu'
	defb	cr,lf
	defb	cr,lf
	defb	'Please enter ''1'' or ''2'' or [ESC] key ==========>'
	defb	'$'
;
menu3:	;cursor key
	defb	'1 --------> Help (Cursor key definitions)'
	defb	cr,lf
	defb	cr,lf
	defb	'2 --------> Change the Cursor key settings'
	defb	cr,lf
	defb	cr,lf
	defb	'[ESC] key ----> Return to main menu'
	defb	cr,lf,cr,lf
	defb	'Please enter ''1'' or ''2'' or [ESC] key ==========>'
	defb	'$'
menu4:	;numerical key-pad
	defb	'1 --------> Help (Numerical keypad definitions)'
	defb	cr,lf
	defb	cr,lf
	defb	'2 --------> Change the Numerical keypad settings'
	defb	cr,lf
	defb	cr,lf
	defb	'[ESC] key ----> Return to main menu'
	defb	cr,lf,cr,lf
	defb	'Please enter ''1'' or ''2'' or [ESC] key ==========>'
	defb	'$'
menu5:	;baud rate
	defb	'1 --------> Help (Baud rate definitions)'
	defb	cr,lf,cr,lf
	defb	'2 --------> Change the Baud rate'
	defb	cr,lf
	defb	cr,lf
	defb	'[ESC] key ----> Return to main menu'
	defb	cr,lf,cr,lf
	defb	'Please enter ''1'' or ''2'' or [ESC] key ==========>'
	defb	'$'
ask:
	defb	cr,lf
	defb	'Y----------> procede to update the disk in drive B'
	defb	cr,lf
	defb	'N----------> not ready, EXIT TO CP/M'
	defb	cr,lf
	defb	cr,lf
	defb	'Please type (Y) or (N) ====>'
	defb	'$'
;
nummsg:
	defb	1ah,cr,lf
	defb	'On the right hand side of your KAYPRO II keyboard there is a group of',cr,lf
	defb	'fourteen keys, labeled:                 7 8 9 -',cr,lf
	defb	'					4 5 6 ,',cr,lf
	defb	'					1 2 3 enter',cr,lf
	defb	'					 0  .',cr,lf
	defb	cr,lf
	defb	'These fourteen keys each produce a unique code when typed.',cr,lf
	defb	'In some situations it may be useful to have one or more keys  ',cr,lf
	defb	'provide a special function, such as in an application',cr,lf
	defb	'program requiring choices from a menu.',cr,lf
	defb	'	This portion of the CONFIGURATION program allows you to set the',cr,lf
	defb	'codes which will be produced by these fourteen keys.',cr,lf
	defb	cr,lf,lf,lf,lf
	defb	'$'
baudmsg:
	defb	1ah,cr,lf
	defb	'Your KAYPRO II computer has a serial port with which you may communicate',cr,lf
	defb	'with the outside world. This serial port is most often referred to as',cr,lf
	defb	'RS-232. In using RS-232 both the computer and the external device',cr,lf
	defb	'must be set at the same baud rate (the speed at which data travels)',cr,lf
	defb	cr,lf
	defb	'	Your KAYPRO II is capable of the following baud rates:',cr,lf
	defb	'   50		-not used very often',cr,lf
	defb	'   75		-not used very often',cr,lf
	defb	'  110		-used with slower printers',cr,lf
	defb	'  134.5         -used with some IBM printers',cr,lf
	defb	'  150		-not used very often',cr,lf
	defb	'  300		-very common (default on your KAYPRO II on reset)',cr,lf
	defb	'  600		-not used very often',cr,lf
	defb	' 1200		-used with many printers',cr,lf
	defb	' 1800		-not used very often',cr,lf
	defb	' 2000		-not used very often',cr,lf
	defb	' 2400		-not used very often',cr,lf
	defb	' 3600		-not used very often',cr,lf
	defb	' 4800		-higher rate for faster printers',cr,lf
	defb	' 7200		-not used very often',cr,lf
	defb	' 9600		-highest rate normally used',cr,lf
	defb	'19200		-very high rate (for special purposes)',cr,lf
	defb	'(* NOTE: the PRESENT baud rate remains in effect until the next RESET *)'
	defb	'$'
iomsg:	defb	1ah,cr,lf
	defb	'In order to understand this command you should read the CP/M manual',cr,lf
	defb	'"AN INTRODUCTION TO CP/M FEATURES AND FACILITIES", the STAT command',cr,lf
	defb	'logical and physical devices. The logical CP/M devices are: CON: LST:',cr,lf
	defb	'RDR: and PUN:. The physical devices for the KAYPRO computer are:',cr,lf,lf
	defb	'	CRT:	Video and Keyboard',cr,lf
	defb	'	TTY:	Serial port (note the connector must be wired as in the manual)',cr,lf
	defb	'	LPT:	Centronics port',cr,lf
	defb	'	UL1:	This is the same as TTY: above',cr,lf
	defb	'	PTP:	This is the same as TTY: above',cr,lf,lf
	defb	'Possible logical to physical assignments are:',cr,lf,lf
	defb	'	CON: =  TTY: or CRT:',cr,lf
	defb	'	RDR: =  TTY:',cr,lf
	defb	'	PUN: =  TTY: or CRT: or LPT: or UL1:',cr,lf,lf
	defb	'BEFORE using this option try it with the STAT command in CP/M.',cr,lf
	defb	cr,lf,'$'
safmsg:	defb	1ah, cr, lf
	defb	'Your KAYPRO computer comes with a special "Write Safe" option that corrects',cr,lf
	defb	'a problem with CP/M when running with SOME application programs. It is not',cr,lf
	defb	'possible to make the following description nontechnical. If you do not under-',cr,lf
	defb	'stand it, ask your dealer. The wrong setting of the "Write Safe" flag may cause',cr,lf
	defb	'the IRREVOCABLE LOSS OF DATA AND OR PROGRAM(S).',cr,lf,lf
	defb	'The KAYPRO computer uses deblocking. When a disk write operation is',cr,lf
	defb	'immediately followed by a warm boot, the deblocking buffer may not be',cr,lf
	defb	'written to the disk. This is not a likely sequence of events. Most programs',cr,lf
	defb	'when finished writing to a file, will close it. ALL directory operations force',cr,lf
	defb	'the deblock buffer to disk on write. The "Write Safe" flag tells the BIOS',cr,lf
	defb	'that ALL disk operations are directory type. This forces the buffer to the',cr,lf
	defb	'disk. The price is performance, as "Write Safe" will slow the computer down',cr,lf
	defb	'from 2 to 4 times when writing to the disk. "Write Safe" is not a panacea',cr,lf
	defb	'for system or program problems. The chance you will need it is rare.',cr,lf,lf
	defb	cr,lf,'$'
vecmsg:	defb	1ah,cr,lf
	defb	'It is not possible to make the following discription nontechnical.', cr, lf
	defb	'If you do not understand it please ask your dealer.',cr,lf,lf
	defb	'Your KAYPRO II computer comes with four arrow keys, they are at the upper right',cr,lf
	defb	'of the main keyboard. They are usually referred to as CURSOR keys. They are ',cr,lf
	defb	'used in programs such as SELECT to move the cursor. These keys produce codes',cr,lf
	defb	'that are recognized by applications programs. The codes that they produce may',cr,lf
	defb	'or may not be the codes that an application you supply wants. The codes sent',cr,lf
	defb	'by the keyboard are unique, MSB set. The BIOS translates the keyboard codes',cr,lf
	defb	'using a table in the BIOS. This option of the configure program allows you',cr,lf
	defb	'to change the values in this table and record it on the disk. The memory',cr,lf
	defb	'image is not changed until you cold boot (reset).',cr,lf,lf
	defb	cr,lf,'$'
;here begins the updated cbios which must eventually
;reside and operate at 0FA00H which is 01F80H in the sysgen image
;and is track 1 sectors 21-22-23-24 on the disk
;
cbios:	;label to allow update to find him
;***************************************
	.phase	bios		;absolute location of code following
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

;****************************************
	end	config
