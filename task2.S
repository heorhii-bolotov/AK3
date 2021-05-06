.global task2
.syntax unified

#define a #5
#define b #8

task2:
	push {lr}

	mov r1, a
	mov r2, b

	//program start
	//step1
	lsl r1, r1, #25  
	//step2
	add r1, r1, #7
_step3:
	lsls r2, r2, #30

	//step4
	it vs
	//step6
	lsrVS r2, r2, #1
	bVS _step8

	//else - go to sub-program
	bl subP1
	//step5
	add r3, r3, r1
	//step7
	lsls r2, r3, #2

_step8:
	it eq
	blEQ _step3

	//step9
	asr r2, r2, #1

	pop {pc}

subP1:
	push {lr}
	mov r3, #3

_step10:
	adds r3, r3, r1

	//step11
	it cc
	blCC _step13

	bl subP2
	//step12
	add r3, r3, #5

_step13:
	it vc
	blVC _step10

	//step14
	lsr r3, r3, #1
	//step15
	add r3, r3, #4


	pop {pc}

subP2:
	push {lr}

	//step17
	asr r3, r3, #2
	//step18
	add r3, r3, #8

	pop {pc}