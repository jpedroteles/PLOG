:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(between)).
:- use_module(library(aggregate)).


board([  [8,8,3,1,4,1,2,5], 
         [6,4,1,6,7,2,7,3],
         [3,5,5,7,7,8,6,4],
         [5,8,2,6,3,4,3,8],
         [5,2,8,2,5,2,3,2],
         [2,8,7,4,4,5,1,6],
         [8,1,2,3,6,7,8,2],
         [7,6,5,8,3,3,7,5]]
         ).

displayBoard(Board) :-
           length(Board, N),
           nl,
           display_lines_length(N),
           display_board(Board, N).

display_board([L,L1|Ls], N):-
           write('|'),
           displayLine(L), nl,
           display_division_lines(N),
           display_board([L1|Ls],N).

display_board([Ls],N) :-
           write('|'),
           displayLine(Ls),nl,
           display_lines_length(N).

display_board([],_N) .

displayLine([L|Ls]) :-
           write(L),write('|'),
           displayLine(Ls).

displayLine([]).

display_lines_length(N) :-    
           ((N =:= 5, write('|---------|'),nl);
           (N =:= 6, write('|-----------|'),nl);
           (N =:= 7, write('|-------------|'),nl);
           (N =:= 8, write('|---------------|'),nl);
           (N >= 8, write(''),nl)).
display_division_lines(N) :-
           ((N =:= 5, write('|-+-+-+-+-|'),nl);
           (N =:= 6, write('|-+-+-+-+-+-|'),nl);
           (N =:= 7, write('|-+-+-+-+-+-+-|'),nl);
           (N =:= 8, write('|-+-+-+-+-+-+-+-|'),nl);
           (N >= 8, write(' '),nl)).


parse_solution([],[],[]).
parse_solution([L|Ls],[R|Rs],[F|Fs]):-        
           parse_line(L,R,F),
           parse_solution(Ls,Rs,Fs).

parse_line([],[],[]).
parse_line([L|Ls],[R|Rs],[F|Fs]):-  
           ((R =:= 0, F is L);
           (R =:= 1, F = 'X')),   
           parse_line(Ls,Rs,Fs).      