:-      dynamic
                        gameBoard/2,
                        gameDeck/1,
                        gamePlayers/3,
                        gamePlays/2.

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
