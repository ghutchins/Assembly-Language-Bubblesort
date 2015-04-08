
/* NOIS II Bubblesort Program

 */
/* Georgina Hutchins   02/13/15 */




.global bubble
.text		/*instructions go under the text section*/




bubble:
/* initialize r17, r16, and r15

	*/
	mov r17,r5		/* move r5 (size of array) into r17 */
	
	subi r16,r17,1		/* r16 initial value i = r5 - 1 */
	
	addi r15,r0,1		/* boolean for madeswap initially set to true (=1) */



/* outer for loop (for(int i=N-1; i>0 && madeswap; i--)) */
compare:

	
	cmpgti r18,r16,0
 	/* if value of r16 > 0, set r18 value to 1, else set r18 to 0 */
	and r18,r18,r15
		/* logical and between r18 and r15 -- continue loop while madeswap is still true (=1) */
	beq r18,r0,stop		/* if r18 is 0, branch to stop */




/* inner for loop--sweeping through cells [0,i] (for(int j=0; j<i; j++)) */
/* initialize r19 for inner loop counter */
/* switching from index to displacement oriented to make comparing sequential elements easier by address */
	

	mov r15,r0		/* madeswap bool set to false (=0) */
	
	mov r19,r0		/* inner counter (j) init value j = 0 */
	
	slli r16,r16,2		/* left shift by 2 (multiplying by 4) */

dj1:			
	cmpge r20,r19,r16	/* if r19>r16 store a 1 in r20, else store 0 (loop while r20 set to 0--loop condition(j<i)) */ 	 
	
	bne r20,r0,dj2		/* branch to dj2 if r20 != 0 (end of sweep) */

/* nested if statement (if two cells are in the wrong order) (if X[j] > X[j+1]) */
			

	
	add r22,r4,r19		/* r22 holds sum of r4 + r19 -- access to the array
 */
	ldw r17,0(r22)		/* load X[j] into r17
 */
	ldw r21,4(r22)		/* load X[j+1] into r21 */

	
	cmpge r23,r21,r17	/* if value in r21 > r17, store result in r23 (if r21>r17, store 0 in r23)*/
	
	bne r23,r0,dj3		/* if 0 is in r23, cells are in corect order -- branch out) 

*/	
	
	stw r21,0(r22)		/* swap adjacent cell contents (x[j+1]=x[j]). Content of 0(r22) stored in r21 */
	stw r17,4(r22)		/* swap adjacent cell contents (x[j]=x[j+1]). Content of 4(r22) stored in r17 */				


	
	addi r15,r0,1		/* madeswap set to true (=1)

 */

dj3:	
/* where we branch to if the cells are in the correct order */
	
	
	addi r19,r19,4
	
	br dj1			/* loop back to dj1 to iterate through inner for loop again */


dj2:

/* where we branch to at end of sweep (exit inner for loop) */ 
	
	srai r16,r16,2		/* rightshift by 2 (divided by 4) returns r16 to original displacement */
	
	subi r16,r16,1
	
	br compare		/* branch back to compare to ensure elements are sorted correctly */	



stop:
	ret



.end

