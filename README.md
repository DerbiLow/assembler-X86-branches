# assembler-X86-branches

<h1> ЛАБОРАТОРНАЯ РАБОТА № 2 "ПРИНЦИПЫ ВЫПОЛНЕНИЯ КОМАНД ВЕТВЛЕНИЯ, ОРГАНИЗАЦИЯ ЦИКЛОВ И ПОДПРОГРАММ"  <br>
Цель работы: изучение принципов выполнения команд ветвления, организации циклов и подпрограмм микропроцессоров с архитектурой x86</h1><br>

 Исходное задание выглядит слежующим образом: <br>
  ![image](https://user-images.githubusercontent.com/126500303/224387894-eccda7ec-31a6-4787-b21b-61768bab9cb7.png) <br> <br>
  Исходные данные: <br>
  X = 43900 (в двоичном коде 1010 1011 0111 1100), Y = 50574 (в двоичном коде 1100 0101 1000 1110), Z = 43981 (в двоичном коде 1010 1011 1100 1101) <br> <br>
  Дополнительные данные:<br>
  Число F = F1F1 (в десятичном коде 61937, в двоичном коде 1111 0001 1111 0001)
Для зануления 3, 5, 6, 10 бит в исходных числах будет использоваться число D = 64407 (в двоичном коде 1111 1011 1001 0111) <br> <br>
По условию задания необходимо зануить биты в числах X, Y, Z при помощи цикла 

Способ объявления цикла представлен в строке ниже, перед началом выполнения в регистр сх необходимо передать значение количества итераций цикла. 
cycle: loop cycle <br>

Для того, чтобы на каждой итерации цикла менялось только одно число, необходимо добавить условие <br>
CMP bx, cx; Условие сравнения чисел, в данном случае (3=3) <br>
Далее после выполнения (или не выполнения) условия необходимо реализовать ветвление <br>
JNE Next; Перенаправляет в точку Next, если в результате сравнения двух чисел оказалось, что они не равны <br>
MOV ax, X; В случае если числа равны, то выполняется операция передачи значения в регистр ах <br>
AND ax, D; При помощи логического умножения зануляются 3, 5, 6, 10 биты в числе X <br>
MOV X, ax; Возвращает обновленное значение в переменую Х <br> 
JMP MyNext; Так как итерация цикла выполнена для одного числа и следующая проверка условий (которые будут неверны при данном значении cх), то переместим в конец цикла для перехода к следующей итераций <br>

После зануления 3, 5, 6, 10 бит, новые значения X = 43796 (в двоичном коде 1010 1011 0001 0100), Y = 49542 (в двоичном коде 1100 0001 1000 0110), Z = 43909 (в двоичном коде 1010 1011 1000 0101) <br>
'Z = 21626 (в двоичном коде 0101 0100 0111 1010) - Число с инверсией всех бит обычного числа Z. Для этого используется операция NOT cx; <br>
Вычисляем значение формулы M = (X' & Y') - 'Z, в результате М = 11402 (в двоичном коде 0010 1100 1000 1010)

Вычислив значение М, подсчитаем  количество единиц в малдших 8-ми битах. <br>
begin: <br>
SHR ax,1; Сдвигаем число вправо на 1 бит и сравниваем этот бит с единицей <br>
JNC Nxt; Если бит равен 0, то переходим в конец цикла (переход к следующей итерации) <br>
INC bx; Если значение равно единице, то счетчик прибавляет 1 к прошлому значению <br>
Nxt: <br>
CMP cx,dx; Если последняя итерация цикла, то необходимо выйти за его границы <br>
JE EXQ; <br>
loop begin <br>

При значении М = 11402, то число единиц среди восьми младших бит равно 3 (нечетное число) <br>
Деление позволяет проверить наличие остатка, если он есть, то количество единиц нечетное <br>
В зависимости от четности (нечетности) единиц будет произведено следующее ветвление. <br>
CMP dx, bx; Сравнение остатка от деления и числа 0
JE PP; Если числа равны (остатка нет), то переходим в пункт PP (P1)
JNE PPP; Если числа не равны (остаток есть), то переходим в пункт PPР (P2)

В пункте P1 выполняется циклический сдвиг вправо на 6 символов при помощи операции ROR ax,6; <br>
JMP ADRONE перенаправляет в пункт adr1 <br> 

В пункте P2 выполняется операция AND с числом F1F1 (так как при исходных данных число единиц нечетное, то мы уходим в данное ветвление) <br>
M AND F1F1 = 8320 (в двоичном коде 0010 0000 1000 0000)
JMP ADRTWO перенаправляет в пункт adr2 <br>

В пункте adr1 к числу (результат циклического сдивга) прибаляется 1 <br>
В пункте adr2 к числу (результат операции AND)  выполняется операция OR с числом 1021 (в двоичном коде 0000 0011 1111 1101) в результате данной операции получим результат 9213 (верификация данного результата показана на рисунке ниже)

<italic>Чтобы при тех же значениях Х, Y перейти в пункт Р1 и далее в adr1, необходимо, чтобы Z был равен 45038</italic>

Исходный код представлен в файле CODE1.txt
Результат работы программы представлен на рисунке 
![image](https://user-images.githubusercontent.com/126500303/224402481-7e7faf8d-6091-4f28-af59-8795f17779ba.png)
