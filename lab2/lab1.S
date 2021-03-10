.global lab1
.syntax unified

#define A #1
#define B #3
#define C #4

lab1:
	push {lr}
	mov r0, A
	add r0, B
	lsr r1, r0, #1 // r1 = (a+b)/2
	mov r0, #1
	mov r2, C
	
	.factorial:
		mul r0, r2
		subs r2, #1
		bne .factorial // r0 = c!
	add r0, r1
	pop {pc}


