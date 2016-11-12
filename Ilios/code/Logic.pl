startGame(0).
startGame(PlayerID):-
	drawPieces(PlayerID),
	NextPlayer is PlayerID-1,
	startGame(NextPlayer).
startGame:-
	createDeck,
	getNumberOfPlayers(N),
	startGame(N).

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