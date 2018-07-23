	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"main.c"
	.text
	.align	2
	.global	pwlog2
	.type	pwlog2, %function
pwlog2:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #15
	bxle	lr
	cmp	r0, #255
	movle	r3, r0, asr #1
	addle	r0, r3, #8
	bxle	lr
	cmp	r0, #4096
	movlt	r3, r0, asr #3
	addlt	r0, r3, #128
	bxlt	lr
	cmp	r0, #65536
	movlt	r3, r0, asr #6
	mvnge	r0, #0
	addlt	r0, r3, #512
	bx	lr
	.size	pwlog2, .-pwlog2
	.align	2
	.global	inv_pwlog2
	.type	inv_pwlog2, %function
inv_pwlog2:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #15
	bxle	lr
	cmp	r0, #135
	suble	r3, r0, #8
	movle	r0, r3, asl #1
	bxle	lr
	cmp	r0, #640
	sublt	r3, r0, #128
	movlt	r0, r3, asl #3
	bxlt	lr
	cmp	r0, #1024
	sublt	r3, r0, #512
	mvnge	r0, #0
	movlt	r0, r3, asl #6
	bx	lr
	.size	inv_pwlog2, .-inv_pwlog2
	.align	2
	.global	decompress_buffer
	.type	decompress_buffer, %function
decompress_buffer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	tst	r2, #1
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	mov	r9, r0
	mov	fp, r1
	sub	r6, r2, #1
	bne	.L15
	ldrh	r2, [r0, #0]
	mov	r3, r2, asl #16
	movs	r3, r3, asr #16
	bmi	.L59
	cmp	r3, #15
	ble	.L58
	cmp	r3, #135
	suble	r3, r3, #8
	movle	r3, r3, asl #17
	movle	r3, r3, lsr #16
	ble	.L20
	cmp	r3, #640
	sublt	r3, r3, #128
	movlt	r3, r3, asl #19
	movlt	r3, r3, lsr #16
	bge	.L60
.L20:
	strh	r3, [fp, #0]	@ movhi
	sub	r6, r6, #1
.L15:
	cmp	r6, #0
	beq	.L28
	mov	r3, r6, asl #1
	sub	r3, r3, #2
	mov	r2, r6, asl #1
	mov	r8, #636
	mov	sl, #1020
	add	r1, fp, r3
	add	ip, fp, r2
	add	r8, r8, #3
	add	sl, sl, #3
	add	r5, r9, r2
	add	r4, r9, r3
.L43:
	ldrh	r3, [r5, #0]
	movs	r2, r3, asl #16
	rsbmi	r3, r3, #0
	movmi	r2, r3, asl #16
	mov	r3, r2, asr #16
	movpl	r7, #0
	movmi	r7, #1
	cmp	r3, #15
	movle	r3, r3, asl #16
	ldrh	r0, [r4, #0]
	movle	r2, r3, lsr #16
	ble	.L32
	cmp	r3, #135
	suble	r3, r3, #8
	movle	r3, r3, asl #17
	movle	r2, r3, lsr #16
	ble	.L32
	cmp	r3, r8
	suble	r3, r3, #128
	movle	r3, r3, asl #19
	movle	r2, r3, lsr #16
	bgt	.L61
.L32:
	mov	r0, r0, asl #16
	mov	r3, r0, asr #16
	cmp	r3, #15
	movle	r3, r3, asl #16
	strh	r2, [ip, #0]	@ movhi
	movle	r3, r3, lsr #16
	ble	.L37
	cmp	r3, #135
	suble	r3, r3, #8
	movle	r3, r3, asl #17
	movle	r3, r3, lsr #16
	ble	.L37
	cmp	r3, r8
	suble	r3, r3, #128
	movle	r3, r3, asl #19
	movle	r3, r3, lsr #16
	bgt	.L62
.L37:
	strh	r3, [r1, #0]	@ movhi
	cmp	r7, #0
	ldrneh	r3, [ip, #0]
	rsbne	r3, r3, #0
	strneh	r3, [ip, #0]	@ movhi
	cmp	r0, #0
	ldrlth	r3, [r1, #0]
	rsblt	r3, r3, #0
	strlth	r3, [r1, #0]	@ movhi
	subs	r6, r6, #2
	sub	r5, r5, #4
	sub	r4, r4, #4
	sub	r1, r1, #4
	sub	ip, ip, #4
	bne	.L43
.L28:
	ldrh	r0, [r9, #0]
	mov	r3, r0, asl #16
	movs	r3, r3, asr #16
	bmi	.L63
	cmp	r3, #15
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L48
	cmp	r3, #135
	suble	r3, r3, #8
	movle	r3, r3, asl #17
	movle	r3, r3, lsr #16
	ble	.L48
	cmp	r3, #640
	sublt	r3, r3, #128
	movlt	r3, r3, asl #19
	movlt	r3, r3, lsr #16
	bge	.L64
.L48:
	strh	r3, [fp, #0]	@ movhi
.L56:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
.L63:
	rsb	r3, r0, #0
	mov	r3, r3, asl #16
	mov	r0, r3, asr #16
	cmp	r0, #15
	rsble	r3, r0, #0
	movle	r3, r3, asl #16
	movle	r0, r3, lsr #16
	ble	.L46
	cmp	r0, #135
	movle	r3, r0, asl #1
	rsble	r3, r3, #16
	movle	r3, r3, asl #16
	movle	r0, r3, lsr #16
	ble	.L46
	cmp	r0, #640
	movlt	r3, r0, asl #3
	rsblt	r3, r3, #1024
	movlt	r3, r3, asl #16
	movlt	r0, r3, lsr #16
	bge	.L65
.L46:
	strh	r0, [fp, #0]	@ movhi
	b	.L56
.L59:
	rsb	r3, r2, #0
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	cmp	r3, #15
	rsble	r3, r3, #0
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L20
	cmp	r3, #135
	movle	r3, r3, asl #1
	rsble	r3, r3, #16
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L20
	cmp	r3, #640
	movlt	r3, r3, asl #3
	rsblt	r3, r3, #1024
	movlt	r3, r3, asl #16
	movlt	r3, r3, lsr #16
	blt	.L20
	cmp	r3, #1024
	movge	r3, #1
	bge	.L20
	mov	r3, r3, asl #6
	rsb	r3, r3, #32768
.L58:
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	b	.L20
.L61:
	cmp	r3, sl
	suble	r3, r3, #512
	movgt	r2, #65536
	movle	r3, r3, asl #22
	subgt	r2, r2, #1
	movle	r2, r3, lsr #16
	b	.L32
.L62:
	cmp	r3, sl
	suble	r3, r3, #512
	movgt	r3, #65536
	movle	r3, r3, asl #22
	subgt	r3, r3, #1
	movle	r3, r3, lsr #16
	b	.L37
.L64:
	cmp	r3, #1024
	sublt	r3, r3, #512
	movge	r3, #65536
	movlt	r3, r3, asl #22
	subge	r3, r3, #1
	movlt	r3, r3, lsr #16
	b	.L48
.L65:
	cmp	r0, #1024
	movlt	r3, r0, asl #6
	rsblt	r3, r3, #32768
	movlt	r3, r3, asl #16
	movge	r0, #1
	movlt	r0, r3, lsr #16
	strh	r0, [fp, #0]	@ movhi
	b	.L56
.L60:
	cmp	r3, #1024
	sublt	r3, r3, #512
	movge	r3, #65536
	movlt	r3, r3, asl #22
	subge	r3, r3, #1
	movlt	r3, r3, lsr #16
	b	.L20
	.size	decompress_buffer, .-decompress_buffer
	.align	2
	.global	compress_buffer
	.type	compress_buffer, %function
compress_buffer:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	tst	r2, #1
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	mov	r9, r0
	mov	fp, r1
	sub	r4, r2, #1
	bne	.L67
	mov	r5, r4, asl #1
	ldrh	ip, [r0, r5]
	mov	r2, ip, asl #16
	movs	r3, r2, asr #16
	bmi	.L130
	cmp	r3, #15
	ble	.L123
	cmp	r3, #255
	movle	r3, r2, asr #17
	addle	r3, r3, #8
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L72
	cmp	r3, #4096
	movlt	r3, r2, asr #19
	addlt	r3, r3, #128
	movlt	r3, r3, asl #16
	movlt	r3, r3, lsr #16
	bge	.L131
.L72:
	strh	r3, [fp, r5]	@ movhi
	sub	r4, r4, #1
.L67:
	cmp	r4, #0
	beq	.L79
	mov	r3, r4, asl #1
	sub	r3, r3, #2
	mov	r2, r4, asl #1
	mov	sl, #4080
	add	r8, fp, r3
	add	r7, fp, r2
	add	sl, sl, #15
	add	r6, r9, r2
	add	r5, r9, r3
	b	.L108
.L134:
	mov	r3, ip, asr #16
	cmp	r3, #15
	ble	.L124
	cmp	r3, #255
	ble	.L132
	cmp	r3, sl
	movle	r3, ip, asr #19
	addle	r3, r3, #128
	movgt	r3, ip, asr #22
	rsble	r3, r3, #0
	movgt	r3, r3, asl #16
	movle	r3, r3, asl #16
	rsbgt	r3, r3, #-33554432
	movle	r3, r3, lsr #16
	movgt	r3, r3, lsr #16
.L92:
	cmp	r2, #0
	strh	r3, [r7, #0]	@ movhi
	beq	.L96
.L135:
	mov	r3, r0, asr #16
	cmp	r3, #15
	ble	.L126
	cmp	r3, #255
	ble	.L133
	cmp	r3, sl
	movle	r3, r0, asr #19
	addle	r3, r3, #128
	movgt	r3, r0, asr #22
	rsble	r3, r3, #0
	movgt	r3, r3, asl #16
	movle	r3, r3, asl #16
	rsbgt	r3, r3, #-33554432
	movle	r3, r3, lsr #16
	movgt	r3, r3, lsr #16
.L104:
	subs	r4, r4, #2
	strh	r3, [r8, #0]	@ movhi
	sub	r6, r6, #4
	sub	r5, r5, #4
	sub	r8, r8, #4
	sub	r7, r7, #4
	beq	.L79
.L108:
	ldrh	r3, [r6, #0]
	ldrh	r2, [r5, #0]
	movs	ip, r3, asl #16
	rsbmi	r3, r3, #0
	movpl	r1, #0
	movmi	ip, r3, asl #16
	movmi	r1, #1
	movs	r0, r2, asl #16
	rsbmi	r3, r2, #0
	movpl	r2, #0
	movmi	r0, r3, asl #16
	movmi	r2, #1
	cmp	r1, #0
	bne	.L134
	mov	r3, ip, asr #16
	cmp	r3, #15
	ble	.L125
	cmp	r3, #255
	movle	r3, ip, asr #17
	addle	r3, r3, #8
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L92
	cmp	r3, sl
	movle	r3, ip, asr #19
	addle	r3, r3, #128
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L92
	mov	r3, ip, asr #22
	add	r3, r3, #512
.L125:
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	cmp	r2, #0
	strh	r3, [r7, #0]	@ movhi
	bne	.L135
.L96:
	mov	r3, r0, asr #16
	cmp	r3, #15
	ble	.L127
	cmp	r3, #255
	movle	r3, r0, asr #17
	addle	r3, r3, #8
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L104
	cmp	r3, sl
	movle	r3, r0, asr #19
	addle	r3, r3, #128
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L104
	mov	r3, r0, asr #22
	add	r3, r3, #512
.L127:
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	subs	r4, r4, #2
	strh	r3, [r8, #0]	@ movhi
	sub	r6, r6, #4
	sub	r5, r5, #4
	sub	r8, r8, #4
	sub	r7, r7, #4
	bne	.L108
.L79:
	ldrh	r0, [r9, #0]
	mov	r2, r0, asl #16
	movs	r3, r2, asr #16
	bmi	.L136
	cmp	r3, #15
	ble	.L129
	cmp	r3, #255
	movle	r3, r2, asr #17
	addle	r3, r3, #8
	movle	r3, r3, asl #16
	movle	r3, r3, lsr #16
	ble	.L113
	cmp	r3, #4096
	movlt	r3, r2, asr #19
	addlt	r3, r3, #128
	movlt	r3, r3, asl #16
	movlt	r3, r3, lsr #16
	bge	.L137
.L113:
	strh	r3, [fp, #0]	@ movhi
.L120:
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
.L132:
	mov	r3, ip, asr #17
	add	r3, r3, #8
.L124:
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	b	.L92
.L133:
	mov	r3, r0, asr #17
	add	r3, r3, #8
.L126:
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	b	.L104
.L137:
	mov	r3, r2, asr #22
	add	r3, r3, #512
.L129:
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	b	.L113
.L136:
	rsb	r3, r0, #0
	mov	r0, r3, asl #16
	mov	r3, r0, asr #16
	cmp	r3, #15
	ble	.L128
	cmp	r3, #255
	ble	.L138
	cmp	r3, #4096
	movlt	r3, r0, asr #19
	addlt	r3, r3, #128
	movge	r3, r0, asr #22
	rsblt	r3, r3, #0
	movge	r3, r3, asl #16
	movlt	r3, r3, asl #16
	rsbge	r3, r3, #-33554432
	movlt	r0, r3, lsr #16
	movge	r0, r3, lsr #16
	strh	r0, [fp, #0]	@ movhi
	b	.L120
.L138:
	mov	r3, r0, asr #17
	add	r3, r3, #8
.L128:
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r0, r3, lsr #16
	strh	r0, [fp, #0]	@ movhi
	b	.L120
.L131:
	mov	r3, r2, asr #22
	add	r3, r3, #512
.L123:
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	b	.L72
.L130:
	rsb	r3, ip, #0
	mov	r2, r3, asl #16
	mov	r3, r2, asr #16
	cmp	r3, #15
	ble	.L122
	cmp	r3, #255
	ble	.L139
	cmp	r3, #4096
	movlt	r3, r2, asr #19
	addlt	r3, r3, #128
	movge	r3, r2, asr #22
	rsblt	r3, r3, #0
	movge	r3, r3, asl #16
	movlt	r3, r3, asl #16
	rsbge	r3, r3, #-33554432
	movlt	r3, r3, lsr #16
	movge	r3, r3, lsr #16
	b	.L72
.L139:
	mov	r3, r2, asr #17
	add	r3, r3, #8
.L122:
	rsb	r3, r3, #0
	mov	r3, r3, asl #16
	mov	r3, r3, lsr #16
	b	.L72
	.size	compress_buffer, .-compress_buffer
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	ldr	r1, .L145
	ldr	r0, .L145+4
	bl	fopen
	mov	r2, #2
	mov	r4, r0
	mov	r1, #0
	bl	fseek
	mov	r0, r4
	bl	ftell
	mov	r8, r0
	add	r5, r8, #1
	mov	r0, r4
	bl	rewind
	mov	r0, r5
	bl	malloc
	ldr	r7, .L145+8
	mov	r1, r8
	mov	r2, #1
	mov	r3, r4
	mov	r9, r0
	bl	fread
	mov	r0, r4
	bl	fclose
	ldr	r3, [r7, #0]
	rsb	r0, r3, r5
	add	r4, r9, r3
	bl	malloc
	mov	r6, r0
	ldr	r0, [r7, #0]
	rsb	r0, r0, r5
	bl	malloc
	mov	sl, r0
	ldr	r0, [r7, #0]
	rsb	r0, r0, r5
	bl	malloc
	ldr	r3, [r7, #0]
	rsb	ip, r3, r8
	cmp	ip, #0
	mov	r5, r0
	ble	.L141
	mov	r0, r4
	mov	r1, #0
.L142:
	ldrb	r2, [r0, #1]	@ zero_extendqisi2
	ldrb	r3, [r4, r1]	@ zero_extendqisi2
	orr	r3, r3, r2, asl #8
	strh	r3, [r6, r1]	@ movhi
	add	r1, r1, #2
	cmp	ip, r1
	add	r0, r0, #2
	bgt	.L142
.L141:
	add	r2, ip, ip, lsr #31
	mov	r0, r6
	mov	r1, sl
	mov	r2, r2, asr #1
	bl	compress_buffer
	ldr	r2, [r7, #0]
	rsb	r2, r2, r8
	add	r2, r2, r2, lsr #31
	mov	r2, r2, asr #1
	mov	r0, sl
	mov	r1, r5
	bl	decompress_buffer
	ldr	r1, .L145+12
	ldr	r0, .L145+16
	bl	fopen
	mov	r4, r0
	ldr	r2, [r7, #0]
	mov	r3, r4
	mov	r0, r9
	mov	r1, #1
	bl	fwrite
	ldr	r2, [r7, #0]
	rsb	r2, r2, r8
	add	r2, r2, r2, lsr #31
	mov	r2, r2, asr #1
	mov	r1, #2
	mov	r3, r4
	mov	r0, r5
	bl	fwrite
	mov	r0, r5
	bl	free
	mov	r0, sl
	bl	free
	mov	r0, r6
	bl	free
	mov	r0, r9
	bl	free
	mov	r0, r4
	bl	fclose
	mov	r0, #0
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
.L146:
	.align	2
.L145:
	.word	.LC1
	.word	.LC0
	.word	.LANCHOR0
	.word	.LC3
	.word	.LC2
	.size	main, .-main
	.global	header_size
	.data
	.align	2
.LANCHOR0 = . + 0
	.type	header_size, %object
	.size	header_size, 4
header_size:
	.word	66
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"../africa-toto.wav\000"
	.space	1
.LC1:
	.ascii	"rb\000"
	.space	1
.LC2:
	.ascii	"out.wav\000"
.LC3:
	.ascii	"wb\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
