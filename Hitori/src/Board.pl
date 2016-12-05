
createBoard(5):- 
        Board = ([ 
                                [[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]], 
                                [[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]], 
                                [[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]], 
                                [[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]], 
                                [[-1, -1], [-1, -1], [-1, -1], [-1, -1],[-1, -1]]
                                        ]),
        Size = 5,
setGameBoard(Board,Size).




createBoard(8):- 
        Board = ([
                                [[4, -1], [5, -1], [6, -1], [8, -1],[3, -1],[7, -1], [8, -1], [1, -1]], 
                                [[1, -1], [1, -1], [1, -1], [4, -1],[8, -1],[6, -1], [7, -1], [2, -1]], 
                                [[5, -1], [4, -1], [7, -1], [6, -1],[3, -1],[1, -1], [2, -1], [8, -1]], 
                                [[7, -1], [4, -1], [5, -1], [3, -1],[2, -1],[8, -1], [1, -1], [6, -1]], 
                                [[2, -1], [2, -1], [2, -1], [7, -1],[1, -1],[4, -1], [4, -1], [4, -1]], 
                                [[8, -1], [7, -1], [4, -1], [5, -1],[5, -1],[2, -1], [6, -1], [3, -1]], 
                                [[6, -1], [7, -1], [8, -1], [5, -1],[5, -1],[4, -1], [3, -1], [2, -1]], 
                                [[3, -1], [3, -1], [3, -1], [2, -1],[4, -1],[6, -1], [1, -1], [7, -1]]
                                        ]),
        Size = 8,
setGameBoard(Board,Size).

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
  format('   ~32r   ',10+N),
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
