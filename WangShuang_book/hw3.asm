ASSUME SS:stack,CS:code,DS:data 

;数据段的定义 
data SEGMENT 
	strInput DB 100H dup(?) 
	str0 DB 0DH, 0AH, 24H 
	strExit DB 'Please press any key to exit!', 0DH, 0AH, 24H 
data ends 

;栈空间的定义 
stack SEGMENT STACK ;这里要加上“STACK”，不然编译器不知道这是一段栈空间，在连接时老是说没有栈
	DB 20 DUP(0) 
	top LABEL WORD ;栈顶指针 
stack ends 

;代码段空间的定义 
code SEGMENT 
 start: MOV AX, stack 
	MOV SS, AX ;栈空间的初始化 
	LEA SP, top ;设置栈和栈顶地址 
	MOV AX, data 
	MOV DS, AX ;初始化数据段 
 input: LEA DX, strInput 
	MOV BX, DX 
	MOV byte ptr DS:[BX], 0ffh
        MOV AH, 0AH 
	INT 21H ;键盘输入到缓冲区 
	MOV DI, DX ;获取输入缓冲区首址，放在DI中 
	MOV BH, DS:[DI] ;获取输入缓冲区的最大字符数 
	MOV BL, DS:[DI+1] ;获取输入缓冲区中实际输入的字符数 
	LEA DX, str0 
	MOV AH, 9 
	INT 21H ;输出回车换行 
output: XOR CH, CH 
	MOV CL, BL 
	MOV BX, DI 
	lea bx, strInput 
	ADD BX, CX 
	ADD BX, 2 
	MOV byte ptr DS:[BX], 0AH 
	INC BX 
	MOV byte ptr DS:[BX], 0DH 
	INC BX 
	MOV byte ptr DS:[BX], 24H ;插入回车、换行和结束字符 
	MOV DX, DI 
	ADD DX, 2 
	MOV AH, 9 
	INT 21H 
finish: LEA DX, strExit ;DX指向要输出字符串 
	MOV AH, 9 
	INT 21H ;执行输出语句 
	MOV AH, 7 
	INT 21H 
	;INT 21H的7号功能是让用户输入但不回显，所以程序在就不会一闪而过了
	MOV AX, 4C00H
 	;MOV AH, 4CH 
	INT 21H ;返回 
code ends 

end start



