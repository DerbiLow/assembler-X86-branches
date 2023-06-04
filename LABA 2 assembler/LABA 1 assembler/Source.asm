.686
.model flat,stdcall
.stack 100h
.data
X dw 43900; 
Y dw 50574;
Z dw 43981;
D dw 64407; /*Число для зануления 3, 5, 6, 10 битов*/
F dw 61937; /*F1F1*/
M dw ?;
R dw ?;

.code
ExitProcess PROTO STDCALL :DWORD
Start:

MOV cx, 3; /*Кол-во итераций цикла*/
MOV bx, 3
MOV dx, 2; /*Числа для работы условий внутри цикла*/

cycle:
CMP bx, cx; /*Сравнение чисел 3=3*/
JNE Next; /*Если числа не равны, то переходим в Next, иначе продолжаем выполнять операции */
MOV ax, X; /*Передаем значение в регистр ах*/
AND ax, D; /*При помощи логического умножения зануляем 3, 5, 6, 10 биты в числе*/
MOV X, ax; /*Передаем обновленное значение в переменную из регистра ах*/
JMP MyNext; /*Выполняем переход в указанное место (в данном случае в конец цикла)*/

Next:
CMP dx, cx;  /*Сравнение чисел 2=2*/
JNE Last;  /*Если числа не равны, то переходим в Last, иначе продолжаем выполнять операции */
MOV ax, Y
AND ax, D
MOV Y, ax
JMP MyNext; /*Выполняем переход в указанное место (в данном случае в конец цикла)*/

Last:
MOV ax, Z
AND ax, D
MOV Z, ax
JMP ER

MyNext:
loop cycle

ER:

MOV ax, X
MOV bx, Y
AND ax, bx; /*Логическое умножение*/
MOV cx, Z
NOT cx; /*Инверсия значения Z*/
SUB ax, cx
;MOV ax, 11403
MOV M, ax; /*Передача вычесленного значения в M*/

MOV cx, 8; /*Число для проверки количества младших 8 бит*/
MOV bx, 0
MOV dx, 1
begin:
SHR ax,1; /*Cдвиг вправо и сравнение младшего бита числа М с 1*/
JNC Nxt; /*Если бит равен 0, то переход в конец цикла*/
INC bx; /*Счетчик количества единиц*/
Nxt:
CMP cx,dx;
JE EXQ;
loop begin

EXQ:

MOV ax, bx
MOV bx, 2; /*Переменная для проверки четности единиц*/
MOV dx, 0; /*Переменная для остатка*/
DIV bx

MOV bx, 0
CMP dx, bx; /*Если отстатка нет(четное кол-во единиц), то продолжает выполнение операций*/
JE PP
JNE PPP; /*отстаток есть(нечетное кол-во единиц)*/

PP:
Mov ax, M
ROR ax,6; /*Циклический сдвиг вправо на 6*/
MOV R, ax
JMP ADRONE

PPP:
MOV ax, M
MOV bx, F
AND ax, bx; /*Результат AND*/
MOV R, ax
JMP ADRTWO

ADRONE:
MOV ax, 1
ADD R, ax
JMP exit

ADRTWO:
MOV ax, 1021
OR R, ax

exit:
Invoke ExitProcess, R; /*вывод результатат на экран*/
End Start