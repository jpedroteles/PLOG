

                             
get_square(Board, Col, Row, Square) :-
        nth1(Row,Board, Line),
        element(Col, Line, Square).    

get_size_board([L|_R], N) :-
         length(L,N).



set_board_square(X, Y, Square, Board, NovoBoard) :-
         get_linha(Board, Y, RowY),
         set_square(X, Square, RowY, ResRowY),
         set_square(Y, ResRowY, Board, NovoBoard).

get_linha(Board, Row, Res)  :-
         nth0(Row, Board, Res).

%Predicado responsável por modificar uma square numa certa linha do Board
set_square(Indice, Elemento,Lista, NewLista):-
         length(AuxL, Indice),
         append(AuxL, [_|E], Lista),
         append(AuxL, [Elemento| E], NewLista).

/*verifica se o número está no mesmo indíce*/
member(_N, _Nx, Line, Ex, V) :-
           length(Line, Len),
           Ex =:= Len + 1,
           V is -1.

member(N, Nx, Line, Nx, V) :-
           X is Nx + 1,
           member(N, Nx, Line, X, V).

member(N, _Nx, Line, Ex, V) :-
           nth1(Ex, Line, Elem),
           Elem =:= N,
           V is Ex.

member(N, Nx, Line, Ex, V) :-
           X is Ex + 1,
           member(N, Nx, Line, X, V).

