;	int16_t x1 = src[i];
ldr	r5, [fp, #-44] ; LOAD INTO R5 IN ORDER TO NOT DUPLICATE THE UNNECCESSARY LOAD BELOW
.L33:
mov	r2, r5, asl #1 ; REPLACED R3 W/ R5
ldr	r6, [fp, #-48] ; LOAD INTO R6 " " "
add	r3, r6, r2
ldrh	r3, [r3, #0]	@ movhi
strh	r3, [fp, #-24]	@ movhi
;int16_t x2 = src[i - 1];
; ---- ldr	r3, [fp, #-44] REMOVED DUPLICATE LOAD
rsb	r3, r5, #1 ; REPLACED R3 W/ R5
mov	r3, r3, asl #1
rsb	r2, r3, #0
; ---- ldr	r3, [fp, #-48] REMOVED DUPLICATE LOAD
add	r3, r6, r2
ldrh	r3, [r3, #0]	@ movhi
strh	r3, [fp, #-22]	@ movhi
;int sign1 = 0;
mov	r3, #0
str	r3, [fp, #-20]
;int sign2 = 0;
; ---- mov	r3, #0 REMOVED DUPLICATE MOV, GUARENTEED TO ALREADY CONTAIN #0
str	r3, [fp, #-16]
;// check sign bit (two's complement signed integer)
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
;if (x2 & 0x8000)
;{
  ;	x2 = -x2;
  ;	++sign2;
;}
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
;if (sign1)
; 	dst[i] = -pwlog2(x1);		
;else
;	  dst[i] = pwlog2(x1);
ldr	r3, [fp, #-20]
cmp	r3, #0
beq	.L29
; ---- ldr	r3, [fp, #-44] UNNECESSARY LOAD - VALUE IS STILL STORED IN R5
mov	r2, r5, asl #1 ; REPLACED R3 W/ R5
ldr	r3, [fp, #-52]
add	r4, r3, r2
ldrsh	r0, [fp, #-24] ; LOAD DIRECTLY INTO R0
; ---- mov	r0, r3 SEE ABOVE
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
; ---- ldr	r3, [fp, #-44] UNNECESSARY LOAD - VALUE STILL IN R5
mov	r2, r5, asl #1 ; REPLACED R3 W/ R5
ldr	r3, [fp, #-52]
add	r4, r3, r2
ldrsh	r0, [fp, #-24] ; LOAD DIRECTLY INTO R0
; ---- mov	r0, r3 SEE ABOVE
bl	pwlog2
mov	r3, r0
mov	r3, r3, asl #16
mov	r3, r3, lsr #16
strh	r3, [r4, #0]	@ movhi
;
;if (sign2)
; 	dst[i - 1] = -pwlog2(x2);
;else
;	  dst[i - 1] = pwlog2(x2);
.L30:
ldr	r3, [fp, #-16]
cmp	r3, #0
beq	.L31
; ---- ldr	r3, [fp, #-44] UNNECESSARY LOAD - VALUE STILL IN R5
rsb	r3, r5, #1 ; R3 -> R5
mov	r3, r3, asl #1
rsb	r2, r3, #0
ldr	r3, [fp, #-52]
add	r4, r3, r2
ldrsh	r0, [fp, #-22] ; LOAD DIRECTION INTO R0
; ---- mov	r0, r3 SEE ABOVE
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
; ---- ldr	r3, [fp, #-44] UNNECESSARY LOAD - VALUE STILL IN R5
rsb	r3, r5, #1 ; R3 -> R5
mov	r3, r3, asl #1
rsb	r2, r3, #0
ldr	r3, [fp, #-52]
add	r4, r3, r2
ldrsh	r0, [fp, #-22] ; LOAD DIRECTLY INTO R0
; ---- mov	r0, r3 SEE ABOVE
bl	pwlog2
mov	r3, r0
mov	r3, r3, asl #16
mov	r3, r3, lsr #16
strh	r3, [r4, #0]	@ movhi
.L32:
; for loop initializers etc
.LBE3:
; ldr	r3, [fp, #-44] UNNECESSARY LOAD - VALUE STILL IN R5
sub	r5, r5, #2
; str	r3, [fp, #-44]
; ldr	r3, [fp, #-44]
cmp	r5, #0
bne	.L33
str r5, [fp, #44]

137 - 39 = 98 cycles
