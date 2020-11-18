DATA	SEGMENT
	KEEP_CS DW 0 ; ??? ???????? ???????? 
	KEEP_IP DW 0 ; ? ???????? ??????? ?????????? 
DATA      ENDS

AStack	SEGMENT	STACK
	DB 256 DUP(?)
AStack  ENDS

CODE    SEGMENT
    ASSUME SS:AStack, DS:DATA, CS:CODE

SUBR_INT PROC FAR 
	PUSH AX ; ?????????? ?????????? ?????????
	PUSH DX
  
	MOV AH, 2
	MOV DL, 07H ; sound beep
	INT 21H

	POP AX ; ?????????????? ?????????
	POP DX  

	MOV AL, 20H 
	OUT 20H,AL 
	IRET 
SUBR_INT ENDP 

MAIN PROC FAR

	PUSH DS
	SUB AX, AX
	PUSH AX
	MOV AX, DATA
	MOV DS, AX
	
	MOV AH, 35H ; ??????? ????????? ??????? 
	MOV AL, 60H ; ????? ??????? 
	INT 21H 
	MOV KEEP_IP, BX ; ??????????? ???????? 
	MOV KEEP_CS, ES ; ? ???????? ??????? ?????????? 
		
	PUSH DS 
	MOV DX, OFFSET SUBR_INT ; ???????? ??? ????????? ? DX 
	MOV AX, SEG SUBR_INT ; ??????? ????????? 
	MOV DS, AX ; ???????? ? DS 
	MOV AH, 25H ; ??????? ????????? ??????? 
	MOV AL, 60H ; ????? ??????? 
	INT 21H ; ?????? ?????????? 
	POP DS 

	int 60h

	CLI
	PUSH DS 
	MOV DX, KEEP_IP 
	MOV AX, KEEP_CS 
	MOV DS, AX 
	MOV AH, 25H 
	MOV AL, 60H 
	INT 21H ; ??????????????? ?????? ?????? ?????????? 
	POP DS 
	STI

	ret

MAIN ENDP
CODE ENDS
END MAIN
