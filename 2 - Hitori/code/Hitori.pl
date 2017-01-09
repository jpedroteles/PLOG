:- include('Restrictions.pl').


mainMenu(1):- createBoard(5, Board), solveHitori(Board), goBack.
mainMenu(2):- createBoard(7, Board), solveHitori(Board), goBack.
mainMenu(3):- createBoard(8, Board), solveHitori(Board), goBack.
mainMenu(4):- createBoard(12, Board), solveHitori(Board), goBack.
mainMenu(5).

mainMenu:-
	write('HITORI'),nl, nl,
	write('Select board size:'),nl,
	write('(1) 5x5'),nl,
	write('(2) 7x7'),nl,
	write('(3) 8x8'),nl,
	write('(4) 12x12'),nl,
	write('(5) Exit'),nl, nl,
	write('Input (end with .) :'), nl,
	read(Input),
	member(Input, [1,2,3,4,5]) ->mainMenu(Input);
		mainMenu.


startBoard(N,N,[]).
startBoard(N, Index, [L|H]) :-
	length(L, N),                         
	domain(L, 0, 1), 
	Index1 is Index + 1,
	startBoard(N, Index1, H).

getSolution(Board, Solution):-
	length(Board, N),
	startBoard(N, 0, Solution),
	transpose(Board, BoardTrans),
	transpose(Solution, Aux),

	check_double(Board, Solution, BoardTrans, 1),
	blacks_per_row(Board,BoardTrans,Solution,Aux),
	check_blacks_adj(Solution, Aux),
	check_whites_bloc(Solution,1,1, N).

solveHitori(Board):-
	write('Initial Board:'), nl,	
	printBoard(Board),

	statistics(runtime, [T0|_]),
	
	getSolution(Board, Solution),
	appendTails(Solution, Vars),
	labeling([time_out(1000, _)], Vars),

	statistics(runtime, [T1|_]),

	parseSolution(Board,Solution, Final), 
	nl, write('Solved Board:'), nl,
	printBoard(Final),

	T is T1 - T0, nl,
	format('Solution found in ~3d sec.~n', [T]), nl, 
	fd_statistics, nl.

goBack:-
	write('(1) - Main Menu'), nl,nl,
	write('Input (end with .) :'), nl,
	read(Input),
	(Input =:= 1 ->mainMenu;
		goBack).

hitori:- mainMenu.
