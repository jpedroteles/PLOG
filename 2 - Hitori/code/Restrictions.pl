:- include('Board.pl').
:- include('Elements.pl').
                                        
/*verificar para cada elemento do tabuleiro se tem double,
se tiver então é 1, se não tiver é 0*/

check_blacks_adj([], []).

check_blacks_adj([L1 | Aux1], [L2 | Aux2]) :-
        check_blacks_adj_row(L1, L2),
        check_blacks_adj(Aux1, Aux2).                        

check_blacks_adj_row([_], [_]).
                        
check_blacks_adj_row([A, B | L1], [C, D | L2]) :-
        sum([A,B], #<, 2),
        sum([C,D], #<, 2),
        check_blacks_adj_row([B | L1], [D | L2]).                  
                        
check_whites_bloc(Aux, SizeBoard, SizeBoard, SizeBoard) :-
        get_square(Aux, SizeBoard, SizeBoard, Square),
        ((Square #= 0, restric_tip_inferior_rigth(Aux, SizeBoard));
        (Square #\= 0, true)).

check_whites_bloc(Aux, SizeBoard, Row, SizeBoard) :-
        get_square(Aux, SizeBoard, Row, Square),
        ((Row =:= 1,Square #= 0, restric_tip_superior_rigth(Aux, SizeBoard));
        (Row > 1,Square #= 0,  restric_row_rigth(Aux, SizeBoard, Row));
        (Square #\= 0, true)),
        Row1 is Row + 1,
        check_whites_bloc(Aux, 1, Row1, SizeBoard).

check_whites_bloc(Aux, Col, Row, SizeBoard) :-
        get_square(Aux, Col, Row, Square),
        (((Col =:= 1, Row =:= 1, Square #= 0), restric_tip_superior_left(Aux));
        ((Row =:= 1, Col > 1, Col < SizeBoard, Square #= 0), restric_row_superior(Aux,Col));
        ((Row > 1,Row < SizeBoard, Col =:= 1,Square #= 0),restric_row_left(Aux, Row));
        ((Row > 1, Col > 1, Square #= 0), restric_meio_board(Aux,Row,Col));
        ((Row =:= SizeBoard, Col > 1), Square #= 0, restric_row_inferior(Aux, Col,SizeBoard));
        ((Row =:= SizeBoard, Col =:= 1), Square #= 0, restric_tip_inferior_left(Aux, SizeBoard));                                      
        (Square #\= 0, true)),
        Col1 is Col + 1,
        check_whites_bloc(Aux, Col1, Row, SizeBoard).


                                        
restric_tip_superior_rigth(Aux, SizeBoard) :-
        ColLeft #= SizeBoard - 1,
        Col #= SizeBoard,
        get_square(Aux, ColLeft, 1, Square1), 
        get_square(Aux, Col, 2, Square2), 
        sum([Square1, Square2], #=<, 1).
                        
restric_tip_inferior_left(Aux, SizeBoard) :-
        ColRigth #= 2,
        Col #= 1,
        RowTop is SizeBoard - 1,
        get_square(Aux, ColRigth, SizeBoard, Square1), 
        get_square(Aux, Col, RowTop, Square2),
        sum([Square1, Square2], #=<, 1).

restric_meio_board(Aux,Row,Col) :-
        ColRigth #= Col + 1,
        ColLeft #= Col - 1,
        RowTop is Row - 1,
        RowBot is Row + 1,
        ColPiece #= Col,
        get_square(Aux, ColRigth, Row, Square1), 
        get_square(Aux, ColLeft, Row, Square2),
        get_square(Aux, ColPiece, RowTop, Square3),
        get_square(Aux, ColPiece, RowBot, Square4),
        sum([Square1,Square2,Square3,Square4], #=< ,3).

restric_tip_inferior_rigth(Aux, SizeBoard) :-
        RowTop is SizeBoard - 1,
        ColLeft #= SizeBoard -1,
        Col #= SizeBoard,
        get_square(Aux, Col, RowTop, Square1), 
        get_square(Aux, ColLeft,SizeBoard, Square2), 
        sum([Square1,Square2], #=< ,1).
                        
restric_tip_superior_left(Aux) :-
        ColRigth #= 2,
        Col #= 1,
        get_square(Aux, ColRigth, 1, Square1), 
        get_square(Aux,Col,2, Square2), 
        sum([Square1,Square2], #=<, 1).
                        
restric_row_inferior(Aux, Col,SizeBoard) :-
        ColRigth #= Col + 1,
        ColLeft #=  Col - 1,
        RowTop is SizeBoard - 1,
        get_square(Aux, ColRigth, SizeBoard,Square1),
        get_square(Aux, ColLeft, SizeBoard, Square2),
        get_square(Aux, Col, RowTop, Square3),
        sum([Square1,Square2,Square3], #=<, 2).
                        
restric_row_superior(Aux,Col) :-
        ColPiece #= Col,
        ColRigth #= Col + 1,
        ColLeft #= Col - 1,
        get_square(Aux, ColRigth, 1, Square1),
        get_square(Aux, ColLeft, 1, Square2),
        get_square(Aux, ColPiece, 2, Square3),
        sum([Square1,Square2,Square3], #=<, 2).
                        
restric_row_rigth(Aux, SizeBoard, Row) :-
        ColLeft is SizeBoard - 1,
        RowTop is Row - 1,
        RowBot is Row + 1,
        get_square(Aux, ColLeft, Row, Square1),
        get_square(Aux, SizeBoard, RowTop, Square2),
        get_square(Aux, SizeBoard, RowBot, Square3),
        sum([Square1,Square2,Square3], #=<, 2).
                        
restric_row_left(Aux, Row) :-
        RowTop is Row - 1,
        RowBot is Row + 1,
        ColRigth #= 2,
        Col #= 1,
        get_square(Aux, Col, RowTop, Square1),
        get_square(Aux, Col, RowBot, Square2),
        get_square(Aux, ColRigth,Row, Square3),
        sum([Square1,Square2,Square3], #=<, 2).
   
check_double([], [], [_A|_As], _Line).

check_double([L|R], [T|Ts], BoardTrans, Line) :-
        check_double_lis(L, T, BoardTrans, Line, 1),
        Line1 is Line + 1,
        check_double(R, Ts, BoardTrans, Line1).

check_double_lis(L, _T, _BoardTrans, _Line, Column) :-
          length(L, Len),
          Column =:= Len + 1.

check_double_lis(L, T, BoardTrans, Line, Column) :-
          nth1(Column, L, Elem),
                  nth1(Column, BoardTrans, ColumnList),
          nth1(Column, T, Val),
          member(Elem, Column, L, 1, X),
          member(Elem, Line, ColumnList, 1, Y),
          (
                        (X =:= -1, Y =:= -1, Val #= 0, !) ;
                        true
                  ),
          C is Column + 1,
          check_double_lis(L, T, BoardTrans, Line, C).

check_double_lis(L, T, BoardTrans, Line, Column) :-
          C is Column + 1,
          check_double_lis(L, T, BoardTrans, Line, C).

blacks_per_row([],[],[],[]).
blacks_per_row([L|Ls],[TL|TLs],[Aux|Auxs],[TAux|TAuxs]):-
           group_repeated(L, Aux, N, 0),
           number_blacks_lis(N),
           group_repeated(TL,TAux,T,0),
           number_blacks_lis(T),
           blacks_per_row(Ls,TLs,Auxs, TAuxs).
                        

number_blacks_lis([]).
number_blacks_lis([Lista | Goup]) :-
           length(Lista, N),
           (
           (N =< 1) ;
           (Sum is N-1, sum(Lista, #=, Sum))
           ),
           number_blacks_lis(Goup).           
                  
appendTails(Ls, As) :-
    maplist(list_tail, Ls, T),
    append(T, As).

list_tail([_|T], T).

group_repeated([], [], [], _).

group_repeated([E | Row], [T | Ts], [[T | Lista] | Goup], Processed) :-
                \+member(E, Processed), !,
                search_repeated(Row, Ts, E, Lista),
                append([E], Processed, Process),
                group_repeated(Row, Ts, Goup, Process).
                
group_repeated([_ | Row], [_ | Ts], Goup, Processed) :-
                group_repeated(Row, Ts, Goup, Processed).

search_repeated([], [], _, []).
                                
search_repeated([E | Row], [T | Ts], Elemento, [T | Lista]) :-
        E =:= Elemento, !,
        search_repeated(Row, Ts, Elemento, Lista).
        
search_repeated([_E | Row], [_T | Ts], Elemento, Lista) :-
        search_repeated(Row, Ts, Elemento, Lista).
        
