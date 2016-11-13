/*----------------------------------------------------ELEMENTS------------------------------------------------------*/

:-	dynamic
			gameBoard/2,
			gameDeck/1,
			gamePlayers/2.

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
	gamePlayers(NumberOfPlayers, _).
getPlayers(Players):-
	gamePlayers(_, Players).
getPlayer(ID, Player):-
	getPlayers(Players),
	nth1(ID, Players, Player).
getPlayerPieces(ID, Pieces):-
	getPlayers(Players),
	nth1(ID, Players, Player),
	nth0(2, Player, Pieces).	
getPiecesWon(ID, PiecesWon):-
	getPlayers(Players),
	nth1(ID, Players, Player),
	nth0(3, Player, PiecesWon).
getScore(ID, Score):-
	getPlayers(Players),
	nth1(ID, Players, Player),
	nth0(4, Player, Score).


updatePlayer(PlayerID, Player):-
	getPlayers(Players),
	Index is PlayerID-1,
	replaceElementInList(Players, Index, Player, NewPlayers),
	setPlayers(NewPlayers).

setPlayers(Players):-
	getNumberOfPlayers(NumberOfPlayers),
	setGamePlayers(NumberOfPlayers, Players).
setGamePlayers(_,_):-
	retract(gamePlayers(_,_)),
	fail.
setGamePlayers(NumberOfPlayers, Players):-
	assert(gamePlayers(NumberOfPlayers, Players)).
createGamePlayers(NumberOfPlayers):-
	setGamePlayers(NumberOfPlayers, []).

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

