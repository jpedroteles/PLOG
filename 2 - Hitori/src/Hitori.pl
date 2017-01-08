:- include('Restrictions.pl').

/* inicializar cada célula de um tabuleiro auxiliar a 0 ou 1*/
start_board(N,N,[]).

start_board(N, Index, [L|H]) :-
          length(L, N),                         % array de tamanho N
          domain(L, 0, 1),                      % dominio do array é 0 e 1
          Index1 is Index + 1,
          start_board(N, Index1, H).        % chamada recursiva para cada linha até N

hitori :-  
        board(Board),
        displayBoard(Board),
        length(Board, N),
        statistics(runtime, [T0|_]),
        start_board(N, 0, Aux1),
        transpose(Board, BoardTrans),
        transpose(Aux1, Aux2),
        check_double(Board, Aux1, BoardTrans, 1),
        blacks_per_row(Board,BoardTrans,Aux1,Aux2),
        check_blacks_adj(Aux1, Aux2),
        check_whites_bloc(Aux1,1,1, N),
        tails_append(Aux1, Vars),
        labeling([time_out(1000, _)], Vars),
        statistics(runtime, [T1|_]),
        parse_solution(Board,Aux1, Final),
        displayBoard(Final),
        T is T1 - T0,
        nl,
        format('Solution found in ~3d sec.~n', [T]),
        nl,
        fd_statistics.