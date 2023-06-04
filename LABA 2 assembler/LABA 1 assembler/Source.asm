.686
.model flat,stdcall
.stack 100h
.data
X dw 43900; 
Y dw 50574;
Z dw 43981;
D dw 64407; /*����� ��� ��������� 3, 5, 6, 10 �����*/
F dw 61937; /*F1F1*/
M dw ?;
R dw ?;

.code
ExitProcess PROTO STDCALL :DWORD
Start:

MOV cx, 3; /*���-�� �������� �����*/
MOV bx, 3
MOV dx, 2; /*����� ��� ������ ������� ������ �����*/

cycle:
CMP bx, cx; /*��������� ����� 3=3*/
JNE Next; /*���� ����� �� �����, �� ��������� � Next, ����� ���������� ��������� �������� */
MOV ax, X; /*�������� �������� � ������� ��*/
AND ax, D; /*��� ������ ����������� ��������� �������� 3, 5, 6, 10 ���� � �����*/
MOV X, ax; /*�������� ����������� �������� � ���������� �� �������� ��*/
JMP MyNext; /*��������� ������� � ��������� ����� (� ������ ������ � ����� �����)*/

Next:
CMP dx, cx;  /*��������� ����� 2=2*/
JNE Last;  /*���� ����� �� �����, �� ��������� � Last, ����� ���������� ��������� �������� */
MOV ax, Y
AND ax, D
MOV Y, ax
JMP MyNext; /*��������� ������� � ��������� ����� (� ������ ������ � ����� �����)*/

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
AND ax, bx; /*���������� ���������*/
MOV cx, Z
NOT cx; /*�������� �������� Z*/
SUB ax, cx
;MOV ax, 11403
MOV M, ax; /*�������� ������������ �������� � M*/

MOV cx, 8; /*����� ��� �������� ���������� ������� 8 ���*/
MOV bx, 0
MOV dx, 1
begin:
SHR ax,1; /*C���� ������ � ��������� �������� ���� ����� � � 1*/
JNC Nxt; /*���� ��� ����� 0, �� ������� � ����� �����*/
INC bx; /*������� ���������� ������*/
Nxt:
CMP cx,dx;
JE EXQ;
loop begin

EXQ:

MOV ax, bx
MOV bx, 2; /*���������� ��� �������� �������� ������*/
MOV dx, 0; /*���������� ��� �������*/
DIV bx

MOV bx, 0
CMP dx, bx; /*���� �������� ���(������ ���-�� ������), �� ���������� ���������� ��������*/
JE PP
JNE PPP; /*�������� ����(�������� ���-�� ������)*/

PP:
Mov ax, M
ROR ax,6; /*����������� ����� ������ �� 6*/
MOV R, ax
JMP ADRONE

PPP:
MOV ax, M
MOV bx, F
AND ax, bx; /*��������� AND*/
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
Invoke ExitProcess, R; /*����� ����������� �� �����*/
End Start