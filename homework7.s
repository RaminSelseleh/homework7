/*
 * Ramin Selseleh
 * Homework7
 * theia
 */

 .global main
main:
    @ Prompt user to enter a character.
	MOV R0, #1
	MOV R2, #25
	MOV R7, #4
	LDR R1, =prompt
	SWI 0

    @ Get input from keyboard.
	MOV R0, #0
	MOV R2, #2
	MOV R7, #3
	LDR R1, =input
    SWI 0

    @ Display what was entered
	MOV R0, #1
	MOV R2, #2
	MOV R7, #4
	LDR R1, =input
	SWI 0


    @ get each ascii digit
	LDR R1, =input

    @ checks to see if input was a space
    LDRB R10, [R1, #0]
    CMP R10, #32
    BEQ spaceE

number:
    @ checks to see if its 0-9
    LDRB R10, [R1, #0]
    CMP R10, #48
    BLT lowLetter
    LDRB R10, [R1, #0]
    CMP R10, #57
    BGT lowLetter
    MOV R7, #4 @ Syscall number
    MOV R0, #1 @ Stdout is monitor
    MOV R2, #21 @ string is 19 chars long
    LDR R1,=numE @ string located at string:
    SWI 0
    MOV R0, #120
    BAL exit


lowLetter:
    LDRB R10, [R1, #0]
    CMP R10, #123
    BEQ atLast
    CMP R10, #124
    BEQ atLast
    CMP R10, #125
    BEQ atLast
    CMP R10, #126
    BEQ atLast
    CMP R10, #'a'
    BLT upperLetter
    MOV R7, #4 @ Syscall number
    MOV R0, #1 @ Stdout is monitor
    MOV R2, #32 @ string is 19 chars long
    LDR R1,=lowCE @ string located at string:
    SWI 0
    MOV R0, #130
    BAL exit


upperLetter: 
    LDRB R10, [R1, #0]
    CMP R10, #'A'
    BLT controlChar
    LDRB R10, [R1, #0]
    CMP R10, #91
    BEQ atLast
    CMP R10, #92
    BEQ atLast
    CMP R10, #93
    BEQ atLast
    CMP R10, #94
    BEQ atLast
    CMP R10, #95
    BEQ atLast
    CMP R10, #96
    BEQ atLast
    MOV R7, #4 @ Syscall number
    MOV R0, #1 @ Stdout is monitor
    MOV R2, #32 @ string is 19 chars long
    LDR R1,=upCe @ string located at string:
    SWI 0
    MOV R0, #140
    BAL exit


controlChar:
    LDRB R10, [R1, #0]
    CMP R10, #31
    BGT atLast
    MOV R7, #4 @ Syscall number
    MOV R0, #1 @ Stdout is monitor
    MOV R2, #27 @ string is 19 chars long
    LDR R1,=controlEr @ string located at string:
    SWI 0
    MOV R0, #150
    BAL exit


atLast:
    MOV R7, #4 @ Syscall number
    MOV R0, #1 @ Stdout is monitor
    MOV R2, #37 @ string is 19 chars long
    LDR R1,=end @ string located at string:
    SWI 0
    MOV R0, #160
    BAL exit



spaceE:
    MOV R7, #4 @ Syscall number
    MOV R0, #1 @ Stdout is monitor
    MOV R2, #20 @ string is 19 chars long
    LDR R1,=thro @ string located at string:
    SWI 0
    MOV R0, #110
    BAL exit


exit: @ exit syscall
    MOV R7, #1
    SWI 0


.data
prompt:
.ascii "Please enter a character:"
input:
.ascii "  \n"
thro:
.ascii "You entered a space\n"
numE:
.ascii "You entered a number\n"
lowCE:
.ascii "You entered a lower case letter\n"
upCe:
.ascii "You entered a upper case letter\n"
controlEr:
.ascii "You entered a control code\n"
end:
.ascii "You entered a punctuation character\n"
