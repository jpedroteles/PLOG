:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).
:- use_module(library(between)).
:- use_module(library(aggregate)).


/*board([  [8,8,3,1,4,1,2,5], 
	[6,4,1,6,7,2,7,3],
	[3,5,5,7,7,8,6,4],
	[5,8,2,6,3,4,3,8],
	[5,2,8,2,5,2,3,2],
	[2,8,7,4,4,5,1,6],
	[8,1,2,3,6,7,8,2],
	[7,6,5,8,3,3,7,5]]
	).
*/

createBoard(5, Board):- 
Board = ([
	[4,4,5,3,2],
	[1,3,5,2,5],
	[1,5,5,1,3],
	[4,3,2,2,5],
	[3,2,4,5,1]
	]).
createBoard(7, Board):-
Board = ([
	[1,6,7,3,4,2,2],
	[1,4,3,1,5,2,2],
	[4,3,7,2,3,1,5],
	[5,5,5,4,2,6,6],
	[3,1,2,4,7,5,6],
	[2,2,6,5,1,3,1],
	[2,2,4,7,6,4,3]
	]).
createBoard(8, Board):- 
Board = ([
	[4,5,6,8,3,7,8,1],
	[1,1,1,4,8,6,7,2],
	[5,4,7,6,3,1,2,8],
	[7,4,5,3,2,8,1,6],
	[2,2,2,7,1,4,4,4],
	[8,7,4,5,5,2,6,3],
	[6,7,8,5,5,4,3,2],
	[3,3,3,2,4,6,1,7]
	]).

/*--------------------------------------------------PRINT BOARD START------------------------------------------------*/
/*PRINT ROWS*/
printRowTop([]):- write('##'), nl.
printRowTop([_|Tail]):-
	write('##     '),
	printRowTop(Tail).

printRowMid([]):- write('##'), nl.
printRowMid([Value|Tail]):-
	write('##  '),
	write(Value), 
	write('  '),
	printRowMid(Tail).

printRowBot([]):- write('##').
printRowBot([_|Tail]):-
	write('##     '),
	printRowBot(Tail).

/*BORDER*/
printBorderAux(0):-	write('##'), nl.
printBorderAux(N):-
	write('#######'),
	N1 is N-1,
	printBorderAux(N1).
printBorder(N):-
	nl,
	write('  '),
	printBorderAux(N).

/*LETTERS*/
printLetters(Size, Size):- nl.
printLetters(Size, N):-
	format('   ~32r   ',10+N),
	N1 is N+1,
	printLetters(Size, N1).

printBoard(Size,_,Size):-
	printBorder(Size),
	write('   '),
	printLetters(Size, 0).

printBoard(Size, Board, N):-
	nth0(N, Board, Row),
	printBorder(Size),
	write('  '),
	printRowTop(Row),
	format('~D ', Size - N),
	printRowMid(Row),
	write('  '),
	printRowBot(Row),
	N1 is N+1,
	printBoard(Size, Board, N1).

printBoard(Board):-
	length(Board, Size),
	printBoard(Size, Board, 0).



parseSolution([],[],[]).
parseSolution([L|Ls],[R|Rs],[F|Fs]):-        
	parseLine(L,R,F),
	parseSolution(Ls,Rs,Fs).

parseLine([],[],[]).
parseLine([L|Ls],[R|Rs],[F|Fs]):-  
	(
		(R =:= 0, F is L); (R =:= 1, F = 'X')
	),   
	parseLine(Ls,Rs,Fs).      