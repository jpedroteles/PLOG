getBestPlay([],_,_):- fail.
getBestPlay([H|T],BestValue,X):-
	nth0(0,H,Value),
	Value =:= BestValue -> X = H; getBestPlay(T,BestValue,X).
getBestPlay(X):-
	getGamePlays(Values,ValidPlays),
	last(Values,BestValue),
	getBestPlay(ValidPlays,BestValue,X).

findValidPlays(ID,PieceNumber,X,Y,1):-
	\+canPlacePiece(X,Y) -> true;
	(
	%North
	Ny1 is Y+1, 
	(canSetCellTeam(X, Ny1, ID) -> (getCellValue(X,Ny1,NV), addValidPlay(NV,PieceNumber,X,Y,"N")); true),
	%South
	Sy1 is Y-1, 
	(canSetCellTeam(X, Sy1, ID) -> (getCellValue(X,Sy1,SV), addValidPlay(SV,PieceNumber,X,Y,"S"));true),
	%West
	Wx1 is X-1, 
	(canSetCellTeam(Wx1, Y, ID) -> (getCellValue(Wx1,Y,WV), addValidPlay(WV,PieceNumber,X,Y,"W"));true),
	%East
	Ex1 is X+1, 
	(canSetCellTeam(Ex1, Y, ID) -> (getCellValue(Ex1,Y,EV), addValidPlay(EV,PieceNumber,X,Y,"E"));true)
	).	


findValidPlays(ID,PieceNumber,X,Y,2):-
	\+canPlacePiece(X,Y) -> true;
	(
	%North and South
	Nx1 is X-1, Ny1 is Y+1,
	Nx2 is X+1, Ny2 is Y-1, 
	(canSetCellTeam(Nx1,Ny1,ID) -> getCellValue(Nx1,Ny1,NV1); NV1 = 0),	
	(canSetCellTeam(Nx2,Ny2,ID) -> getCellValue(Nx2,Ny2,NV2); NV2 = 0),
	NValues is NV1 + NV2,
	(NValues > 0 -> (addValidPlay(NValues,PieceNumber,X,Y,"N"), addValidPlay(NValues,PieceNumber,X,Y,"S"));true),
	
	%West and East
	Wx1 is X-1, Wy1 is Y-1,
	Wx2 is X+1, Wy2 is Y+1, 
	(canSetCellTeam(Wx1,Wy1,ID) -> getCellValue(Wx1,Wy1,WV1); WV1 = 0),	
	(canSetCellTeam(Wx2,Wy2,ID) -> getCellValue(Wx2,Wy2,WV2); WV2 = 0),
	WValues is WV1 + WV2,
	(WValues > 0 -> (addValidPlay(WValues,PieceNumber,X,Y,"W"), addValidPlay(WValues,PieceNumber,X,Y,"E"));true)
	).


findValidPlays(ID,PieceNumber,X,Y,3):-
	\+canPlacePiece(X,Y) -> true;
	(
	%North
	Nx1 is X-1,
	Ny2 is Y+1,
	Nx3 is X+1,
	(canSetCellTeam(Nx1,Y,ID) -> getCellValue(Nx1,Y,NV1); NV1 = 0), 
	(canSetCellTeam(X,Ny2,ID) -> getCellValue(X,Ny2,NV2); NV2 = 0), 
	(canSetCellTeam(Nx3,Y,ID) -> getCellValue(Nx3,Y,NV3); NV3 = 0),
	NValues is NV1 + NV2 + NV3,
	(NValues > 0 -> addValidPlay(NValues,PieceNumber,X,Y,"N");true),

	%South
	Sx1 is X-1,
	Sy2 is Y-1,
	Sx3 is X+1,
	(canSetCellTeam(Sx1,Y,ID) -> getCellValue(Sx1,Y,SV1); SV1 = 0),
	(canSetCellTeam(X,Sy2,ID) -> getCellValue(X,Sy2,SV2); SV2 = 0),
	(canSetCellTeam(Sx3,Y,ID) -> getCellValue(Sx3,Y,SV3); SV3 = 0),
	SValues is SV1 + SV2 + SV3,
	(SValues > 0 -> addValidPlay(SValues,PieceNumber,X,Y,"S");true),

	%West
	Wy1 is Y-1,
	Wy2 is Y+1,
	Wx3 is X-1,
	(canSetCellTeam(X,Wy1,ID) -> getCellValue(X,Wy1,WV1); WV1 = 0),
	(canSetCellTeam(X,Wy2,ID) -> getCellValue(X,Wy2,WV2); WV2 = 0),
	(canSetCellTeam(Wx3,Y,ID) -> getCellValue(Wx3,Y,WV3); WV3 = 0),
	WValues is WV1 + WV2 + WV3,
	(WValues > 0 -> addValidPlay(WValues,PieceNumber,X,Y,"W");true),

	%East
	Ey1 is Y-1,
	Ey2 is Y+1,
	Ex3 is X+1,
	(canSetCellTeam(X,Ey1,ID) -> getCellValue(X,Ey1,EV1); EV1 = 0),
	(canSetCellTeam(X,Ey2,ID) -> getCellValue(X,Ey2,EV2); EV2 = 0),
	(canSetCellTeam(Ex3,Y,ID) -> getCellValue(Ex3,Y,EV3); EV3 = 0),
	EValues is EV1 + EV2 + EV3,
	(EValues > 0 -> addValidPlay(EValues,PieceNumber,X,Y,"E");true)
	).


findValidPlays(ID,PieceNumber,X,Y,4):-
	\+canPlacePiece(X,Y) -> true;
	(
	X1 is X-1, Y1 is Y-1,
	X2 is X+1, Y2 is Y+1,
	X3 is X-1, Y3 is Y+1,
	X4 is X+1, Y4 is Y-1,
	(canSetCellTeam(X1,Y1,ID) -> getCellValue(X1,Y1,V1); V1 = 0),
	(canSetCellTeam(X2,Y2,ID) -> getCellValue(X2,Y2,V2); V2 = 0),
	(canSetCellTeam(X3,Y3,ID) -> getCellValue(X3,Y3,V3); V3 = 0),
	(canSetCellTeam(X4,Y4,ID) -> getCellValue(X4,Y4,V4); V4 = 0),
	Values is V1 + V2 + V3 + V4,
	(Values > 0 -> addValidPlay(Values,PieceNumber,X,Y,"N");true)
	).

findValidPlays(ID,PieceNumber,X,Y,8):-
	\+canPlacePiece(X,Y) -> true;
	(
	X1 is X-1, Y1 is Y-1,
	X2 is X+1, Y2 is Y+1,
	X3 is X-1, Y3 is Y+1,
	X4 is X+1, Y4 is Y-1,
	(canSetCellTeam(X1,Y1,ID) -> getCellValue(X1,Y1,V1); V1 = 0),
	(canSetCellTeam(X2,Y2,ID) -> getCellValue(X2,Y2,V2); V2 = 0),
	(canSetCellTeam(X3,Y3,ID) -> getCellValue(X3,Y3,V3); V3 = 0),
	(canSetCellTeam(X4,Y4,ID) -> getCellValue(X4,Y4,V4); V4 = 0),
	(canSetCellTeam(X1,Y,ID) -> getCellValue(X1,Y,V5); V5 = 0),
	(canSetCellTeam(X2,Y,ID) -> getCellValue(X2,Y,V6); V6 = 0),
	(canSetCellTeam(X,Y3,ID) -> getCellValue(X,Y3,V7); V7 = 0),
	(canSetCellTeam(X,Y4,ID) -> getCellValue(X,Y4,V8); V8 = 0),
	Values is V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8,
	(Values > 0 -> addValidPlay(Values,PieceNumber,X,Y,"N");true)
	).


findValidPlays(_,0,_,_,_,_).
findValidPlays(0,Y,ID,PieceOne,PieceTwo,PieceThree):-
	getBoardSize(Size),
	Y1 is Y-1,
	findValidPlays(Size, Y1,ID,PieceOne,PieceTwo,PieceThree).
findValidPlays(X,Y,ID,PieceOne,PieceTwo,PieceThree):-
	getBoardSize(Size),
	Column is X + 96,
	Line is Size - Y + 1,
	X1 is X-1,
	findValidPlays(ID,1,Column,Line,PieceOne),
	findValidPlays(ID,2,Column,Line,PieceTwo),
	findValidPlays(ID,3,Column,Line,PieceThree),
	findValidPlays(X1,Y,ID,PieceOne,PieceTwo,PieceThree).
findValidPlays:-
	setGamePlays([],[]),
	getBoardSize(Size),
	getCurrentPlayer(ID),
	getPlayerPieces(ID, Pieces),
	nth1(1,Pieces,PieceOne),
	nth1(2,Pieces,PieceTwo),
	nth1(3,Pieces,PieceThree),
	findValidPlays(Size,Size,ID,PieceOne,PieceTwo,PieceThree).