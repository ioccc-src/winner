; -*- tab-width: 8 -*-

; MD5 checksum utility for x86_64 Linux, assembly version
; To build: nasm -f bin -O9 prog.x86_64.asm -o prog

%define @pie 0

BITS 64
%if @pie
ORG 0
%else
ORG 0x400000
%endif

%define @sys_read 0
%define @sys_write 1
%define @sys_exit 60

section .text

_code_seg:
_elf:	db 0x7f,'ELF',2,1,1,0	; e_ident
	dq 0
	dw 2+@pie	; e_type
	dw 62		; e_machine
	dd 1		; e_version
	dq _start	; e_entry
	dq .ph-_elf	; e_phoff
	dq 0		; e_shoff
	dd 0		; e_flags
	dw 0x40		; e_ehsize
	dw 0x38, 1	; e_phentsize, e_phnum
	dw 0x40, 0	; e_shentsize, e_shnum
	dw 0		; e_shstrndx
.ph:	dd 1, 5			; p_type, p_flags
	dq 0			; p_offset
	dq _code_seg		; p_vaddr
	dq _code_seg		; p_paddr
	dq _code_end-_code_seg	; p_filesz
	dq _code_end-_code_seg	; p_memsz
	dq 0x1000		; p_align

_start:
	mov	rax, ~0xefcdab8967452301
	push	rax
	not	rax
	push	rax
	sub	rsp, 64+8

	xor	r12, r12
;	xor	edx, edx
	cdq

.2:	mov	rdi, rsp
	xor	eax, eax
	lea	ecx, [rax+8]
	rep	stosq
	test	edx, edx
	lea	edx, [rax+64]
	jne	.2a
	xchg	edi, eax	; 0 (stdin)
	mov	rsi, rsp
%if @sys_read != 0 || @sys_write != 1
	lea	ebx, [rdi+@sys_read]
%endif
	call	_io
	mov	byte [rsi], 0x80
	sub	esi, esp
	lea	r12, [r12+rsi*8]
.2a:	cmp	edx, 8
	jb	.2b
	neg	edx
	mov	[rsp+56], r12
.2b:	push	rdx
	xor	ebx, ebx
	mov	r14, 0x8a51407da834 << 15	; cos(1) * 2^48
	mov	r15, 0xd76aa4784867 << 15	; sin(1) * 2^48
	mov	r8, r14
	mov	r9, r15

	mov	rdx, rsp
	mov	ecx, [rdx+0x50]
	mov	edi, [rdx+0x54]
	mov	esi, [rdx+0x58]
	mov	ebp, [rdx+0x5c]
.1:
	mov	rax, r9
	cqo
	shr	rax, 31
	xor	eax, edx
	add	ecx, eax

	; r9' = r9 * r14 + r8 * r15
	; r8' = r8 * r14 - r9 * r15

	mov	rax, r9
	imul	r15
	mov	r11, rdx
	mov	rax, r8
	imul	r14
	sub	rdx, r11
	lea	rax, [rdx+rdx]
	xchg	rax, r8
	imul	r15
	lea	rax, [rdx+rdx]
	xchg	rax, r9
	imul	r14
	lea	r9, [rdx*2+r9]

	; r10d, edi, esi, ebp

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
	add	eax, [rsp+8+rcx*4]

	mov	ecx, ebx
	and	ecx, 3
	lea	ecx, [rcx+rcx*4+4]
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

	mov	rdx, rsp
	add	[rdx+0x50], ecx
	add	[rdx+0x54], edi
	add	[rdx+0x58], esi
	add	[rdx+0x5c], ebp
	pop	rdx
	test	edx, edx
	jge	.2

	xor	edx, edx
	mov	rdi, rsp
.3:	mov	eax, edx
	shr	eax, 1
	mov	al, [rsp+0x40+8+rax]
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

	mov	rsi, rsp
	lea	edi, [rdx-32]	; 1 (stdout)
%if @sys_read != 0 || @sys_write != 1
	lea	ebx, [rdi+@sys_write-1]
%endif
	call	_io
	xor	edi, edi	; exit code
	lea	eax, [rdi+@sys_exit]
	syscall

_io:
%if @sys_read != 0 || @sys_write != 1
	mov	eax, ebx
%else
	mov	eax, edi
%endif
	syscall
	test	eax, eax
	jle	.1
	add	rsi, rax
	sub	edx, eax
	ja	_io
;	xor	edx, edx
	cdq
.1:	ret

_code_end:

