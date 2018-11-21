assume cs:code,ds:data,ss:stack 

data segment 
db 'welcome to masm!' ;定义要显示的字符串(共16个字节) 
db 02h,24h,71h ;定义了三种颜色 
data ends 

stack segment 
dw 8 dup(0) ;定义栈段,保存相关寄存器的值 
stack ends 

code segment 




start:mov ax, data 
mov ds,ax ;ds中存放data段的段地址　 
mov ax ,stack 
mov ss,ax ;ss中存放stack段的段地址 
mov sp,10h　;把sp指针指向栈顶的下一个地址. 
mov bx,0 ;存偏移地址,用来取每个字符 
mov di,0 ; 


mov ax,0b872h;算出屏幕12行中间的显存的段起始位置放入ax 
mov cx,3; 外循环为3次,因为要显示三个ｗ字符串 
s3: push cx 
push ax 
push di ;三个进栈操作作为外循环s3保存相关寄存器的值,以防在内循环中被破坏 mov es,ax 
mov si,0 
mov di,0 
mov cx,10h 
s1: mov al,ds:[bx+si]
mov es:[bx+di],al
   inc si ;读下一个字符
   add di,2 ;每存一个字符,空一个字节,在下一个循环中存放颜色属性值. 
    loop s1;此循环实现在偶地址中存放字符串
        mov si,1 ;将si置为1，为在奇地址中存放字符的颜色.
        pop di ;将di的值恢复成进入内循环之前的时候的值
        mov al,ds:10h[bx+di] ;取颜色属性
        mov cx,10h ;第二个内循环也为10h次
    s2: mov es:[bx+si],al
	add si,2 
loop s2 ;此循环实现奇地址存放字符的颜色属性. 
inc di ;取第二种颜色 
pop ax　 
add ax, 0ah ; 将显存的段起始地址设为当前行的下一行 
pop cx 
loop s3 
mov ax,4c00h 
int 21h 

code ends 
end start

