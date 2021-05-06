.global task1
.syntax unified

#define x1h #0x00000000
#define x1l #0x0000000C
#define x2h #0x00000000
#define x2l #0x00000002
#define x3h #0xFFFFFFFF
#define x3l #0xFFFFFFF6
#define x4h #0x00000000
#define x4l #0x0000000F
#define ZK #0x00001FB1

task1:
	push {lr}
	mov r1, x1h
	mov r0, x1l
	mov r3, x2h
	mov r2, x2l
	//x1 or x2
	orr r4, r2, r0
	orr r5, r3, r1
	//8(x1 or x2) r4, r5
	eor r10, r10 
	lsls r4, r4, #1
	adc r10, r10, #0
	lsls r4, r4, #1
	lsl r10, r10, #1
	adc r10, r10, #0
	lsls r4, r4, #1
	lsl r10, r10, #1
	adc r4, r4, r10
	lsls r5, r5, #3
	add r5, r5, r10
	
	mov r1, x3h
	mov r0, x3l
	mov r3, x4h
	mov r2, x4l
	//f = (x3 - 1 - x4) r6, r7
	subs r6, r0, #1
	sbc r7, r1, #0
	subs r6, r6, r2
	sbc r7, r7, r3
	//f = (x3 - 1 - x4)/16 r6, r7
	eor r10, r10
	asrs r7, r7, #1
	adc r10, r10, #0
	asrs r7, r7, #1
	lsl r10, r10, #1
	adc r10, r10, #0
	asrs r7, r7, #1
	lsl r10, r10, #1
	adc r10, r10, #0
	asrs r7, r7, #1
	lsl r10, r10, #1
	adc r10, r10, #0
	lsl r10, r10, #28
	lsr r6, r6, #4
	add r6, r6, r10
	//f = 8(x1 or x2) + (x3 - 1 - x4)/16
	adds r6, r6, r4
	adcs r7, r7, r5

	it vs
	blVS _correct

	cmp r6, #0
	it eq
	blEQ _addZK

	mov r0, ZK
	add r7, r0

	lsrs r0, r7, #30
	it eq
	blEQ _cont
	cmp r0, #3
	it eq
	blEQ _cont
	bl _correct2

_cont:
	pop {pc}

_correct:
	push {lr}
	lsr r6, r6, #1
	lsrs r7, r7, #1
	adc r6, r6, #0
	add r7, r7, #0x80000000
	pop {pc}

_addZK:
	push {lr}
	mov r0, ZK
	lsl r0, r0, #16
	mov r6, r0
	pop {pc}

_correct2:
	push {lr}
	lsr r6, r6, #1
	asrs r7, r7, #1
	it cs
	addCS r6, #0x80000000
	pop {pc}
