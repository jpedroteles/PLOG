/*LIBRARIES*/
:-	use_module(library(lists)),
	use_module(library(random)).
:- include('Objects.pl').

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
	Board = ([
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], ["O", 2, "N"], ["B", 3, "S"], ["B", 10, -1],["O", 3, "W"],[-1, -1, -1]], 
				[[-1, -1, -1], ["B", 1, "S"], ["O", -1, -1], ["B", -1, -1],["B", 2, "N"],[-1, -1, -1]], 
				[["B", 8, -1], ["B", 4, -1], ["O", 1, "N"], ["B", 4, -1],["B", 2, "N"],[-1, -1, -1]], 
				[["B", 10, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]], 
				[[-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1]] 
					]),
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

/*GET*/
getElement(Board, Size, X, Y, Element):-
	Line is Size - Y,
	nth0(Line, Board, Row),
	Column is X - 97,
	nth0(Column, Row, Element),
	printElementTop(Element),
	nl,
	printElementMid(Element),
	nl,
	printElementBot(Element).
	
get(X,Y, Element):- 
	getGameBoard(Board,Size), 
	getElement(Board,Size, X, Y, Element).


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
	write(Column), nl,
	Line is Size - Y, Line > -1, Line < Size,
	write(Line), nl,
 	replaceY(Board, Column, Line, NewElement, NewBoard),
 	setBoard(NewBoard).


/*----------------------------------------------------MENUS--------------------------------------------------------*/

logo:- nl,
	write('           ___'), nl,
	write('           \\\\||'), nl,
	write('          ,\'_,-\\'), nl, 
	write('          ;\'____\\'), nl, 
	write('          || =\\=|'), nl, 
	write('          ||  - |'), nl,                           
	write('     ,---\',_--\'\'-,,---------,--,----_,'), nl,         
	write('    / `-._- _--/,,|  ___,,--\'--\'._<') , nl,   
	write('   /-._,  `-.__;,,|'), nl,                           
	write('  /   ;\\      / , ;'), nl,                         
	write(' /  ,\' | _ - \',/, ;'), nl,
	write('(  (   |     /, ,,;'), nl,
	write(' \\  \\  |     \',,/,;'), nl,
	write('  \\  \\ |    /, / ,;'), nl,
	write(' (| ,^.|   / ,, ,/;'), nl,
	write('  `-\',/ `-,_,, ,/,;'), nl,
	write('       `-._ `-._,,;'), nl,
	write('       |/,,`-._ `-.'), nl,
	write('       |, ,;, ,`-._\\'), nl,
	write('     ___ _ _'), nl,           
 	write('    |_ _| (_) ___  ___'), nl, 
	write('     | || | |/ _ \\/ __|'), nl,
  write('     | || | | (_) \\__ \\'), nl,
	write('    |___|_|_|\\___/|___/'), nl, nl.

instructions:- nl,
        write('Instructions:'),nl,
        write('**Rule 1 Deploy & Occupy**'),nl,
        write(' Place one warrior from your hand on an open square. Your warrior must point to at least one tile occupied'),nl,
        write('by an opponent, or to an unoccupied iron weapon'),nl,
        write('  -Your warrior cannot point only to one of your own occupied tiles, or only at an open square. However,'),nl,
        write('  as long as at least one ray makes a valid attack, the whole play is valid.'),nl,
        write('  -If you are unable to deploy a warrior on any battleground, reveal your hand to con#rm. You may then place'),nl,
        write('  a warrior on any open square. However, if you can make a valid play, you must make that play.'),nl,
        write('**Rule 2 Raid**'),nl,
        write(' After deploying your warrior, you now raid all of the warrior and iron weapons tiles that your warrior'),nl,
        write('points to. Start by removing your opponents disks.Then place your disks on the warriors you are'),nl,
        write('raiding. Finally, place your disk on the original warrior you placed.'),nl,
        write('**Rule 3 Capture Plunder**'),nl,
        write(' When a tile is completely surrounded by other tiles, occupation disks, or the battlefield\'s edge, its'),nl,
        write('plunder can be captured. The surrounded warrior is removed and kept by the player whose color disk'),nl,
        write('occupies the warrior. The occupying disk is left behind to mark the victory.'),nl,
        write('**Rule 4 Reinforcements**'),nl,
        write(' Draw a face-down warrior and add it to your hand.'),nl,
        write('**End of Play**'),nl,
        write(' Play ends when no open square remains'),nl, 
        write('Gather your plunder by adding the number on the warrior tiles and iron weapons you capture. The winner is'),nl,
        write('the player with the most plunder. In the case of a draw, the player with the most occupation disks on the'),nl,
        write('battlefield wins.'),nl,nl,
        write('(2) - Exit'), nl,
        write('Input (end with .) :'), nl,
        read(Input),
        member(Input, [1,2]) ->instructionsMenu(Input);
                mainMenu.

/*----------------------------------------------------MENUS--------------------------------------------------------*/

mainMenu(1):- playMenu.
mainMenu(2):- instructionsMenu.
mainMenu(3):- write('Exit'),nl.

mainMenu:- logo,
        write('Main Menu'), nl,
        write('(1) - Play'), nl,
        write('(2) - Instructions'), nl,
        write('(3) - Exit'), nl, nl,
        write('Input (end with .) :'), nl,
        read(Input),
        member(Input, [1,2,3]) ->mainMenu(Input);
                mainMenu.

instructionsMenu:-instructions.
instructionsMenu(2):-mainMenu.

playMenu(1):- write('Player vs Player'), nl.
playMenu(2):- write('Player vs Computer'), nl, selectDifficultyMenu.
playMenu(3):- write('Computer vs Computer'), nl, selectDifficultyMenu.
playMenu(4):- mainMenu.

playMenu:- nl,
	write('Play'), nl,
	write('(1) Player vs Player'), nl,
	write('(2) Player vs Computer'), nl,
	write('(3) Computer vs Computer'), nl,
	write('(4) Back'), nl, nl,
	write('Input (end with .) :'), nl,
	read(Input),
	member(Input, [1,2,3,4]) -> playMenu(Input);
		playMenu.

selectDifficultyMenu(1):- write('Difficulty = Easy'), nl.
selectDifficultyMenu(2):- write('Difficulty = Advanced'), nl.
selectDifficultyMenu(3):- playMenu.

selectDifficultyMenu:- nl,
	write('Select Difficulty'), nl,
	write('(1) - Easy'), nl,
	write('(2) - Advanced'), nl,
	write('(3) - Back'), nl, nl,
	write('Input (end with .) :'), nl,
	read(Input),
	member(Input, [1,2,3]) ->selectDifficultyMenu(Input);
		selectDifficultyMenu.