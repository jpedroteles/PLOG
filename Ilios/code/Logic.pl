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
	replace(X,Y, Piece).
placePiece(_,_,_,_).
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
	newTurn.

newTurn:-
	turnInfo,
	write('Choose Piece (end with .) :'), nl,
	read(Input),
	(member(Input, [1,2,3]) -> (setNextPlayer, newTurn);
		newTurn).

selectX(Column):-
	write('-> Pick Column'), nl,
	write('   Pick Line'), nl,
	write('   Pick Orientation'), nl,nl,
	write('Input (ex: "a".) :'), nl,
	read(Input),
	getBoardSize(Size),
	Column is Input - 97, 
	Column > -1 -> (Column < Size -> write('OK'); selectX(Column));
		selectX(Column).
selectPiece(PlayerID, PieceNumber):-
	getPlayerPieces(PlayerID, Pieces),
	nth1(PieceNumber, Pieces,Piece),
	write(Piece).