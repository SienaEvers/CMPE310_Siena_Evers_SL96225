;CMPE 310 Project 1
;Siena Evers, Spring 2025


;       IMPORTANT !!!
; My code runs without errors but it does not fucntion perfectly
;there are two constranits:
;   it only works with 0s and 1s as characters in the string
;   it does not print the distance properly if it is more than one digit

;for the second test:
;   print statement is ascii, a V means 38 ('0' is 48, 48+38= 86 which is 'V')

section .data ;define constant variables
    msg db 'the hamming distance is: ' ;
    len equ $-msg

    msg1 db 'Input a string: ', 0xA ;
    msgLen1 equ $-msg1

    newLine db ' ' 0xA ; new line
    newLineLen equ $-newLine

    errorMsg1 db 'too many characters in the string (limit is 255)', 0xA ;error msg
    lenE1 equ $-errorMsg1 


    ;testing variables
    foo db "000111000111", 0   ;    
    lenfoo equ $-foo ;copies the length of the first string

    bar db "010000101110", 0   ; 
    lenbar equ $-bar ;copies the length of the string


; This code only works if the inputed strings are already represented as 1s and 0s
; below is the binary values of the strings listed on the assignment page

; "foo" in binary "0110 0110 0110 1111 0110 1111"
; "bar" in binary "0110 0010 0110 0001 0111 0010"

; "this is a test"             in binary "01110100 01101000 01101001 01110011 00100000 01101001 01110011 00100000 01100001 00100000 01110100 01100101 01110011 01110100"
; "of the emergency broadcast" in binary "01101111 01100110 00100000 01110100 01101000 01100101 00100000 01100101 01101101 01100101 01110010 01100111 01100101 01101110 01100011 01111001 00100000 01100010 01110010 01101111 01100001 01100100 01100011 01100001 01110011 01110100"




section .bss ;reserving space in memory for future data

    hamDistance resb 1  ;reserve space for the hamming distance int
    hamDisLen equ $-hamDistance

    word1 resb 64  ; user input
    word1LEN equ $-word1

    word2 resb 64     ; user input
    word2LEN equ $-word2



section .text

    global _start


_start:

; User input is commented out due to it not being needed

; ASK THE USER FOR TWO INPUT STRINGS
; STORE THE STRINGS INTO TWO VARIABLES

;    mov edx, msgLen1
;    mov ecx, msg1
;    mov ebx, 1
;    mov eax, 4
;    int 0x80

;    mov  eax, 3 ; sys_read
;    mov  ebx, 0 ; stdin
;    mov  ecx, word1 ; user input
;    mov  edx, word1LEN ; max length
;    int  0x80

;    mov edx, msgLen1
;    mov ecx, msg1
;    mov ebx, 1
;    mov eax, 4
;    int 0x80

;    mov  eax, 3 ; sys_read
;    mov  ebx, 0 ; stdin
;    mov  ecx, word2 ; user input
;    mov  edx, word2LEN ; max length
;    int  0x80


; CHECK LENGTH OF THE STRINGS (WILL BE USING THE SHORTER LENGTH STRING LENGTH)
; BOTH LENGTHS SHOULD BE UNDER 255 CHARACTERS

;mov edx, word1LEN
;cmp edx, 255
;jg overCharLimit

;mov edx, word2LEN
;cmp edx, 255
;jg overCharLimit



; TURN THE STRINGS INTO THEIR ASCII VALUES

    ;one byte is 8 bits and 1 ASCII char (2 digit  hexadecimal)
    ;this means each letter will have 8 bits to compare

    ;could compare the msb and shift the bits over to compare all 8 per 


; I never got this ^ to work





; FIND THE HAMMING DISTANCE BETWEEN THE TWO VALUES
; use XOR to find the differing bits
; use a for loop to count the number of '1' bits on the XOR'd value


    mov ecx, 0  ;i of the loop
    mov edx, 0  ;counter that goes up
    jmp loop

loop:
    mov al, byte [foo + ecx] ;ecx increments through each byte of the string
    mov bl, byte [bar + ecx]


    cmp al, 0
    je stopLoop
    cmp bl, 0
    je stopLoop

    inc ecx

    xor al, bl          ;al will be set to 1 if al and bl don't match
    cmp al, 1           ;if this is 1 then it should increment 
    je increment
    
    jmp loop


increment:
    inc edx ;increments edx
    jmp loop


stopLoop:
    add edx, '0'                 ;makes it so hamDistance can be printable
    mov [hamDistance], edx       ;set hamDistance to edx
    jmp exit



; PRINT STATEMENTS (In exit)

exit:
 
;    mov edx, word1LEN
;    mov ecx, word1
;    mov ebx, 1
;    mov eax, 4
;    int 0x80


;    mov edx, word2LEN
;    mov ecx, word2
;    mov ebx, 1
;    mov eax, 4
;    int 0x80


    mov edx, len
    mov ecx, msg
    mov ebx, 1
    mov eax, 4
    int 0x80


    mov edx, hamDisLen      ;this function prints the ascii value, which means if the number is over 9 it prints an character
    mov ecx, hamDistance
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov edx, newLineLen
    mov ecx, newLine
    mov ebx, 1
    mov eax, 4
    int 0x80


    mov eax,1             ;system call number (sys_exit)
    int 0x80




overCharLimit:
    mov edx, lenE1
    mov ecx, errorMsg1
    mov ebx, 1
    mov eax, 4
    int 0x80

    mov eax,1             ;system call number (sys_exit)
    int 0x80