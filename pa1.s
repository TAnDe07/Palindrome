.section .data

input_prompt    :   .asciz  "Input a string: "
input_spec      :   .asciz  "%[^\n]"
length_spec     :   .asciz  "String length: %d\n"
palindrome_spec :   .asciz  "String is a palindrome (T/F): %c\n"
input: .space 255
.section .text

.global main

# program execution begins here
main:
	ldr x0, =input_prompt
	bl printf

	ldr x0, =input_spec
	ldr x1, =input
	bl scanf

	ldr x10, =input //store string input in x10

	mov x9, #0 //length = 0
	//get length
loop:
	ldrb w11, [x10, x9] // gets char at index
	CBZ x11, end //if char is 0, null, exit
	ADD x9, x9, #1 
	b loop //add 1 to index
end:

	//print length
	// add x9, x9, #48 //ascii of num
	mov x19, x9 //length
	mov x1, x9
	ldr x0, =length_spec //move sped to x0 
	bl printf  //print length

	cbz x19, pal //if length is 0, branch to pal

	ldr x10, =input //input 
	mov x11, #0  //index
	mov x9, x19 //length

//get if pal or not
loop2:
	sub x9, x9, #1 //length--
	ldrb w1, [x10, x9] //index from end-beginning
	ldrb w2, [x10, x11] //index from beginning-end
	sub x12, x1, x2 //x1 == x2?
	cbnz x12, notpal // x1 != x2, go to notpal
	cbz x9, pal //end of string, go to pal
	add x11, x11, #1 //index++
	b loop2 //branch to loop
pal:
	mov x1, #84 //gets letter T, into x1
	ldr x0, =palindrome_spec
	bl printf	//prints pal is true
	b exit
notpal:
	mov x1, #70 //gets letter F, into x1
	ldr x0, =palindrome_spec
	bl printf //prints pal is false
	b exit



# add code and other labels here

# branch to this label on program completion
exit:
    mov x0, 0
    mov x8, 93
    svc 0
    ret
