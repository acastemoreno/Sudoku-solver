#!swipl -f -q
:-initialization main.
:-use_module(library(clpfd)).
 
sudoku(Rows) :-  
  append(Rows, Vs), % Rows es lista de lista y Vs concatenacion de estas listas, osea todos los numeros del sudoku en una lista.
  Vs ins 1..9, % Las variables de Vs son elementos de Dominio 1..9
  maplist(all_distinct, Rows), %maplist significa que es verdad si all_distinct se aplica a todas filas
  transpose(Rows, Columns), %Transpuesta de matrix Row, equivalente a hallar las columnas
  maplist(all_distinct, Columns), %all_distinct a todas las columnas
  Rows = [A,B,C,D,E,F,G,H,I],   %Guarda cada fila en una variable correspondiente
  blocks(A, B, C), blocks(D, E, F), blocks(G, H, I),     %Regla de los bloques
  maplist(label, Rows).
 
blocks([], [], []).   
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :-     % 3 primeros elementos de fila junto con restantes
  all_distinct([A,B,C,D,E,F,G,H,I]),       %3 primeros elementos de fila son todos distintos
  blocks(Bs1, Bs2, Bs3).                   %Se aplica nuevamente lo anterior, termina al aplicar regla apra bloque vacio.

%http://stackoverflow.com/questions/25467090/how-to-run-swi-prolog-from-the-command-line
main :-
 Puzzle = [[8,_,_,_,_,_,_,_,_], [_,_,3,6,_,_,_,_,_], [_,7,_,_,9,_,2,_,_], [_,5,_,_,_,7,_,_,_], [_,_,_,_,4,5,7,_,_], [_,_,_,1,_,_,_,3,_], [_,_,1,_,_,_,_,6,8], [_,_,8,5,_,_,_,1,_], [_,9,_,_,_,_,4,_,_] ], 
 Puzzle = [A,B,C,D,E,F,G,H,I], sudoku([A,B,C,D,E,F,G,H,I]),
 format('[~w,~w,~w,~w,~w,~w,~w,~w,~w]', Puzzle),
 halt(1).

