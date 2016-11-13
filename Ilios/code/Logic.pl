drawPiece(PlayerID, 0):- addPiecePlayer(1, PlayerID).
drawPiece(PlayerID, 1):- addPiecePlayer(2, PlayerID).
drawPiece(PlayerID, 2):- addPiecePlayer(3, PlayerID).
drawPiece(PlayerID, 3):- addPiecePlayer(4, PlayerID).
drawPiece(PlayerID, 4):- addPiecePlayer(8, PlayerID).

drawPiece(PlayerID):-
	random(0,5,Rand),
	removePieceDeck(Rand) -> drawPiece(PlayerID, Rand);
		drawPiece(PlayerID).

drawPieces(_, 3).
drawPieces(PlayerID, N):-
	drawPiece(PlayerID),
	N1 is N+1,
	drawPieces(PlayerID, N1).
drawPieces(PlayerID):-
	getPlayerPieces(PlayerID, Pieces),
	length(Pieces, Length),
	Length < 3 -> drawPieces(PlayerID, Length).


raid(ID,X,Y,1,Orientation):-
	getBoardSize(Size),
	Column is X - 97, Column > -1, Column < Size,
	Line is Size - Y, Line > -1, Line < Size,
	Orientation =:= "N" ->
	(
		Y1 is Y+1, 
		(setCellTeam(X, Y1, ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,1,Orientation); true
	);
	Orientation =:= "S" ->
	(
		Y1 is Y-1, 
		(setCellTeam(X, Y1, ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,1,Orientation); true
	);
	Orientation =:= "W" ->
	(
		X1 is X-1, 
		(setCellTeam(X1, Y, ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,1,Orientation); true
	);
	Orientation =:= "E" ->
	(
		X1 is X+1, 
		(setCellTeam(X1, Y, ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,1,Orientation); true
	).
		

raid(ID,X,Y,2,Orientation):-
	getBoardSize(Size),
	Column is X - 97, Column > -1, Column < Size,
	Line is Size - Y, Line > -1, Line < Size,
	member(Orientation, ["N","S"])->
	( 
		X1 is X-1, Y1 is Y+1,
		X2 is X+1, Y2 is Y-1, 
		(setCellTeam(X1,Y1,ID);	setCellTeam(X2,Y2,ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,2,Orientation); true
	);
	member(Orientation, ["W","E"])->
	(
		X1 is X-1, Y1 is Y-1,
		X2 is X+1, Y2 is Y+1, 
		(setCellTeam(X1,Y1,ID); setCellTeam(X2,Y2,ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,2,Orientation); true
	).

raid(ID,X,Y,3,Orientation):-
	getBoardSize(Size),
	Column is X - 97, Column > -1, Column < Size,
	Line is Size - Y, Line > -1, Line < Size,

	Orientation =:= "N" ->
	(
		X1 is X-1,
		Y2 is Y+1,
		X3 is X+1,
		(setCellTeam(X1,Y,ID); setCellTeam(X,Y2,ID); setCellTeam(X3,Y,ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,3,Orientation); true
	);
	Orientation =:= "S" ->
	(
		X1 is X-1,
		Y2 is Y-1,
		X3 is X+1,
		(setCellTeam(X1,Y,ID); setCellTeam(X,Y2,ID); setCellTeam(X3,Y,ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,3,Orientation); true
	);
	Orientation =:= "W" ->
	(
		Y1 is Y-1,
		Y2 is Y+1,
		X3 is X-1,
		(setCellTeam(X1,Y,ID); setCellTeam(X,Y2,ID); setCellTeam(X3,Y,ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,3,Orientation); true
	);
	Orientation =:= "E" ->
	(
		Y1 is Y-1,
		Y2 is Y+1,
		X3 is X+1,
		(setCellTeam(X,Y1,ID); setCellTeam(X,Y2,ID); setCellTeam(X3,Y,ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,3,Orientation); true
	).

raid(ID,X,Y,4,_):-
	getBoardSize(Size),
	Column is X - 97, Column > -1, Column < Size,
	Line is Size - Y, Line > -1, Line < Size,

	X1 is X-1, Y1 is Y-1,
	X2 is X+1, Y2 is Y+1,
	X3 is X-1, Y3 is Y+1,
	X4 is X+1, Y4 is Y-1,
	(setCellTeam(X1,Y1,ID); setCellTeam(X2,Y2,ID); setCellTeam(X3,Y3,ID); setCellTeam(X4,Y4,ID); setCellTeam(X,Y,ID)) -> raid(ID,X,Y,4,_); true.

raid(ID,X,Y,8,_):-
	getBoardSize(Size),
	Column is X - 97, Column > -1, Column < Size,
	Line is Size - Y, Line > -1, Line < Size,

	X1 is X-1, Y1 is Y-1,
	X2 is X+1, Y2 is Y+1,
	X3 is X-1, Y3 is Y+1,
	X4 is X+1, Y4 is Y-1,
	(
	setCellTeam(X1,Y1,ID); setCellTeam(X2,Y2,ID); setCellTeam(X3,Y3,ID); setCellTeam(X4,Y4,ID); 
	setCellTeam(X1,Y,ID); setCellTeam(X2,Y,ID); setCellTeam(X,Y3,ID); setCellTeam(X,Y4,ID); 
	setCellTeam(X,Y,ID)
	) -> raid(ID,X,Y,8,_); true.

raid(_,_,_,10,_).

raid(X,Y,PieceValue,Orientation):-
	getCurrentPlayer(ID),
	raid(ID,X,Y,PieceValue,Orientation).

makePiece(-1, Value, Orientation, Piece):-
	append([" "],[Value],List),
	append(List, [Orientation], Piece).
makePiece(1, Value, Orientation, Piece):-
	append(["O"],[Value],List),
	append(List, [Orientation], Piece).
makePiece(2, Value, Orientation, Piece):-
	append(["B"],[Value],List),
	append(List, [Orientation], Piece).
makePiece(3, Value, Orientation, Piece):-
	append(["G"],[Value],List),
	append(List, [Orientation], Piece).
makePiece(4, Value, Orientation, Piece):-
	append(["Y"],[Value],List),
	append(List, [Orientation], Piece).

placePiece(-1, X,Y,Piece):-
	replace(X,Y, Piece),
	getPieceValue(Piece,Value),
	getPieceOrientation(Piece,Orientation),
	raid(X,Y,Value,Orientation).
placePiece(_,_,_,_):- fail.
placePiece(X,Y, PlayerID, PieceValue, Orientation):-
	getCellValue(X,Y,Value),
	makePiece(PlayerID, PieceValue, Orientation, Piece),
	placePiece(Value, X, Y, Piece).

startGame(0):- setNextPlayer.
startGame(PlayerID):-
	drawPieces(PlayerID),
	NextPlayer is PlayerID-1,
	startGame(NextPlayer).
startGame:-
	createDeck,
	getNumberOfPlayers(N),
	startGame(N),
	placeWeapons.

newTurn(4):- mainMenu.
newTurn:-
	turnInfo,
	write('(4) - Save and Exit'), nl, nl,
	write('Choose Piece (end with .) :'), nl,
	read(Input),
	(Input =:= 4 -> newTurn(4);
	(member(Input, [1,2,3]) -> selectPiece(Input);
		newTurn)).

selectWeaponX(X):-
	write('-> Pick Column'), nl,
	write('   Pick Line'), nl,nl,
	write('Input (ex: "a".) :'), nl,
	read(Input),
	(is_list(Input) ->
		(getBoardSize(Size),
		Column is Input - 97, 
		(Column > -1, Column < Size) -> X is Input; selectWeaponX(X));
	selectWeaponX(X)).
selectWeaponY(Y):-
	write('   Pick Column'), nl,
	write('-> Pick Line'), nl,nl,
	write('Input (ex: 1.) :'), nl,
	read(Input),
	(number(Input) ->
		(getBoardSize(Size),
		Line is Size - Input, 
		(Line > -1, Line < Size) -> Y is Input; selectWeaponY(Y));
	selectWeaponY(Y)).

selectX(X):-
	write('-> Pick Column'), nl,
	write('   Pick Line'), nl,
	write('   Pick Orientation'), nl,nl,
	write('Input (ex: "a".) :'), nl,
	read(Input),
	(is_list(Input) ->
		(getBoardSize(Size),
		Column is Input - 97, 
		(Column > -1, Column < Size) -> X is Input; selectX(X));
	selectX(X)).

selectY(Y):-
	write('   Pick Column'), nl,
	write('-> Pick Line'), nl,
	write('   Pick Orientation'), nl,nl,
	write('Input (ex: 1.) :'), nl,
	read(Input),
	(number(Input) ->
		(getBoardSize(Size),
		Line is Size - Input, 
		(Line > -1, Line < Size) -> Y is Input; selectY(Y));
	selectY(Y)).

selectOrientation(Orientation):-
	write('   Pick Column'), nl,
	write('   Pick Line'), nl,
	write('-> Pick Orientation'), nl,nl,
	write('Input N/S/W/E (ex: "N".) :'), nl,
	read(Input),
	(is_list(Input) ->
		(member(Input, ["N","S","W","E"]) -> Orientation is Input; selectOrientation(Orientation));
	selectOrientation(Orientation)).


selectPiece(PieceNumber):-
	getCurrentPlayer(PlayerID),
	getPlayerPieces(PlayerID, Pieces),
	nth1(PieceNumber, Pieces,Piece),

	(member(Piece, [1,2,3]) -> 
	(selectX(X), selectY(Y), selectOrientation(Orientation),
	(placePiece(X,Y,PlayerID,Piece,Orientation) -> (removePiecePlayer(PieceNumber,PlayerID), drawPieces(PlayerID), setNextPlayer, newTurn);
		(nl, write('ERROR: Could not place piece.'), nl, newTurn)));
	(selectWeaponX(X), selectWeaponY(Y),
	(placePiece(X,Y,PlayerID,Piece,"N") -> (removePiecePlayer(PieceNumber,PlayerID), drawPieces(PlayerID), setNextPlayer, newTurn);
		(nl, write('ERROR: Could not place piece.'), nl, newTurn)))).



placeWeapon(ID):-
	printBoard, nl,
	turnToPlay(ID), nl,
	showHand(ID),
	write('Place an Iron Weapon :'), nl,
	(placeWeapon -> true;
		(nl, write('ERROR: Invalid Position'), nl, placeWeapon(ID))).


placeWeapon:-
	selectWeaponX(X), selectWeaponY(Y),
	placePiece(X,Y,-1,10,"N").
placeWeapons(2):-
	placeWeapon(1),
	placeWeapon(2),
	placeWeapon(1).
placeWeapons(3):-
	placeWeapon(1),
	placeWeapon(2),
	placeWeapon(3).
placeWeapons(4):-
	placeWeapon(1),
	placeWeapon(2),
	placeWeapon(3),
	placeWeapon(4).

placeWeapons:-
	getNumberOfPlayers(N),
	placeWeapons(N),
	newTurn.
