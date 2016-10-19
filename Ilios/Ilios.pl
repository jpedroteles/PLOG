/*PRINT ROWS*/
printRowTop([]):- write('##'), nl.
printRowTop([Head|Tail]):-
  write('##'),
  printElementTop(Head),
  printRowTop(Tail).

printRowMid([]):- write('##'), nl.
printRowMid([Head|Tail]):-
  write('##'),
  printElementMid(Head),
  printRowMid(Tail).

printRowBot([]):- write('##').
printRowBot([Head|Tail]):-
  write('##'),
  printElementBot(Head),
  printRowBot(Tail).

/*TOP*/
checkValueTop(-1):- write('     ').
checkValueTop(4):- write('\\   /').
checkValueTop(8):- write('\\ | /').
checkValueTop(10):- write('     ').

checkOrientationTop(Orientation, Value):-
	Orientation =:= "N" ->
		(Value =:= 1 -> write('  |  ');
		Value =:= 2 -> write('\\    ');
			write('  |  '));
	Orientation =:= "S" ->
		(Value =:= 1 -> write('     ');
		Value =:= 2 -> write('\\    ');
			write('     '));
	Orientation =:= "W" ->
		(Value =:= 1 -> write('     ');
		Value =:= 2 -> write('     /');
		write('  |  '));
	Orientation =:= "E" ->
		(Value =:= 1 -> write('     ');
		Value =:= 2 -> write('     /');
		write('  |  '));
	write('Invalid Orientation').

printElementTop([Team|Tail]):-
	Team =:= -1 -> write('     ');
	printElementTop2(Tail).
printElementTop2([Value|Tail]):-
	member(Value, [-1,4,8,10]) -> checkValueTop(Value);
	checkOrientationTop(Tail, Value).

/*MID*/
checkValueMid(-1, Team):- format('  ~s  ', [Team]).
checkValueMid(2, Team):- format('  2~s ', [Team]).
checkValueMid(4, Team):- format('  4~s ', [Team]).
checkValueMid(8, Team):- format('- 8~s-', [Team]).
checkValueMid(10, Team):- format(' 10~s ', [Team]).

checkOrientationMid(Orientation, Value, Team):-
	Orientation =:= "N" ->
		(Value =:= 1 -> format('  1~s ', [Team]);
			format('- 3~s-', [Team]));
	Orientation =:= "S" ->
		(Value =:= 1 -> format('  1~s ', [Team]);
			format('- 3~s-', [Team]));
	Orientation =:= "W" ->
		(Value =:= 1 -> format('- 1~s ', [Team]);
			format('- 3~s ', [Team]));
	Orientation =:= "E" ->
		(Value =:= 1 -> format('  1~s-', [Team]);
			format('  3~s-', [Team]));
	write('Invalid Orientation').

printElementMid([Team|Tail]):-
	Team =:= -1 -> write('     ');
	member(Team, ["O","B","G","Y"]) ->printElementMid2(Tail, Team);
		write('Invalid Team').
printElementMid2([Value|Tail], Team):-
	member(Value, [-1,2,4,8,10]) -> checkValueMid(Value, Team);
		checkOrientationMid(Tail, Value, Team).

/*BOT*/
checkValueBot(-1):- write('     ').
checkValueBot(4):- write('/   \\').
checkValueBot(8):- write('/ | \\').
checkValueBot(10):- write('     ').

checkOrientationBot(Orientation, Value):-
	Orientation =:= "N" ->
		(Value =:= 1 -> write('     ');
		Value =:= 2 -> write('    \\');
			write('     '));
	Orientation =:= "S" ->
		(Value =:= 1 -> write('  |  ');
		Value =:= 2 -> write('\\    ');
			write('  |  '));
	Orientation =:= "W" ->
		(Value =:= 1 -> write('     ');
		Value =:= 2 -> write('/     ');
		write('  |  '));
	Orientation =:= "E" ->
		(Value =:= 1 -> write('     ');
		Value =:= 2 -> write('/     ');
		write('  |  '));
	write('Invalid Orientation').

printElementBot([Team|Tail]):-
	Team =:= -1 -> write('     ');
	printElementBot2(Tail).
printElementBot2([Value|Tail]):-
	member(Value, [-1,4,8,10]) ->	checkValueBot(Value);
	checkOrientationBot(Tail, Value).

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
  format('   ~16r   ',10+N),
  N1 is N+1,
  printLetters(Size, N1).

getRow(End,[],0,End).
getRow([Head|Tail],[Head|Rest],N,End):-
	N1 is N -1,
	getRow(Tail,Rest,N1,End).

printBoard([], Size, _):-
  printBorder(Size),
  write('   '),
  printLetters(Size, 0).
printBoard(List, Size, N):-getRow(List,Row,Size,Rest),
  printBorder(Size),
  write('  '),
  printRowTop(Row),
  format('~D ', N),
  printRowMid(Row),
  write('  '),
  printRowBot(Row),
  N1 is N-1,
  printBoard(Rest, Size, N1).

initialBoard(Board):- Board = ([
                                  [-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], 
                                  [-1, -1, -1], ["O", 2, "N"], ["B", 3, "S"], ["B", 10, -1],["O", 3, "W"],[-1, -1, -1], 
                                  [-1, -1, -1], ["B", 1, "S"], ["O", -1, -1], ["B", -1, -1],["B", 2, "N"],[-1, -1, -1], 
                                  ["B", 8, -1], ["B", 4, -1], ["O", 1, "N"], ["B", 4, -1],["B", 2, "N"],[-1, -1, -1], 
                                  ["B", 10, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], 
                                  [-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1] 
                                ]).

main:- initialBoard(Board), printBoard(Board, 6, 6).