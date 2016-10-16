printElement([]).
printElement([Head|Tail]) :-
  write(Head),
  write(' '),
  printElement(Tail).

printRow([]).
printRow([Head|Tail]):-
  write('##'),
  printElement(Head),
  printRow(Tail).

printBoard([], Size):-
  printBorder(Size).
printBoard(List, Size):-getRow(List,Row,Size,Rest),
  printBorder(Size),
  printRow(Row),
  write('##'),
  printBoard(Rest, Size).

getRow(End,[],0,End).
getRow([Head|Tail],[Head|Rest],N,End):-
  N1 is N -1,
  getRow(Tail,Rest,N1,End).


printTopRow([]) :- nl.
printMidRow([]) :- nl.
printBotRow([]) :- nl.

printBorderAux(0) :- 
  write('##'),
  nl.
printBorderAux(N):-
  write('#######'),
  N1 is N-1,
  printBorderAux(N1).

printBorder(N) :-
  nl,
  write('  '),
  printBorderAux(N).

initialBoard(Board) :- Board = ([
                                  [-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], 
                                  [-1, -1, -1], ['O', 2, 'N'], ['B', 3, 'S'], ['B', 10, -1],['O', 3, 'W'],[-1, -1, -1], 
                                  [1, -1, -1], ['B', 1, 'S'], ['O', -1, -1], ['B', -1, -1],['B', 2, 'N'],[-1, -1, -1], 
                                  ['B', 8, -1], ['B', 4, -1], ['O', 1, 'N'], ['B', 4, -1],['B', 2, 'N'],[-1, -1, -1], 
                                  ['B', 10, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1], 
                                  [-1, -1, -1], [-1, -1, -1], [-1, -1, -1], [-1, -1, -1],[-1, -1, -1],[-1, -1, -1] 
                                ]).

main :- initialBoard(Board), printBoard(Board, 6).