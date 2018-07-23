	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"main.c"
	.global	header_size
	.data
	.align	2
	.type	header_size, %object
	.size	header_size, 4
header_size:
	.word	66
	.section	.rodata
	.align	2
.LC0:
	.ascii	"../africa-toto.wav\000"
	.align	2
.LC1:
	.ascii	"rb\000"
	.align	2
.LC2:
	.ascii	"out.wav\000"
	.align	2
.LC3:
	.ascii	"wb\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #48
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	ldr	r0, .L5
	ldr	r1, .L5+4
	bl	fopen
	mov	r3, r0
	str	r3, [fp, #-44]
	ldr	r0, [fp, #-44]
	mov	r1, #0
	mov	r2, #2
	bl	fseek
	ldr	r0, [fp, #-44]
	bl	ftell
	mov	r3, r0
	str	r3, [fp, #-40]
	ldr	r0, [fp, #-44]
	bl	rewind
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-36]
	ldr	r3, [fp, #-40]
	ldr	r0, [fp, #-36]
	mov	r1, r3
	mov	r2, #1
	ldr	r3, [fp, #-44]
	bl	fread
	ldr	r0, [fp, #-44]
	bl	fclose
	ldr	r3, .L5+8
	ldr	r3, [r3, #0]
	mov	r2, r3
	ldr	r3, [fp, #-36]
	add	r3, r3, r2
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-40]
	add	r2, r3, #1
	ldr	r3, .L5+8
	ldr	r3, [r3, #0]
	rsb	r3, r3, r2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-40]
	add	r2, r3, #1
	ldr	r3, .L5+8
	ldr	r3, [r3, #0]
	rsb	r3, r3, r2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-40]
	add	r2, r3, #1
	ldr	r3, .L5+8
	ldr	r3, [r3, #0]
	rsb	r3, r3, r2
	mov	r0, r3
	bl	malloc
	mov	r3, r0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-16]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L2
.L3:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-28]
	add	r1, r3, r2
	ldr	r2, [fp, #-16]
	ldr	r3, [fp, #-32]
	add	r3, r3, r2
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	strh	r3, [r1, #0]	@ movhi
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-28]
	add	r0, r3, r2
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-28]
	add	r3, r3, r2
	ldrh	r1, [r3, #0]
	ldr	r3, [fp, #-16]
	add	r2, r3, #1
	ldr	r3, [fp, #-32]
	add	r3, r3, r2
	ldrb	r3, [r3, #0]	@ zero_extendqisi2
	mov	r3, r3, asl #8
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	mov	r2, r1	@ movhi
	orr	r3, r2, r3
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r0, #0]	@ movhi
	ldr	r3, [fp, #-16]
	add	r3, r3, #2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L2:
	ldr	r3, .L5+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-40]
	rsb	r2, r2, r3
	ldr	r3, [fp, #-16]
	cmp	r2, r3
	bgt	.L3
	ldr	r3, .L5+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-40]
	rsb	r2, r2, r3
	mov	r3, r2, lsr #31
	add	r3, r3, r2
	mov	r3, r3, asr #1
	ldr	r0, [fp, #-28]
	ldr	r1, [fp, #-24]
	mov	r2, r3
	bl	compress_buffer
	ldr	r3, .L5+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-40]
	rsb	r2, r2, r3
	mov	r3, r2, lsr #31
	add	r3, r3, r2
	mov	r3, r3, asr #1
	ldr	r0, [fp, #-24]
	ldr	r1, [fp, #-20]
	mov	r2, r3
	bl	decompress_buffer
	ldr	r0, .L5+12
	ldr	r1, .L5+16
	bl	fopen
	mov	r3, r0
	str	r3, [fp, #-8]
	ldr	r3, .L5+8
	ldr	r3, [r3, #0]
	ldr	r0, [fp, #-36]
	mov	r1, #1
	mov	r2, r3
	ldr	r3, [fp, #-8]
	bl	fwrite
	ldr	r3, .L5+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-40]
	rsb	r2, r2, r3
	mov	r3, r2, lsr #31
	add	r3, r3, r2
	mov	r3, r3, asr #1
	ldr	r0, [fp, #-20]
	mov	r1, #2
	mov	r2, r3
	ldr	r3, [fp, #-8]
	bl	fwrite
	ldr	r0, [fp, #-20]
	bl	free
	ldr	r0, [fp, #-24]
	bl	free
	ldr	r0, [fp, #-28]
	bl	free
	ldr	r0, [fp, #-36]
	bl	free
	ldr	r0, [fp, #-8]
	bl	fclose
	mov	r3, #0
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, lr}
	bx	lr
.L6:
	.align	2
.L5:
	.word	.LC0
	.word	.LC1
	.word	header_size
	.word	.LC2
	.word	.LC3
	.size	main, .-main
	.align	2
	.global	pwlog2
	.type	pwlog2, %function
pwlog2:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #15
	bgt	.L8
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-12]
	b	.L9
.L8:
	ldr	r3, [fp, #-8]
	cmp	r3, #255
	bgt	.L10
	ldr	r3, [fp, #-8]
	mov	r3, r3, asr #1
	add	r3, r3, #8
	str	r3, [fp, #-12]
	b	.L9
.L10:
	ldr	r2, [fp, #-8]
	mov	r3, #4080
	add	r3, r3, #15
	cmp	r2, r3
	bgt	.L11
	ldr	r3, [fp, #-8]
	mov	r3, r3, asr #3
	add	r3, r3, #128
	str	r3, [fp, #-12]
	b	.L9
.L11:
	ldr	r2, [fp, #-8]
	mov	r3, #65536
	sub	r3, r3, #1
	cmp	r2, r3
	bgt	.L12
	ldr	r3, [fp, #-8]
	mov	r3, r3, asr #6
	add	r3, r3, #512
	str	r3, [fp, #-12]
	b	.L9
.L12:
	mvn	r3, #0
	str	r3, [fp, #-12]
.L9:
	ldr	r3, [fp, #-12]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	pwlog2, .-pwlog2
	.align	2
	.global	inv_pwlog2
	.type	inv_pwlog2, %function
inv_pwlog2:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #12
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #15
	bgt	.L15
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-12]
	b	.L16
.L15:
	ldr	r3, [fp, #-8]
	cmp	r3, #135
	bgt	.L17
	ldr	r3, [fp, #-8]
	sub	r3, r3, #8
	mov	r3, r3, asl #1
	str	r3, [fp, #-12]
	b	.L16
.L17:
	ldr	r2, [fp, #-8]
	mov	r3, #636
	add	r3, r3, #3
	cmp	r2, r3
	bgt	.L18
	ldr	r3, [fp, #-8]
	sub	r3, r3, #128
	mov	r3, r3, asl #3
	str	r3, [fp, #-12]
	b	.L16
.L18:
	ldr	r2, [fp, #-8]
	mov	r3, #1020
	add	r3, r3, #3
	cmp	r2, r3
	bgt	.L19
	ldr	r3, [fp, #-8]
	sub	r3, r3, #512
	mov	r3, r3, asl #6
	str	r3, [fp, #-12]
	b	.L16
.L19:
	mvn	r3, #0
	str	r3, [fp, #-12]
.L16:
	ldr	r3, [fp, #-12]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	inv_pwlog2, .-inv_pwlog2
	.align	2
	.global	compress_buffer
	.type	compress_buffer, %function
compress_buffer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #52
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	str	r2, [fp, #-56]
	ldr	r3, [fp, #-56]
	sub	r3, r3, #1
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-56]
	and	r3, r3, #1
	cmp	r3, #0
	bne	.L26
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-48]
	add	r3, r3, r2
	ldrh	r3, [r3, #0]	@ movhi
	strh	r3, [fp, #-30]	@ movhi
	mov	r3, #0
	str	r3, [fp, #-28]
	ldrsh	r3, [fp, #-30]
	cmp	r3, #0
	bge	.L23
	ldrh	r3, [fp, #-30]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-30]	@ movhi
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
.L23:
	ldr	r3, [fp, #-28]
	cmp	r3, #0
	beq	.L24
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-52]
	add	r4, r3, r2
	ldrsh	r3, [fp, #-30]
	mov	r0, r3
	bl	pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r4, #0]	@ movhi
	b	.L25
.L24:
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-52]
	add	r4, r3, r2
	ldrsh	r3, [fp, #-30]
	mov	r0, r3
	bl	pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r4, #0]	@ movhi
.L25:
	ldr	r3, [fp, #-44]
	sub	r3, r3, #1
	str	r3, [fp, #-44]
	b	.L26
.L33:
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-48]
	add	r3, r3, r2
	ldrh	r3, [r3, #0]	@ movhi
	strh	r3, [fp, #-24]	@ movhi
	ldr	r3, [fp, #-44]
	rsb	r3, r3, #1
	mov	r3, r3, asl #1
	rsb	r2, r3, #0
	ldr	r3, [fp, #-48]
	add	r3, r3, r2
	ldrh	r3, [r3, #0]	@ movhi
	strh	r3, [fp, #-22]	@ movhi
	mov	r3, #0
	str	r3, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-16]
	ldrsh	r3, [fp, #-24]
	cmp	r3, #0
	bge	.L27
	ldrh	r3, [fp, #-24]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-24]	@ movhi
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L27:
	ldrsh	r3, [fp, #-22]
	cmp	r3, #0
	bge	.L28
	ldrh	r3, [fp, #-22]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-22]	@ movhi
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L28:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L29
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-52]
	add	r4, r3, r2
	ldrsh	r3, [fp, #-24]
	mov	r0, r3
	bl	pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r4, #0]	@ movhi
	b	.L30
.L29:
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-52]
	add	r4, r3, r2
	ldrsh	r3, [fp, #-24]
	mov	r0, r3
	bl	pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r4, #0]	@ movhi
.L30:
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L31
	ldr	r3, [fp, #-44]
	rsb	r3, r3, #1
	mov	r3, r3, asl #1
	rsb	r2, r3, #0
	ldr	r3, [fp, #-52]
	add	r4, r3, r2
	ldrsh	r3, [fp, #-22]
	mov	r0, r3
	bl	pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r4, #0]	@ movhi
	b	.L32
.L31:
	ldr	r3, [fp, #-44]
	rsb	r3, r3, #1
	mov	r3, r3, asl #1
	rsb	r2, r3, #0
	ldr	r3, [fp, #-52]
	add	r4, r3, r2
	ldrsh	r3, [fp, #-22]
	mov	r0, r3
	bl	pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r4, #0]	@ movhi
.L32:
	ldr	r3, [fp, #-44]
	sub	r3, r3, #2
	str	r3, [fp, #-44]
.L26:
	ldr	r3, [fp, #-44]
	cmp	r3, #0
	bne	.L33
	ldr	r3, [fp, #-48]
	ldrh	r3, [r3, #0]	@ movhi
	strh	r3, [fp, #-38]	@ movhi
	mov	r3, #0
	str	r3, [fp, #-36]
	ldrsh	r3, [fp, #-38]
	cmp	r3, #0
	bge	.L34
	ldrh	r3, [fp, #-38]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-38]	@ movhi
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L34:
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	beq	.L35
	ldrsh	r3, [fp, #-38]
	mov	r0, r3
	bl	pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, [fp, #-52]
	strh	r2, [r3, #0]	@ movhi
	b	.L37
.L35:
	ldrsh	r3, [fp, #-38]
	mov	r0, r3
	bl	pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, [fp, #-52]
	strh	r2, [r3, #0]	@ movhi
.L37:
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	compress_buffer, .-compress_buffer
	.align	2
	.global	decompress_buffer
	.type	decompress_buffer, %function
decompress_buffer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #52
	str	r0, [fp, #-48]
	str	r1, [fp, #-52]
	str	r2, [fp, #-56]
	ldr	r3, [fp, #-56]
	sub	r3, r3, #1
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-56]
	and	r3, r3, #1
	cmp	r3, #0
	bne	.L43
	ldr	r3, [fp, #-48]
	ldrh	r3, [r3, #0]	@ movhi
	strh	r3, [fp, #-30]	@ movhi
	mov	r3, #0
	str	r3, [fp, #-28]
	ldrsh	r3, [fp, #-30]
	cmp	r3, #0
	bge	.L40
	ldrh	r3, [fp, #-30]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-30]	@ movhi
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
.L40:
	ldr	r3, [fp, #-28]
	cmp	r3, #0
	beq	.L41
	ldrsh	r3, [fp, #-30]
	mov	r0, r3
	bl	inv_pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, [fp, #-52]
	strh	r2, [r3, #0]	@ movhi
	b	.L42
.L41:
	ldrsh	r3, [fp, #-30]
	mov	r0, r3
	bl	inv_pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, [fp, #-52]
	strh	r2, [r3, #0]	@ movhi
.L42:
	ldr	r3, [fp, #-44]
	sub	r3, r3, #1
	str	r3, [fp, #-44]
	b	.L43
.L48:
	mov	r3, #0
	str	r3, [fp, #-24]
	mov	r3, #0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-48]
	add	r3, r3, r2
	ldrh	r3, [r3, #0]	@ movhi
	strh	r3, [fp, #-16]	@ movhi
	ldr	r3, [fp, #-44]
	rsb	r3, r3, #1
	mov	r3, r3, asl #1
	rsb	r2, r3, #0
	ldr	r3, [fp, #-48]
	add	r3, r3, r2
	ldrh	r3, [r3, #0]	@ movhi
	strh	r3, [fp, #-14]	@ movhi
	ldrsh	r3, [fp, #-16]
	cmp	r3, #0
	bge	.L44
	ldrh	r3, [fp, #-16]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-16]	@ movhi
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L44:
	ldrsh	r3, [fp, #-14]
	cmp	r3, #0
	bge	.L45
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L45:
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-52]
	add	r4, r3, r2
	ldrsh	r3, [fp, #-16]
	mov	r0, r3
	bl	inv_pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r4, #0]	@ movhi
	ldr	r3, [fp, #-44]
	rsb	r3, r3, #1
	mov	r3, r3, asl #1
	rsb	r2, r3, #0
	ldr	r3, [fp, #-52]
	add	r4, r3, r2
	ldrsh	r3, [fp, #-14]
	mov	r0, r3
	bl	inv_pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r4, #0]	@ movhi
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	beq	.L46
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-52]
	add	r1, r3, r2
	ldr	r3, [fp, #-44]
	mov	r2, r3, asl #1
	ldr	r3, [fp, #-52]
	add	r3, r3, r2
	ldrh	r3, [r3, #0]
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r1, #0]	@ movhi
.L46:
	ldr	r3, [fp, #-20]
	cmp	r3, #0
	beq	.L47
	ldr	r3, [fp, #-44]
	rsb	r3, r3, #1
	mov	r3, r3, asl #1
	rsb	r2, r3, #0
	ldr	r3, [fp, #-52]
	add	r1, r3, r2
	ldr	r3, [fp, #-44]
	rsb	r3, r3, #1
	mov	r3, r3, asl #1
	rsb	r2, r3, #0
	ldr	r3, [fp, #-52]
	add	r3, r3, r2
	ldrh	r3, [r3, #0]
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	strh	r3, [r1, #0]	@ movhi
.L47:
	ldr	r3, [fp, #-44]
	sub	r3, r3, #2
	str	r3, [fp, #-44]
.L43:
	ldr	r3, [fp, #-44]
	cmp	r3, #0
	bne	.L48
	ldr	r3, [fp, #-48]
	ldrh	r3, [r3, #0]	@ movhi
	strh	r3, [fp, #-38]	@ movhi
	mov	r3, #0
	str	r3, [fp, #-36]
	ldrsh	r3, [fp, #-38]
	cmp	r3, #0
	bge	.L49
	ldrh	r3, [fp, #-38]	@ movhi
	rsb	r3, r3, #0
	strh	r3, [fp, #-38]	@ movhi
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L49:
	ldr	r3, [fp, #-36]
	cmp	r3, #0
	beq	.L50
	ldrsh	r3, [fp, #-38]
	mov	r0, r3
	bl	inv_pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, [fp, #-52]
	strh	r2, [r3, #0]	@ movhi
	b	.L52
.L50:
	ldrsh	r3, [fp, #-38]
	mov	r0, r3
	bl	inv_pwlog2
	mov	r3, r0
	mov	r3, r3, asl #16
	mov	r2, r3, lsr #16
	ldr	r3, [fp, #-52]
	strh	r2, [r3, #0]	@ movhi
.L52:
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, lr}
	bx	lr
	.size	decompress_buffer, .-decompress_buffer
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
