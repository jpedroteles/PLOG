/*----------------------------------------------------OBJECTS------------------------------------------------------*/

:-	dynamic
			gameBoard/2,
			gameDeck/1,
			gamePlayers/2.

getDeck(Deck):-
	gameDeck(Deck).
createDeck:-
	retract(gameDeck(_)),
	fail.
createDeck:-
	assert(gameDeck([7,7,7,7,7])).


getNumberOfPlayers(NumberOfPlayers):-
	gamePlayers(NumberOfPlayers, _).
getPlayers(Players):-
	gamePlayers(_, Players).
getPlayer(ID, Player):-
	getPlayers(Players),
	nth1(ID, Players, Player).
setPlayers(Players):-
	getNumberOfPlayers(NumberOfPlayers),
	setGamePlayers(NumberOfPlayers, Players).
setGamePlayers(_,_):-
	retract(gamePlayers(_,_)),
	fail.
setGamePlayers(NumberOfPlayers, Players):-
	assert(gamePlayers(NumberOfPlayers, Players)).
createGamePlayers(NumberOfPlayers):-
	Players is [],
	setGamePlayers(NumberOfPlayers, Players).

addPlayer(Id, Difficulty):-
	Pieces is [],
	PiecesWon is [],
	PointsWon is [],
	Player is [Id, Difficulty, Pieces, PiecesWon, PointsWon],
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