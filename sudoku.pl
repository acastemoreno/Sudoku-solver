#!swipl -f -q 
%Lo anterior, solo si prolog esta instalado
:-initialization main. %Solo si prolog esta instalado
:-use_module(library(clpfd)).
 
sudoku(Rows) :-  
  append(Rows, Vs), % Rows es lista de lista y Vs concatenacion de estas listas, osea todos los numeros del sudoku en una lista.
  Vs ins 1..9, % Las variables de Vs son elementos de Dominio 1..9
  maplist(all_distinct, Rows), %maplist significa que es verdad si all_distinct se aplica a todas filas
  transpose(Rows, Columns), %Transpuesta de matrix Row, equivalente a hallar las columnas
  maplist(all_distinct, Columns), %all_distinct a todas las columnas
  Rows = [A,B,C,D,E,F,G,H,I],   %Guarda cada fila en una variable correspondiente
  blocks(A, B, C), blocks(D, E, F), blocks(G, H, I),     %Regla de los bloques
  maplist(label, Rows), !.  %Termina en primer resultado exitoso.
 
blocks([], [], []).   
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :-     % 3 primeros elementos de fila junto con restantes
  all_distinct([A,B,C,D,E,F,G,H,I]),       %3 primeros elementos de fila son todos distintos
  blocks(Bs1, Bs2, Bs3).                   %Se aplica nuevamente lo anterior, termina al aplicar regla apra bloque vacio.

%http://stackoverflow.com/questions/25467090/how-to-run-swi-prolog-from-the-command-line
%http://www.webber-labs.com/mpl/lectures/
%Hacer codigo ejecutable swipl -o sudokuexe -g main -c sudoku.pl sin prolog instalado, ejecutando con ./sudoku.pl 8
%Ejecutar codigo prolog con swi instalado: ./sudoku.pl 8,_,_,_,_,_,_,_,_ _,_,3,6,_,_,_,_,_ _,7,_,_,9,_,2,_,_ _,5,_,_,_,7,_,_,_ _,_,_,_,4,5,7,_,_ _,_,_,1,_,_,_,3,_ _,_,1,_,_,_,_,6,8 _,_,8,5,_,_,_,1,_ _,9,_,_,_,_,4,_,_

atnum(Argv,L):-
(Argv=='_'->term_to_atom(L,Argv);atom_number(Argv,L))
.

listnumterm([],[]).
listnumterm([Listatomo|Listatomt],[Listno|Listnt]):-
atnum(Listatomo,Listno),
listnumterm(Listatomt,Listnt)
.


olista([Argv],Elem):-
atomic_list_concat(Listatom,',',Argv),
listnumterm(Listatom,Elem)
.

tlista([],[]).
tlista([Argvo|Argvt],[Tlistao|Tlistat]):-
olista([Argvo],Tlistao),
tlista(Argvt,Tlistat)
.


main :-
 current_prolog_flag(argv, Argv),
 tlista(Argv,Puzzle),
 Puzzle = [A,B,C,D,E,F,G,H,I],
 sudoku([A,B,C,D,E,F,G,H,I]),
 format('[~w,~w,~w,~w,~w,~w,~w,~w,~w]', Puzzle),
 halt.

