.L33:
;	int16_t x1 = src[i];
ldr	r3, [fp, #-44]
nop;
mov	r2, r3, asl #1
ldr	r3, [fp, #-48]
add	r3, r3, r2
ldrh	r3, [r3, #0]	@ movhi
strh	r3, [fp, #-24]	@ movhi
nop;
;int sign1 = 0;
mov	r3, #0
str	r3, [fp, #-20]
;if (x1 & 0x8000)
;{
  ;x1 = -x1;
  ;++sign1;
;}
ldrsh	r3, [fp, #-24]
cmp	r3, #0
bge	.L27
ldrh	r3, [fp, #-24]	@ movhi
rsb	r3, r3, #0
strh	r3, [fp, #-24]	@ movhi
ldr	r3, [fp, #-20]
add	r3, r3, #1
str	r3, [fp, #-20]
b .L28
.L27:
nop
nop
nop
nop
nop
nop
nop
nop
nop
.L28:
;if (sign1)
; 	dst[i] = -pwlog2(x1);		
;else
;	  dst[i] = pwlog2(x1);
ldr	r3, [fp, #-20]
cmp	r3, #0
beq	.L29
ldr	r3, [fp, #-44]
nop
mov	r2, r3, asl #1
nop
ldr	r3, [fp, #-52]
add	r7, r3, r2
ldrsh	r3, [fp, #-24]
mov	r0, r3
bl	pwlog2
mov	r3, r0
mov	r3, r3, asl #16
mov	r3, r3, lsr #16
rsb	r3, r3, #0
mov	r3, r3, asl #16
mov	r3, r3, lsr #16
strh	r3, [r7, #0]	@ movhi
b	.L39
.L29:
ldr	r3, [fp, #-44]
nop
mov	r2, r3, asl #1
nop
ldr	r3, [fp, #-52]
add	r7, r3, r2
ldrsh	r3, [fp, #-24]
mov	r0, r3
bl	pwlog2
mov	r3, r0
mov	r3, r3, asl #16
mov	r3, r3, lsr #16
strh	r3, [r7, #0]	@ movhi
.L39:
; for loop initializers etc
ldr	r3, [fp, #-44]
sub	r3, r3, #2
str	r3, [fp, #-44]
ldr	r3, [fp, #-44]
cmp	r3, #0
bne	.L33

85 - 17 = 68 cyles 