; -*- tab-width: 8 -*-

; MD5 checksum utility for x86 Linux, assembly version
; To build: nasm -f bin -O9 prog.x86.asm -o prog

%define @pie 0

BITS 32
%if @pie
ORG 0
%else
ORG 0x400000
%endif

%define @sys_exit 1
%define @sys_read 3
%define @sys_write 4

section .text

_code_seg:
_elf:	db 7Fh,'ELF',1,1,1,0	; e_ident
	dq 0
	dw 2+@pie	; e_type
	dw 3		; e_machine
	dd 1		; e_version
	dd _start	; e_entry
	dd .ph-_elf	; e_phoff
	dd 0		; e_shoff
	dd 0		; e_flags
	dw 0x34		; e_ehsize
	dw 0x20,1	; e_phentsize, e_phnum
	dw 0x28,0	; e_shentsize, e_shnum
	dw 0		; e_shstrndx
.ph:	dd 1			; p_type
	dd 0			; p_offset
	dd _code_seg		; p_vaddr
	dd _code_seg		; p_paddr
	dd _code_end-_code_seg	; p_filesz
	dd _code_end-_code_seg	; p_memsz
	dd 5, 0x1000		; p_flags, p_align

_start:

%define @cos_hi 1133096 ; l
%define @cos_lo 128673  ; m
%define @sin_hi 1764692 ; o
%define @sin_lo 1171746 ; p

	sub	esp, 64*4
	push	@cos_hi
	push	@sin_hi
	push	@cos_lo
	push	@sin_lo
	xor	ebx, ebx
	push	-1 << (40 - 32)
	push	ebx
	push	ebx
	push	ebx
.4x:	xor	ebp, ebp
	xor	edi, edi
.4:	mov	eax, ebx
	mov	esi, ebx
	and	eax, 7
	and	esi, 3
	add	eax, esi
	mov	ecx, [esp+16+eax*2]
	and	esi, 1
	mov	eax, [esp+esi*8]
	mul	ecx
	imul	ecx, [esp+esi*8+4]
	add	edx, ecx
	test	bl, 1+4
	jne	.4a
	sub	edi, eax
	sbb	ebp, edx
	jmp	.4b
.4a:	add	edi, eax
	adc	ebp, edx
.4b:	inc	ebx
	test	bl, 1
	jne	.4
	shrd	edi, ebp, 21
	sar	ebp, 21
	test	bl, 2
	jne	.4
	pop	eax
	pop	edx
	pop	ecx
	pop	esi
	push	ebp
	push	edi
	test	bl, 4
	je	.4d
	push	edx
	push	eax
	push	esi
	push	ecx
	jmp	.4x

.4d:	mov	ecx, ebx
	shrd	edi, ebp, 8
	sar	ebp, 31
	shr	ecx, 3
	xor	edi, ebp
	cmp	ecx, 64+1
	mov	[esp+32+ecx*4-4], edi
	jne	.4x
	add	esp, 32

	mov	eax, ~0xefcdab89
	cdq
	push	edx
	push	edx
	mov	ecx, ~0x67452301
	push	eax
	push	ecx
	not	eax
	not	ecx
	push	eax
	push	ecx
	sub	esp, 64+4

.2:	mov	edi, esp
	xor	eax, eax
	lea	ecx, [eax+16]
	cld
	rep	stosd
	test	edx, edx
	lea	edx, [eax+64]
	xchg	ebx, eax	; 0 (stdin)
	jne	.2a
	mov	ecx, esp
%if @sys_read != @sys_write-1
	lea	edi, [ebx+@sys_read]
%endif
	call	_io
	mov	byte [ecx], 0x80
	sub	ecx, esp
	shl	ecx, 3
.2a:	mov	edi, esp
	lea	esi, [edi+64+4+16]
	add	[esi], ecx
	adc	[esi+4], ebx
	cmp	edx, 8
	jb	.2b
	neg	edx
	add	edi, 56
	movsd
	movsd
.2b:	push	edx
	xor	ebx, ebx

	mov	edx, esp
	mov	ecx, [edx+0x40+8]
	mov	edi, [edx+0x44+8]
	mov	esi, [edx+0x48+8]
	mov	ebp, [edx+0x4c+8]
.1:	add	ecx, [esp+64+16+16+ebx*4]

	; ecx, edi, esi, ebp

%define PACK(a,b,c,d,e,f) (d<<15|c<<10|b<<5|a)<<4|e<<24|f

	mov	edx, ebx
	shr	edx, 5
	mov	eax, ebp
	jne	.1b
	jc	.1a
	; 0: ((b^c)&a)^c
	mov	edx, PACK(7,12,17,22,1,0)
	xor	eax, esi
	and	eax, edi
	xor	eax, ebp
	jmp	.1e

.1a:	; 1: ((a^b)&c)^b
	mov	edx, PACK(5, 9,14,20,5,1)
	mov	eax, edi
	xor	eax, esi
	and	eax, ebp
	jmp	.1d

.1b:	jc	.1c
	; 2: a^b^c
	mov	edx, PACK(4,11,16,23,3,5)
	xor	eax, edi
	jmp	.1d

.1c:	; 3: (~c|a)^b
	mov	edx, PACK(6,10,15,21,7,0)
	not	eax
	or	eax, edi
.1d:	xor	eax, esi
.1e:	add	eax, ecx

	mov	ecx, edx
	shr	ecx, 24
	imul	ecx, ebx
	add	ecx, edx
	and	ecx, 15
	add	eax, [esp+4+ecx*4]

	mov	ecx, ebx
	and	ecx, 3
	lea	ecx, [ecx+ecx*4+4]
	shr	edx, cl
	mov	ecx, edx
	rol	eax, cl

	mov	ecx, ebp	; a = d
	mov	ebp, esi	; d = c
	mov	esi, edi	; c = b
	add	edi, eax	; b += x
	inc	ebx
	cmp	ebx, 64
	jne	.1

	mov	edx, esp
	add	[edx+0x40+8], ecx
	add	[edx+0x44+8], edi
	add	[edx+0x48+8], esi
	add	[edx+0x4c+8], ebp
	pop	edx
	test	edx, edx
	jge	.2

	xor	edx, edx
	mov	edi, esp
.3:	mov	eax, edx
	shr	eax, 1
	mov	al, [esp+64+4+eax]
	jc	.3a
	shr	al, 4
.3a:	and	al, 15
	cmp	al, 10
	jb	.3b
	add	al, 'a'-'0'-10
.3b:	add	al, '0'
	stosb
	inc	edx
	cmp	edx, 32
	jne	.3
	mov	al, 10
	stosb
	inc	edx

	mov	ecx, esp
	lea	ebx, [edx-32]	; 1 (stdout)
%if @sys_read != @sys_write-1
	lea	edi, [ebx+@sys_write-1]
%endif
	call	_io
	xor	ebx, ebx	; exit code
	lea	eax, [ebx+@sys_exit]
	int	0x80

_io:
%if @sys_read != @sys_write-1
	mov	eax, edi
%else
	lea	eax, [ebx+@sys_read]
%endif
	push	edx
	int	0x80
	pop	edx
	test	eax, eax
	jle	.1
	add	ecx, eax
	sub	edx, eax
	ja	_io
	cdq
.1:	ret

_code_end:

