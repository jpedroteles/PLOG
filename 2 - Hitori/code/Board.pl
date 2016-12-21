:- use_module(library(lists)).

:-      dynamic
gameBoard/2.

setGameBoard(_,_):-
retract(gameBoard(_,_)),
fail.
setGameBoard(Board,Size) :-
assert(gameBoard(Board,Size)).
setBoard(Board):-
getBoardSize(Size),
setGameBoard(Board, Size).

getGameBoard(Board, Size):-
gameBoard(Board, Size).
getBoard(Board):-
gameBoard(Board,_).
getBoardSize(Size):-
gameBoard(_, Size).


createBoard(5):- 
Board = ([ 
	[[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]], 
	[[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]], 
	[[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]], 
	[[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]], 
	[[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]]
	]),
Size = 5,
setGameBoard(Board,Size).

createBoard(7):-
/*BEFORE
Board = ([
	[[1, -1], [6, -1], [7, -1], [3, -1],[4, -1],[2, -1], [2, -1]], 
	[[1, -1], [4, -1], [3, -1], [1, -1],[5, -1],[2, -1], [2, -1]], 
	[[4, -1], [3, -1], [7, -1], [2, -1],[3, -1],[1, -1], [5, -1]], 
	[[5, -1], [5, -1], [5, -1], [4, -1],[2, -1],[6, -1], [6, -1]], 
	[[3, -1], [1, -1], [2, -1], [4, -1],[7, -1],[5, -1], [6, -1]], 
	[[2, -1], [2, -1], [6, -1], [5, -1],[1, -1],[3, -1], [1, -1]], 
	[[2, -1], [2, -1], [4, -1], [7, -1],[6, -1],[4, -1], [3, -1]]
	]),*/

/*DURING*/
Board = ([
	[[1, -1], [6, -1], [7, -1], [3, -1],[4, 0],[2, 0], [2, 1]], 
	[[1, -1], [4, -1], [3, -1], [1, -1],[5, 0],[2, 1], [2, 0]], 
	[[4, 0], [3, -1], [7, 0], [2, -1],[3, -1],[1, 0], [5, 0]], 
	[[5, 1], [5, 0], [5, 1], [4, 0],[2, -1],[6, -1], [6, -1]], 
	[[3, 0], [1, 0], [2, 0], [4, -1],[7, -1],[5, -1], [6, -1]], 
	[[2, 0], [2, 1], [6, 0], [5, -1],[1, -1],[3, 0], [1, -1]], 
	[[2, 1], [2, 0], [4, 0], [7, -1],[6, -1],[4, -1], [3, -1]]
	]),

/*AFTER
Board = ([
	[[1, 0], [6, 0], [7, 1], [3, 0],[4, 0],[2, 0], [2, 1]], 
	[[1, 1], [4, 0], [3, 0], [1, 0],[5, 0],[2, 1], [2, 0]], 
	[[4, 0], [3, 0], [7, 0], [2, 0],[3, 1],[1, 0], [5, 0]], 
	[[5, 1], [5, 0], [5, 1], [4, 0],[2, 0],[6, 0], [6, 1]], 
	[[3, 0], [1, 0], [2, 0], [4, 1],[7, 0],[5, 0], [6, 0]], 
	[[2, 0], [2, 1], [6, 0], [5, 0],[1, 1],[3, 0], [1, 0]], 
	[[2, 1], [2, 0], [4, 0], [7, 0],[6, 0],[4, 1], [3, 0]]
	]),*/

Size = 7,
setGameBoard(Board,Size).


createBoard(8):- 
Board = ([
	[[4, -1], [5, -1], [6, -1], [8, -1],[3, -1],[7, -1], [8, -1], [1, -1]], 
	[[1, -1], [1, -1], [1, -1], [4, -1],[8, -1],[6, -1], [7, -1], [2, -1]], 
	[[5, -1], [4, -1], [7, -1], [6, -1],[3, -1],[1, -1], [2, -1], [8, -1]], 
	[[7, -1], [4, -1], [5, -1], [3, -1],[2, -1],[8, -1], [1, -1], [6, -1]], 
	[[2, -1], [2, -1], [2, -1], [7, -1],[1, -1],[4, -1], [4, -1], [4, -1]], 
	[[8, -1], [7, -1], [4, -1], [5, -1],[5, -1],[2, -1], [6, -1], [3, -1]], 
	[[6, -1], [7, -1], [8, -1], [5, -1],[5, -1],[4, -1], [3, -1], [2, -1]], 
	[[3, -1], [3, -1], [3, -1], [2, -1],[4, -1],[6, -1], [1, -1], [7, -1]]
	]),
Size = 8,
setGameBoard(Board,Size).

/*--------------------------------------------------PRINT BOARD START------------------------------------------------*/
/*PRINT ROWS*/
printRowTop([]):- write('##'), nl.
printRowTop([_|Tail]):-
write('##     '),
printRowTop(Tail).

printRowMid([]):- write('##'), nl.
printRowMid([[Value|[State|_]]|Tail]):-
write('##'),
printElementMid(Value,State),
printRowMid(Tail).

printRowBot([]):- write('##').
printRowBot([_|Tail]):-
write('##     '),
printRowBot(Tail).

/*MID*/

printElementMid(Value, -1):-
format('  ~D  ', Value).
printElementMid(Value, 0):-
format(' (~D) ', Value).
printElementMid(Value, 1):-
format(' *~D* ', Value).
printElementMid(_,_).

/*BORDER*/
printBorderAux(0):- 
write('##'),
nl.
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

printBoard(_, Size, Size):-
printBorder(Size),
write('   '),
printLetters(Size, 0).
printBoard(List, Size, N):-
nth0(N, List, Row),
printBorder(Size),
write('  '),
printRowTop(Row),
format('~D ', Size - N),
printRowMid(Row),
write('  '),
printRowBot(Row),
N1 is N+1,
printBoard(List, Size, N1).

printBoard:-
getGameBoard(Board,Size),
printBoard(Board, Size, 0).


hitori:-
createBoard(7),
printBoard.