
% [--------------------]
% [------Includes------]
% [--------------------]

:- include('board_state.pl').
:- include('moves.pl').

% [--------------------]
% [-------TESTS--------]
% [--------------------]

drawInitialBoard :-
	initialBoard(Board),
	drawBoard(Board).
testMove :-
	drawInitialBoard,
	initialBoard(Board),
	Xi is 0, Yi is 0,
	Xf is 0, Yf is 2,
	move(Board, Xi, Yi, Xf, Yf, NewBoard),
	drawBoard(NewBoard),
	Xii is 0, Yii is 2,
	Xff is 2, Yff is 2,
	move(NewBoard, Xii, Yii, Xff, Yff, FinalBoard),
	drawBoard(FinalBoard).