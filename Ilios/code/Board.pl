/*--------------------------------------------------PRINT BOARD START------------------------------------------------*/
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
		Value =:= 2 -> write('    /');
		write('  |  '));
	Orientation =:= "E" ->
		(Value =:= 1 -> write('     ');
		Value =:= 2 -> write('    /');
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
		printElementMid2(Tail, " ").
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
		Value =:= 2 -> write('/    ');
		write('  |  '));
	Orientation =:= "E" ->
		(Value =:= 1 -> write('     ');
		Value =:= 2 -> write('/    ');
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

/*--------------------------------------------------PRINT BOARD END--------------------------------------------------*/

/*--------------------------------------------------CREATE BOARDS---------------------------------------------------*/

createBoard(6):- 
	/*Board = ([
				[["O", 8, -1], ["Y", 10, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[["G", 2, "E"], ["B", 2, "N"], ["B", 3, "S"], ["B", 10, -1],["O", 3, "W"],[-1, -1, -1]], 
				[[-1, -1, -1], ["B", 1, "S"], ["O", -1, -1], ["B", -1, -1],["B", 2, "N"],[-1, -1, -1]], 
				[["B", 8, -1], ["B", 4, -1], ["O", 1, "N"], ["B", 4, -1],["B", 2, "N"],[-1, -1, -1]], 
				[["B", 10, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]] 
					]),*/
	Board = ([
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]] 
					]),

	/*Board = ([
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]] 
					]),*/
	Size = 6,
	setGameBoard(Board,Size).
createBoard(7):- 
	Board = ([
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1]] 
					]),
	Size = 7,
	setGameBoard(Board,Size).
createBoard(8):- 
	Board = ([
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], [-1, -1, -1], [-1, -1, -1]]
					]),
	Size = 8,
	setGameBoard(Board,Size).


/*----------------------------------------------------FUNCTIONS------------------------------------------------------*/


getElement(Board, Size, X, Y, Element):-
	Line is Size - Y,
	nth0(Line, Board, Row),
	Column is X - 97,
	nth0(Column, Row, Element).

%get("a",1,Element)	
get(X,Y, Element):- 
	getGameBoard(Board,Size), 
	getElement(Board,Size, X, Y, Element).

%get(0,5,Element)
get2(X,Y,Element):-
	getBoard(Board),
	nth0(Y, Board, Row),
	nth0(X, Row, Element).

cellHasNoTeam(X,Y):-
	get(X,Y,Element),
	nth0(0,Element,Team),
	Team =:= -1 -> true; false.

getCellTeam(X,Y,Team):-
	get(X,Y,Element),
	nth0(0, Element, Team).
getCellValue(X,Y,Value):-
	get(X,Y,Element),
	nth0(1, Element, Value).
getCellOrientation(X,Y,Orientation):-
	get(X,Y,Element),
	nth0(2, Element, Orientation).


captureCell(X,Y):-
	getCellTeam(X,Y,Team),
	getCellValue(X,Y,Value),
	member(Team,["O","B","G","Y"])->
		(append([Team],[-1],List),
		append(List,[-1], NewCell),
		getTeamID(Team, ID),
		increaseScore(ID,Value),
		replace(X,Y,NewCell)
		).

setCellTeam(X,Y,1):-
	getCellValue(X,Y,Value),
	getCellTeam(X,Y,Team),
	Team \= "O",
	Value \= (-1) ->
	(getCellOrientation(X,Y,Orientation),
	append(["O"],[Value],List),
	append(List,[Orientation], NewCell),
	replace(X,Y,NewCell)).
setCellTeam(X,Y,2):-
	getCellValue(X,Y,Value),
	getCellTeam(X,Y,Team),
	Team \= "B",
	Value \= (-1) ->
	(getCellOrientation(X,Y,Orientation),
	append(["B"],[Value],List),
	append(List,[Orientation], NewCell),
	replace(X,Y,NewCell)).
setCellTeam(X,Y,3):-
	getCellValue(X,Y,Value),
	getCellTeam(X,Y,Team),
	Team \= "G",
	Value \= (-1) ->
	(getCellOrientation(X,Y,Orientation),
	append(["G"],[Value],List),
	append(List,[Orientation], NewCell),
	replace(X,Y,NewCell)).
setCellTeam(X,Y,4):-
	getCellValue(X,Y,Value),
	getCellTeam(X,Y,Team),
	Team \= "Y",
	Value \= (-1) ->
	(getCellOrientation(X,Y,Orientation),
	append(["Y"],[Value],List),
	append(List,[Orientation], NewCell),
	replace(X,Y,NewCell)).

replaceY([L|Ls], X, 0, Element, [R|Ls]):-
  replaceX(L, X, Element, R).
replaceY([L|Ls], X, Y, Element, [L|Rs]) :-
  Y > 0,
  Y1 is Y-1,
  replaceY(Ls, X, Y1, Element, Rs).

replaceX([_|Cs], 0, Element, [Element|Cs]).
replaceX([C|Cs], X, Element, [C|Rs]):-
  X > 0,
  X1 is X-1,
  replaceX(Cs, X1, Element, Rs).  

replace(X,Y, NewElement):- 
	getGameBoard(Board,Size), 
	Column is X - 97, Column > -1, Column < Size,
	Line is Size - Y, Line > -1, Line < Size,
 	replaceY(Board, Column, Line, NewElement, NewBoard),
 	setBoard(NewBoard).


