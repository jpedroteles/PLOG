/*LIBRARIES*/
:- use_module(library(lists)),
	use_module(library(random)).
:- include('Board.pl').
:- include('Elements.pl').
:- include('Logic.pl').

/*----------------------------------------------------FUNCTIONS------------------------------------------------------*/

/*GET*/
getElement(Board, Size, X, Y, Element):-
	Line is Size - Y,
	nth0(Line, Board, Row),
	Column is X - 97,
	nth0(Column, Row, Element).
	
get(X,Y, Element):- 
	getGameBoard(Board,Size), 
	getElement(Board,Size, X, Y, Element).


getCellTeam(X,Y,Team):-
	get(X,Y,Element),
	nth0(0, Element, Team).
getCellValue(X,Y,Value):-
	get(X,Y,Element),
	nth0(1, Element, Value).
getCellOrientation(X,Y,Orientation):-
	get(X,Y,Element),
	nth0(2, Element, Orientation).

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

replaceElementInList([_|T], 0, Element, [Element|T]).
replaceElementInList([H|T], I, Element, [H|R]):- 
	I > 0, 
	NI is I-1, 
	replaceElementInList(T, NI, Element, R), !.
replaceElementInList(L, _, _, L).

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


mainMenu(1):-  nl,
	write('New Game'), nl,
	selectBoardSize.
mainMenu(2):-  nl,
	(getCurrentPlayer(ID) ->
		(ID =:= 0 -> (write('There is no current game!'), nl, mainMenu);
		newTurn);
		(write('There is no current game!'), nl, mainMenu)).
mainMenu(3):- instructionsMenu.
mainMenu(4):- write('Exit'),nl.

mainMenu:- logo,
        write('Main Menu'), nl,
        write('(1) - New Game'), nl,
        write('(2) - Continue'), nl,
        write('(3) - Instructions'), nl,
        write('(4) - Exit'), nl, nl,
        write('Input (end with .) :'), nl,
        read(Input),
        member(Input, [1,2,3, 4]) ->mainMenu(Input);
                mainMenu.

instructionsMenu:- nl,
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
        write('(1) - Back'), nl,
        write('Input (end with .) :'), nl,
        read(Input),
        Input =:= 1 ->mainMenu;
                instructionsMenu.

selectBoardSize(1):- createBoard(6), selectNumberOfPlayers.
selectBoardSize(2):- createBoard(7), selectNumberOfPlayers.
selectBoardSize(3):- createBoard(8), selectNumberOfPlayers.
selectBoardSize(4):- mainMenu.

selectBoardSize:- nl,
	write('-> Select Board Size'), nl,
	write('   Select Number of Players'), nl,
	write('   Select Difficulty'), nl, nl,
	write('(1) Small (6x6)'), nl,
	write('(2) Medium (7x7)'), nl,
	write('(3) Large (8x8)'), nl,
	write('(4) Back'), nl, nl,
	write('Input (end with .) :'), nl,
	read(Input),
	member(Input, [1,2,3,4]) -> selectBoardSize(Input);
		selectBoardSize.

selectNumberOfPlayers(1):- createGamePlayers(2), selectDifficultyMenu(1).
selectNumberOfPlayers(2):- createGamePlayers(3), selectDifficultyMenu(1).
selectNumberOfPlayers(3):- createGamePlayers(4), selectDifficultyMenu(1).
selectNumberOfPlayers(4):- selectBoardSize.

selectNumberOfPlayers:- nl,
	write('   Select Board Size'), nl,
	write('-> Select Number of Players'), nl,
	write('   Select Difficulty'), nl, nl,
	write('(1) Two'), nl,
	write('(2) Three'), nl,
	write('(3) Four'), nl, 
	write('(4) Back'), nl, nl,
	write('Input (end with .) :'), nl,
	read(Input),
	member(Input, [1,2,3,4]) -> selectNumberOfPlayers(Input);
		selectNumberOfPlayers.

nextPlayer(PlayerID):-
	PlayerID1 is PlayerID + 1,
	getNumberOfPlayers(NumberOfPlayers), 
	PlayerID < NumberOfPlayers  -> selectDifficultyMenu(PlayerID1);
		startGame.
selectPlayerDifficulty(PlayerID, 1):-
	addPlayer(PlayerID, 0),
	nextPlayer(PlayerID).
selectPlayerDifficulty(PlayerID, 2):-
	addPlayer(PlayerID, 1),
	nextPlayer(PlayerID).
selectPlayerDifficulty(PlayerID, 3):-
	addPlayer(PlayerID, 2),
	nextPlayer(PlayerID).
selectPlayerDifficulty(PlayerID, 4):-
	PlayerID1 is PlayerID - 1,
	PlayerID1 > 0 -> (removePlayer(PlayerID1), selectDifficultyMenu(PlayerID1));
		selectNumberOfPlayers.

selectDifficultyMenu(PlayerID):- nl,
	write('   Select Board Size'), nl,
	write('   Select Number of Players'), nl,
	write('-> Select Difficulty'), nl, nl,

	format('Player ~D ', PlayerID), nl,
	write('(1) - Human'), nl,
	write('(2) - Computer - Easy'), nl,
	write('(3) - Computer - Advanced'), nl, 
	write('(4) - Back'), nl, nl,
	write('Input (end with .) :'), nl,
	read(Input),
	member(Input, [1,2,3,4]) ->selectPlayerDifficulty(PlayerID, Input);
		selectDifficultyMenu(PlayerID).

printScore(0).
printScore(N):-
	getNumberOfPlayers(Number),
	PlayerID is (Number - N + 1),
	getPiecesWon(PlayerID, Pieces),
	length(Pieces, NumPieces),
	getScore(PlayerID, Score),
	printScoreText(PlayerID, Score, NumPieces),
	N1 is N-1,
	printScore(N1).
printScoreText(1, Score, NumPieces):-
	format('ORANGE~t~10| ~D~t~15| (~Dp)', [Score, NumPieces]), nl.
printScoreText(2, Score, NumPieces):-
	format('BLUE~t~10| ~D~t~15| (~Dp)', [Score, NumPieces]), nl.
printScoreText(3, Score, NumPieces):-
	format('GREEN~t~10| ~D~t~15| (~Dp)', [Score, NumPieces]), nl.
printScoreText(4, Score, NumPieces):-
	format('YELLOW~t~10| ~D~t~15| (~Dp)', [Score, NumPieces]), nl.

printScore:-
	getNumberOfPlayers(N),
	write('Current Score:'), nl,
	printScore(N).

printTable:- nl,
	format('ORANGE~t~10| ~D~t~15| (~Dp)', [120, 10]), nl,
	format('BLUE~t~10| ~D~t~15| (~Dp)', [10, 3]), nl,
	format('GREEN~t~10| ~D~t~15| (~Dp)', [8, 2]), nl,
	format('YELLOW~t~10| ~D~t~15| (~Dp)', [25, 0]), nl.

turnToPlay(1):- write('-> ORANGE\'s turn to play:'), nl.
turnToPlay(2):- write('-> BLUE\'s turn to play:'), nl.
turnToPlay(3):- write('-> GREEN\'s turn to play:'), nl.
turnToPlay(4):- write('-> YELLOW\'s turn to play:'), nl.

showHand(PlayerID):-
	getPlayerPieces(PlayerID, Pieces),
	write('Current Hand:'), nl,
	nth0(0, Pieces, X),
	append([" "], [X], X1),
	append(X1, ["N"], Piece1),
	nth0(1, Pieces, Y),
	append([" "], [Y], Y1),
	append(Y1, ["N"], Piece2),
	nth0(2, Pieces, Z),
	append([" "], [Z], Z1),
	append(Z1, ["N"], Piece3),
  write('####### ####### #######'), nl,
  write('#'), printElementTop(Piece1), write('# '),
  write('#'), printElementTop(Piece2), write('# '),
  write('#'), printElementTop(Piece3), write('# '), nl, 
  write('#'), printElementMid(Piece1), write('# '),
  write('#'), printElementMid(Piece2), write('# '),
  write('#'), printElementMid(Piece3), write('# '), nl,
  write('#'), printElementBot(Piece1), write('# '),
  write('#'), printElementBot(Piece2), write('# '),
  write('#'), printElementBot(Piece3), write('# '), nl,
  write('####### ####### #######'), nl,
  write('  (1)     (2)     (3)'), nl, nl.


turnInfo:- nl,
	printBoard, nl,
	printScore, nl,
	getCurrentPlayer(PlayerID),
	turnToPlay(PlayerID),
	showHand(PlayerID).