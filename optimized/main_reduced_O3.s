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
	.code	16
	.file	"main.c"
	.text
	.align	2
	.global	pwlog2
	.code	16
	.thumb_func
	.type	pwlog2, %function
pwlog2:
	push	{lr}
	cmp	r0, #15
	ble	.L2
	cmp	r0, #255
	ble	.L8
	ldr	r3, .L10
	cmp	r0, r3
	bgt	.L4
	asr	r3, r0, #3
	mov	r0, r3
	add	r0, r0, #128
.L2:
	@ sp needed for prologue
	pop	{r1}
	bx	r1
.L8:
	asr	r3, r0, #1
	mov	r0, r3
	add	r0, r0, #8
	b	.L2
.L4:
	ldr	r3, .L10+4
	cmp	r0, r3
	bgt	.L9
	mov	r2, #128
	asr	r3, r0, #6
	lsl	r2, r2, #2
	add	r0, r3, r2
	b	.L2
.L9:
	mov	r0, #1
	neg	r0, r0
	b	.L2
.L11:
	.align	2
.L10:
	.word	4095
	.word	65535
	.size	pwlog2, .-pwlog2
	.align	2
	.global	inv_pwlog2
	.code	16
	.thumb_func
	.type	inv_pwlog2, %function
inv_pwlog2:
	push	{lr}
	cmp	r0, #15
	ble	.L13
	cmp	r0, #135
	ble	.L18
	ldr	r3, .L20
	cmp	r0, r3
	bgt	.L15
	mov	r3, r0
	sub	r3, r3, #128
	lsl	r0, r3, #3
.L13:
	@ sp needed for prologue
	pop	{r1}
	bx	r1
.L18:
	mov	r3, r0
	sub	r3, r3, #8
	lsl	r0, r3, #1
	b	.L13
.L15:
	ldr	r3, .L20+4
	cmp	r0, r3
	bgt	.L19
	ldr	r2, .L20+8
	add	r3, r0, r2
	lsl	r0, r3, #6
	b	.L13
.L19:
	mov	r0, #1
	neg	r0, r0
	b	.L13
.L21:
	.align	2
.L20:
	.word	639
	.word	1023
	.word	-512
	.size	inv_pwlog2, .-inv_pwlog2
	.align	2
	.global	decompress_buffer
	.code	16
	.thumb_func
	.type	decompress_buffer, %function
decompress_buffer:
	push	{r4, r5, r6, r7, lr}
	mov	r7, fp
	mov	r6, sl
	mov	r5, r9
	mov	r4, r8
	push	{r4, r5, r6, r7}
	mov	r8, r0
	mov	sl, r1
	sub	r6, r2, #1
	lsl	r1, r2, #31
	bmi	.L23
	ldrh	r4, [r0]
	lsl	r3, r4, #16
	asr	r2, r3, #16
	cmp	r2, #0
	bge	.LCB123
	b	.L66	@long jump
.LCB123:
	cmp	r2, #15
	bgt	.LCB125
	b	.L67	@long jump
.LCB125:
	cmp	r2, #135
	bgt	.LCB127
	b	.L68	@long jump
.LCB127:
	ldr	r3, .L85
	cmp	r2, r3
	ble	.LCB130
	b	.L34	@long jump
.LCB130:
	mov	r3, r2
	sub	r3, r3, #128
	lsl	r3, r3, #19
	lsr	r3, r3, #16
.L28:
	mov	r1, sl
	strh	r3, [r1]
	sub	r6, r6, #1
.L23:
	cmp	r6, #0
	beq	.L36
	lsl	r2, r6, #1
	mov	r3, r8
	add	r5, r3, r2
	sub	r3, r6, #1
	lsl	r3, r3, #1
	mov	r1, sl
	mov	r7, r8
	add	r0, r1, r3
	add	r4, r7, r3
	add	r1, r1, r2
	ldr	r3, .L85+4
	ldr	r2, .L85
	mov	fp, r3
	mov	r9, r2
	b	.L51
.L39:
	cmp	r3, #135
	ble	.L69
	cmp	r3, r9
	ble	.LCB168
	b	.L42	@long jump
.LCB168:
	sub	r3, r3, #128
	lsl	r3, r3, #19
	lsr	r3, r3, #16
.L40:
	lsl	r2, r7, #16
	strh	r3, [r1]
	asr	r3, r2, #16
	cmp	r3, #15
	ble	.L70
.L44:
	cmp	r3, #135
	ble	.L71
	cmp	r3, r9
	ble	.LCB183
	b	.L47	@long jump
.LCB183:
	sub	r3, r3, #128
	lsl	r3, r3, #19
	lsr	r3, r3, #16
.L45:
	strh	r3, [r0]
	mov	r3, ip
	cmp	r3, #0
	beq	.L49
	ldrh	r3, [r1]
	neg	r3, r3
	strh	r3, [r1]
.L49:
	cmp	r2, #0
	bge	.L50
	ldrh	r3, [r0]
	neg	r3, r3
	strh	r3, [r0]
.L50:
	sub	r6, r6, #2
	sub	r5, r5, #4
	sub	r4, r4, #4
	sub	r0, r0, #4
	sub	r1, r1, #4
	cmp	r6, #0
	beq	.L36
.L51:
	ldrh	r2, [r5]
	lsl	r3, r2, #16
	ldrh	r7, [r4]
	cmp	r3, #0
	blt	.L37
	mov	r2, #0
	mov	ip, r2
.L38:
	asr	r3, r3, #16
	cmp	r3, #15
	bgt	.L39
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	lsl	r2, r7, #16
	strh	r3, [r1]
	asr	r3, r2, #16
	cmp	r3, #15
	bgt	.L44
.L70:
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L45
.L37:
	neg	r3, r2
	mov	r2, #1
	mov	ip, r2
	lsl	r3, r3, #16
	b	.L38
.L69:
	sub	r3, r3, #8
	lsl	r3, r3, #17
	lsr	r3, r3, #16
	b	.L40
.L71:
	sub	r3, r3, #8
	lsl	r3, r3, #17
	lsr	r3, r3, #16
	b	.L45
.L36:
	mov	r7, r8
	ldrh	r0, [r7]
	lsl	r3, r0, #16
	asr	r2, r3, #16
	cmp	r2, #0
	blt	.L72
	cmp	r2, #15
	ble	.L73
	cmp	r2, #135
	ble	.L74
	ldr	r3, .L85
	cmp	r2, r3
	bgt	.L62
	mov	r3, r2
	sub	r3, r3, #128
	lsl	r3, r3, #19
	lsr	r3, r3, #16
	b	.L56
.L73:
	lsl	r3, r2, #16
	lsr	r3, r3, #16
.L56:
	mov	r1, sl
	strh	r3, [r1]
.L64:
	@ sp needed for prologue
	pop	{r2, r3, r4, r5}
	mov	r8, r2
	mov	r9, r3
	mov	sl, r4
	mov	fp, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L72:
	neg	r3, r0
	lsl	r3, r3, #16
	asr	r0, r3, #16
	cmp	r0, #15
	ble	.L75
	cmp	r0, #135
	ble	.L76
	ldr	r3, .L85
	cmp	r0, r3
	bgt	.L58
	mov	r3, r0
	sub	r3, r3, #128
	lsl	r3, r3, #19
	neg	r3, r3
	lsr	r0, r3, #16
	b	.L54
.L67:
	lsl	r3, r2, #16
	lsr	r3, r3, #16
	b	.L28
.L66:
	neg	r3, r4
	lsl	r3, r3, #16
	asr	r2, r3, #16
	cmp	r2, #15
	ble	.L77
	cmp	r2, #135
	ble	.L78
	ldr	r3, .L85
	cmp	r2, r3
	bgt	.L30
	mov	r3, r2
	sub	r3, r3, #128
	lsl	r3, r3, #19
	neg	r3, r3
	lsr	r3, r3, #16
	b	.L28
.L75:
	neg	r3, r0
	lsl	r3, r3, #16
	lsr	r0, r3, #16
.L54:
	mov	r2, sl
	strh	r0, [r2]
	b	.L64
.L74:
	mov	r3, r2
	sub	r3, r3, #8
	lsl	r3, r3, #17
	lsr	r3, r3, #16
	b	.L56
.L76:
	mov	r3, r0
	sub	r3, r3, #8
	lsl	r3, r3, #17
	neg	r3, r3
	lsr	r0, r3, #16
	b	.L54
.L42:
	cmp	r3, fp
	bgt	.L79
	ldr	r2, .L85+8
	add	r3, r3, r2
	lsl	r3, r3, #22
	lsr	r3, r3, #16
	b	.L40
.L47:
	cmp	r3, fp
	bgt	.L80
	ldr	r7, .L85+8
	add	r3, r3, r7
	lsl	r3, r3, #22
	lsr	r3, r3, #16
	b	.L45
.L77:
	neg	r3, r2
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L28
.L68:
	mov	r3, r2
	sub	r3, r3, #8
	lsl	r3, r3, #17
	lsr	r3, r3, #16
	b	.L28
.L78:
	mov	r3, r2
	sub	r3, r3, #8
	lsl	r3, r3, #17
	neg	r3, r3
	lsr	r3, r3, #16
	b	.L28
.L79:
	ldr	r3, .L85+12
	b	.L40
.L80:
	ldr	r3, .L85+12
	b	.L45
.L62:
	ldr	r3, .L85+4
	cmp	r2, r3
	bgt	.L81
	ldr	r7, .L85+8
	add	r3, r2, r7
	lsl	r3, r3, #22
	lsr	r3, r3, #16
	b	.L56
.L58:
	ldr	r3, .L85+4
	cmp	r0, r3
	bgt	.L82
	ldr	r1, .L85+8
	add	r3, r0, r1
	lsl	r3, r3, #22
	neg	r3, r3
	lsr	r0, r3, #16
	b	.L54
.L34:
	ldr	r3, .L85+4
	cmp	r2, r3
	bgt	.L83
	ldr	r7, .L85+8
	add	r3, r2, r7
	lsl	r3, r3, #22
	lsr	r3, r3, #16
	b	.L28
.L30:
	ldr	r3, .L85+4
	cmp	r2, r3
	bgt	.L84
	ldr	r7, .L85+8
	add	r3, r2, r7
	lsl	r3, r3, #22
	neg	r3, r3
	lsr	r3, r3, #16
	b	.L28
.L81:
	ldr	r3, .L85+12
	b	.L56
.L82:
	mov	r0, #1
	b	.L54
.L83:
	ldr	r3, .L85+12
	b	.L28
.L84:
	mov	r3, #1
	b	.L28
.L86:
	.align	2
.L85:
	.word	639
	.word	1023
	.word	-512
	.word	65535
	.size	decompress_buffer, .-decompress_buffer
	.align	2
	.global	compress_buffer
	.code	16
	.thumb_func
	.type	compress_buffer, %function
compress_buffer:
	push	{r4, r5, r6, r7, lr}
	mov	r7, fp
	mov	r6, sl
	mov	r5, r9
	mov	r4, r8
	push	{r4, r5, r6, r7}
	mov	sl, r0
	mov	fp, r1
	sub	r5, r2, #1
	lsl	r1, r2, #31
	bmi	.L88
	lsl	r6, r5, #1
	ldrh	r3, [r0, r6]
	lsl	r4, r3, #16
	asr	r2, r4, #16
	cmp	r2, #0
	bge	.LCB531
	b	.L147	@long jump
.LCB531:
	cmp	r2, #15
	bgt	.LCB533
	b	.L148	@long jump
.LCB533:
	cmp	r2, #255
	bgt	.LCB535
	b	.L149	@long jump
.LCB535:
	ldr	r3, .L163
	cmp	r2, r3
	ble	.LCB538
	b	.L99	@long jump
.LCB538:
	asr	r3, r4, #19
	add	r3, r3, #128
	lsl	r3, r3, #16
	lsr	r3, r3, #16
.L93:
	mov	r1, fp
	strh	r3, [r1, r6]
	sub	r5, r5, #1
.L88:
	cmp	r5, #0
	bne	.LCB551
	b	.L100	@long jump
.LCB551:
	lsl	r2, r5, #1
	mov	r1, fp
	sub	r3, r5, #1
	mov	r8, r2
	lsl	r3, r3, #1
	add	r6, r1, r2
	ldr	r2, .L163
	mov	ip, r3
	add	r8, r8, sl
	add	ip, ip, sl
	add	r7, r1, r3
	mov	r9, r2
	b	.L129
.L152:
	asr	r3, r2, #16
	cmp	r3, #15
	ble	.L143
	cmp	r3, #255
	ble	.L150
	cmp	r3, r9
	bgt	.L110
	asr	r3, r2, #19
	add	r3, r3, #128
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
.L113:
	strh	r3, [r6]
	cmp	r1, #0
	beq	.L117
.L154:
	asr	r3, r4, #16
	cmp	r3, #15
	ble	.L145
	cmp	r3, #255
	ble	.L151
	cmp	r3, r9
	bgt	.L122
	asr	r3, r4, #19
	add	r3, r3, #128
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
.L125:
	strh	r3, [r7]
	mov	r3, #4
	neg	r3, r3
	sub	r5, r5, #2
	add	r8, r8, r3
	add	ip, ip, r3
	add	r7, r7, r3
	add	r6, r6, r3
	cmp	r5, #0
	beq	.L100
.L129:
	mov	r1, r8
	ldrh	r3, [r1]
	mov	r2, ip
	ldrh	r1, [r2]
	lsl	r2, r3, #16
	cmp	r2, #0
	blt	.L101
	mov	r0, #0
.L102:
	lsl	r4, r1, #16
	cmp	r4, #0
	blt	.L103
	mov	r1, #0
.L104:
	cmp	r0, #0
	bne	.L152
	asr	r3, r2, #16
	cmp	r3, #15
	ble	.L144
	cmp	r3, #255
	ble	.L153
	cmp	r3, r9
	bgt	.L116
	asr	r3, r2, #19
	add	r3, r3, #128
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	strh	r3, [r6]
	cmp	r1, #0
	bne	.L154
.L117:
	asr	r3, r4, #16
	cmp	r3, #15
	ble	.L146
	cmp	r3, #255
	ble	.L155
	cmp	r3, r9
	bgt	.L128
	asr	r3, r4, #19
	add	r3, r3, #128
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L125
.L103:
	neg	r3, r1
	lsl	r4, r3, #16
	mov	r1, #1
	b	.L104
.L101:
	neg	r3, r3
	mov	r0, #1
	lsl	r2, r3, #16
	b	.L102
.L122:
	mov	r1, #128
	asr	r3, r4, #22
	lsl	r1, r1, #2
	add	r3, r3, r1
.L145:
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L125
.L110:
	asr	r3, r2, #22
	mov	r2, #128
	lsl	r2, r2, #2
	add	r3, r3, r2
.L143:
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L113
.L116:
	asr	r3, r2, #22
	mov	r2, #128
	lsl	r2, r2, #2
	add	r3, r3, r2
.L144:
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L113
.L128:
	mov	r2, #128
	asr	r3, r4, #22
	lsl	r2, r2, #2
	add	r3, r3, r2
.L146:
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L125
.L155:
	asr	r3, r4, #17
	add	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L125
.L150:
	asr	r3, r2, #17
	add	r3, r3, #8
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L113
.L153:
	asr	r3, r2, #17
	add	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L113
.L151:
	asr	r3, r4, #17
	add	r3, r3, #8
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L125
.L100:
	mov	r1, sl
	ldrh	r0, [r1]
	lsl	r4, r0, #16
	asr	r2, r4, #16
	cmp	r2, #0
	blt	.L156
	cmp	r2, #15
	ble	.L157
	cmp	r2, #255
	ble	.L158
	ldr	r3, .L163
	cmp	r2, r3
	bgt	.L140
	asr	r3, r4, #19
	add	r3, r3, #128
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L134
.L157:
	lsl	r3, r2, #16
	lsr	r3, r3, #16
.L134:
	mov	r2, fp
	strh	r3, [r2]
.L141:
	@ sp needed for prologue
	pop	{r2, r3, r4, r5}
	mov	r8, r2
	mov	r9, r3
	mov	sl, r4
	mov	fp, r5
	pop	{r4, r5, r6, r7}
	pop	{r0}
	bx	r0
.L156:
	neg	r3, r0
	lsl	r0, r3, #16
	asr	r2, r0, #16
	cmp	r2, #15
	ble	.L159
	cmp	r2, #255
	ble	.L160
	ldr	r3, .L163
	cmp	r2, r3
	bgt	.L137
	asr	r3, r0, #19
	add	r3, r3, #128
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r0, r3, #16
	b	.L132
.L148:
	lsl	r3, r2, #16
	lsr	r3, r3, #16
	b	.L93
.L147:
	neg	r3, r3
	lsl	r4, r3, #16
	asr	r2, r4, #16
	cmp	r2, #15
	ble	.L161
	cmp	r2, #255
	ble	.L162
	ldr	r3, .L163
	cmp	r2, r3
	bgt	.L96
	asr	r3, r4, #19
	add	r3, r3, #128
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L93
.L159:
	neg	r3, r2
	lsl	r3, r3, #16
	lsr	r0, r3, #16
.L132:
	mov	r3, fp
	strh	r0, [r3]
	b	.L141
.L158:
	asr	r3, r4, #17
	add	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L134
.L160:
	asr	r3, r0, #17
	add	r3, r3, #8
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r0, r3, #16
	b	.L132
.L161:
	neg	r3, r2
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L93
.L149:
	asr	r3, r4, #17
	add	r3, r3, #8
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L93
.L162:
	asr	r3, r4, #17
	add	r3, r3, #8
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L93
.L140:
	mov	r1, #128
	asr	r3, r4, #22
	lsl	r1, r1, #2
	add	r3, r3, r1
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L134
.L137:
	mov	r2, #128
	asr	r3, r0, #22
	lsl	r2, r2, #2
	add	r3, r3, r2
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r0, r3, #16
	b	.L132
.L96:
	mov	r2, #128
	asr	r3, r4, #22
	lsl	r2, r2, #2
	add	r3, r3, r2
	neg	r3, r3
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L93
.L99:
	mov	r2, #128
	asr	r3, r4, #22
	lsl	r2, r2, #2
	add	r3, r3, r2
	lsl	r3, r3, #16
	lsr	r3, r3, #16
	b	.L93
.L164:
	.align	2
.L163:
	.word	4095
	.size	compress_buffer, .-compress_buffer
	.align	2
	.global	main
	.code	16
	.thumb_func
	.type	main, %function
main:
	push	{r3, r4, r5, r6, r7, lr}
	mov	r7, fp
	mov	r6, sl
	mov	r5, r9
	mov	r4, r8
	push	{r4, r5, r6, r7}
	ldr	r1, .L170
	ldr	r0, .L170+4
	bl	fopen
	mov	r1, #0
	mov	r4, r0
	mov	r2, #2
	bl	fseek
	mov	r0, r4
	bl	ftell
	mov	r8, r0
	mov	r5, r8
	add	r5, r5, #1
	mov	r0, r4
	bl	rewind
	mov	r0, r5
	bl	malloc
	mov	r2, #1
	mov	r3, r4
	mov	r1, r8
	mov	sl, r0
	bl	fread
	mov	r0, r4
	bl	fclose
	ldr	r6, .L170+8
	ldr	r0, [r6]
	mov	fp, r0
	sub	r0, r5, r0
	bl	malloc
	mov	r7, r0
	ldr	r0, [r6]
	sub	r0, r5, r0
	bl	malloc
	ldr	r3, [r6]
	sub	r5, r5, r3
	mov	r9, r0
	mov	r0, r5
	bl	malloc
	ldr	r3, [r6]
	mov	r2, r8
	sub	r4, r2, r3
	add	fp, fp, sl
	mov	r5, r0
	cmp	r4, #0
	ble	.L166
	mov	r0, fp
	mov	r1, #0
.L167:
	ldrb	r3, [r0, #1]
	ldrb	r2, [r0]
	lsl	r3, r3, #8
	orr	r3, r3, r2
	strh	r3, [r7, r1]
	add	r1, r1, #2
	add	r0, r0, #2
	cmp	r4, r1
	bgt	.L167
.L166:
	lsr	r2, r4, #31
	add	r2, r2, r4
	mov	r0, r7
	mov	r1, r9
	asr	r2, r2, #1
	bl	compress_buffer
	ldr	r3, [r6]
	mov	r2, r8
	sub	r3, r2, r3
	lsr	r2, r3, #31
	add	r2, r2, r3
	mov	r0, r9
	mov	r1, r5
	asr	r2, r2, #1
	bl	decompress_buffer
	ldr	r1, .L170+12
	ldr	r0, .L170+16
	bl	fopen
	mov	r4, r0
	ldr	r2, [r6]
	mov	r0, sl
	mov	r3, r4
	mov	r1, #1
	bl	fwrite
	ldr	r3, [r6]
	mov	r2, r8
	sub	r3, r2, r3
	lsr	r2, r3, #31
	add	r2, r2, r3
	asr	r2, r2, #1
	mov	r1, #2
	mov	r3, r4
	mov	r0, r5
	bl	fwrite
	mov	r0, r5
	bl	free
	mov	r0, r9
	bl	free
	mov	r0, r7
	bl	free
	mov	r0, sl
	bl	free
	mov	r0, r4
	bl	fclose
	@ sp needed for prologue
	mov	r0, #0
	pop	{r2, r3, r4, r5}
	mov	r8, r2
	mov	r9, r3
	mov	sl, r4
	mov	fp, r5
	pop	{r3, r4, r5, r6, r7}
	pop	{r1}
	bx	r1
.L171:
	.align	2
.L170:
	.word	.LC6
	.word	.LC4
	.word	.LANCHOR0
	.word	.LC11
	.word	.LC9
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
.LC4:
	.ascii	"../africa-toto.wav\000"
	.space	1
.LC6:
	.ascii	"rb\000"
	.space	1
.LC9:
	.ascii	"out.wav\000"
.LC11:
	.ascii	"wb\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
