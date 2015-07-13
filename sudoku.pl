pertenece(X,[Y|R]):- ( X==Y -> 1==1 ; pertenece(X,R) ).
condicion([X|Y]):- (Y==[] -> 1=1 ; ( not(pertenece(X,Y)), condicion(Y) ) ).