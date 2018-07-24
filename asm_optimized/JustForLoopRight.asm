.L53:
;int16_t x2 = src[i - 1];
nop; use the shared register r3
rsb	r4, r3, #1
mov	r4, r4, asl #1
rsb	r5, r4, #0
ldr	r4, [fp, #-48]
add	r4, r4, r5
ldrh	r4, [r4, #0]	@ movhi
strh	r4, [fp, #-22]	@ movhi
;int sign2 = 0;
mov	r4, #0
str	r4, [fp, #-16]
;if (x2 & 0x8000)
;{
  ;	x2 = -x2;
  ;	++sign2;
;}
ldrsh	r4, [fp, #-22]
cmp	r4, #0
bge	.L47
ldrh	r4, [fp, #-22]	@ movhi
rsb	r4, r4, #0
strh	r4, [fp, #-22]	@ movhi
ldr	r4, [fp, #-16]
add	r4, r4, #1
str	r4, [fp, #-16]
b .L48
.L47:
nop
nop
nop
nop
nop
nop
nop
nop
nop
.L48:
;if (sign2)
; 	dst[i - 1] = -pwlog2(x2);
;else
;	  dst[i - 1] = pwlog2(x2);
ldr	r4, [fp, #-16]
cmp	r4, #0
beq	.L51
ldr	r4, [fp, #-44]
rsb	r4, r4, #1
mov	r4, r4, asl #1
rsb	r5, r4, #0
ldr	r4, [fp, #-52]
add	r6, r4, r5
ldrsh	r4, [fp, #-22]
mov	r0, r4
bl	pwlog2
mov	r4, r0
mov	r4, r4, asl #16
mov	r4, r4, lsr #16
rsb	r4, r4, #0
mov	r4, r4, asl #16
mov	r4, r4, lsr #16
strh	r4, [r6, #0]	@ movhi
b	.L49
.L51:
ldr	r4, [fp, #-44]
rsb	r4, r4, #1
mov	r4, r4, asl #1
rsb	r5, r4, #0
ldr	r4, [fp, #-52]
add	r6, r4, r5
ldrsh	r4, [fp, #-22]
mov	r0, r4
bl	pwlog2
mov	r4, r0
mov	r4, r4, asl #16
mov	r4, r4, lsr #16
strh	r4, [r6, #0]	@ movhi
.L49:
; for loop initializers etc
nop
nop
nop
nop
cmp	r3, #0
bne	.L53