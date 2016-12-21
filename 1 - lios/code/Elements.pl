/*----------------------------------------------------ELEMENTS------------------------------------------------------*/

:-	dynamic
			gameBoard/2,
			gameDeck/1,
			gamePlayers/3,
			gamePlays/2.

resetGame:-
	retract(gameBoard(_,_));
	retract(gameDeck(_));
	retract(gamePlayers(_,_,_));
	retract(gamePlays(_,_));
	true.

removePieceDeck(Index):-
	getDeck(Deck),
	nth0(Index, Deck, Number),
	N1 is Number-1,
	N1 >= 0,
	replaceElementInList(Deck, Index, N1, NewDeck),
	setDeck(NewDeck).

getNumberPieces(Index, Number):-
	getDeck(Deck),
	nth1(Index, Deck, Number).
getAvailablePieces(Number):-
	getNumberPieces(1, N1),
	getNumberPieces(2, N2),
	getNumberPieces(3, N3),
	getNumberPieces(4, N4),
	getNumberPieces(5, N5),
	Number is N1 + N2 + N3 + N4 + N5.
getDeck(Deck):-
	gameDeck(Deck).
setDeck(_):-
	retract(gameDeck(_)),
	fail.
setDeck(Deck):-
	assert(gameDeck(Deck)).
createDeck:-
	retract(gameDeck(_)),
	fail.
createDeck:-
	assert(gameDeck([15,15,15,15,15])).

removePiecePlayer(PieceNumber, PlayerID):-
	getPlayerPieces(PlayerID, Pieces),
	nth1(PieceNumber, Pieces, _, NewPieces),
	setPlayerPieces(PlayerID, NewPieces).
addPiecePlayer(Piece, PlayerID):-
	member(Piece, [1,2,3,4,8]),
	getPlayerPieces(PlayerID, Pieces),
	length(Pieces, Length),
	Length < 3 -> 
		(append(Pieces, [Piece], NewPieces), 
			setPlayerPieces(PlayerID, NewPieces));
		fail.

getPieceValue(Piece,Value):-
	nth1(2, Piece,Value).
getPieceOrientation(Piece,Orientation):-
	nth1(3, Piece,Orientation).

getTeamID(Team, ID):-
	member(Team,["O","B","G","Y"])->
	(Team =:= "O" -> 
		ID = 1;
	Team =:= "B" -> 
		ID = 2;
	Team =:= "G" -> 
		ID = 3;
	Team =:= "Y" -> 
		ID = 4);
	ID = (-1).

getNumberOfPlayers(NumberOfPlayers):-
	gamePlayers(NumberOfPlayers,_,_).
getPlayers(Players):-
	gamePlayers(_,Players,_).
getCurrentPlayer(ID):-
	gamePlayers(_,_,ID).
getPlayer(ID, Player):-
	getPlayers(Players),
	nth1(ID, Players, Player).
getPlayerDifficulty(ID, Difficulty):-
	getPlayer(ID, Player),
	nth0(1, Player, Difficulty).
getPlayerPieces(ID, Pieces):-
	getPlayer(ID, Player),
	nth0(2, Player, Pieces).
getPlayerPieceValue(ID, N, Value):-
	getPlayerPieces(ID, Pieces),
	nth1(N, Pieces,Value).	
getPiecesWon(ID, PiecesWon):-
	getPlayer(ID, Player),
	nth0(3, Player, PiecesWon).
getScore(ID, Score):-
	getPlayer(ID, Player),
	nth0(4, Player, Score).

setScore(ID, NewScore):-
	getPlayer(ID, Player),
	replaceElementInList(Player, 4, NewScore, NewPlayer),
	updatePlayer(ID, NewPlayer).
increasePiecesWon(ID):-
	getPlayer(ID, Player),
	getPiecesWon(ID,PiecesWon),
	NewPiecesWon is PiecesWon + 1,
	replaceElementInList(Player, 3, NewPiecesWon, NewPlayer),
	updatePlayer(ID, NewPlayer).

increaseScore(ID, Value):-
	getScore(ID, Score),
	NewScore is Score+Value,
	setScore(ID, NewScore),
	increasePiecesWon(ID).

setPlayerPieces(PlayerID, NewPieces):-
	getPlayer(PlayerID, Player),
	replaceElementInList(Player, 2, NewPieces, NewPlayer),
	updatePlayer(PlayerID, NewPlayer).


updatePlayer(PlayerID, Player):-
	getPlayers(Players),
	Index is PlayerID-1,
	replaceElementInList(Players, Index, Player, NewPlayers),
	setPlayers(NewPlayers).


setNextPlayer:-
	getCurrentPlayer(ID),
	getNumberOfPlayers(N),
	NextID is ID+1,
	(N >= NextID -> setCurrentPlayer(NextID);
		setCurrentPlayer(1)).

setCurrentPlayer(ID):-
	getNumberOfPlayers(NumberOfPlayers),
	getPlayers(Players),
	setGamePlayers(NumberOfPlayers, Players, ID).

setPlayers(Players):-
	getNumberOfPlayers(NumberOfPlayers),
	getCurrentPlayer(ID),
	setGamePlayers(NumberOfPlayers, Players, ID).
setGamePlayers(_,_,_):-
	retract(gamePlayers(_,_,_)),
	fail.
setGamePlayers(NumberOfPlayers, Players,CurrentID):-
	assert(gamePlayers(NumberOfPlayers, Players, CurrentID)).
createGamePlayers(NumberOfPlayers):-
	setGamePlayers(NumberOfPlayers, [], 0).

removePlayer(Id):-
	getPlayer(Id, Player),
	getPlayers(Players),
	delete(Players, Player, NewPlayers),
	setPlayers(NewPlayers).
addPlayer(Id, Difficulty):-
	Pieces = [],
	PiecesWon = 0,
	PointsWon = 0,
	Player = [Id, Difficulty, Pieces, PiecesWon, PointsWon],
	getPlayers(Players),
	append(Players, [Player], NewPlayers),
	setPlayers(NewPlayers).


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




setGamePlays(_,_):-
	retract(gamePlays(_,_)),
	fail.
setGamePlays(X,ValidPlays) :-
	samsort(X,Values),
	assert(gamePlays(Values,ValidPlays)).

setValidPlays(ValidPlays):-
	getValues(Values),
	setGamePlays(Values,ValidPlays).
setPlaysValues(X):-
	getValidPlays(ValidPlays),
	samsort(X,Values),
	setGamePlays(Values,ValidPlays).

addValidPlay(Value,PieceNumber,X,Y,Orientation):-
	getGamePlays(Values,ValidPlays),
	append(Values,[Value],L1),
	append(ValidPlays,[[Value,PieceNumber,X,Y,Orientation]],L2),
	setGamePlays(L1,L2).

canPlay:-
	getValidPlays(ValidPlays),
	length(ValidPlays,Length),
	Length > 0 -> true; false.

getGamePlays(Values,ValidPlays):-
	gamePlays(Values,ValidPlays).
getValidPlays(ValidPlays):-
	gamePlays(_,ValidPlays).
getPlaysValues(Values):-
	gamePlays(Values,_).

