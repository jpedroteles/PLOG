/*----------------------------------------------------ELEMENTS------------------------------------------------------*/

:-	dynamic
			gameBoard/2,
			gameDeck/1,
			gamePlayers/3.

resetGame:-
	retract(gameBoard(_,_));
	retract(gameDeck(_));
	retract(gamePlayers(_,_,_));
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
	assert(gameDeck([7,7,7,7,7])).


addPiecePlayer(Piece, PlayerID):-
	member(Piece, [1,2,3,4,8]),
	getPlayerPieces(PlayerID, Pieces),
	length(Pieces, Length),
	Length < 3 -> 
		(append(Pieces, [Piece], NewPieces), 
			getPlayer(PlayerID, Player),
			replaceElementInList(Player, 2, NewPieces, NewPlayer),
			updatePlayer(PlayerID, NewPlayer));
		fail.


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
getPiecesWon(ID, PiecesWon):-
	getPlayer(ID, Player),
	nth0(3, Player, PiecesWon).
getScore(ID, Score):-
	getPlayer(ID, Player),
	nth0(4, Player, Score).


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
	PiecesWon = [],
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

