
% [--------------------]
% [------Includes------]
% [--------------------]

:- include('board_state.pl').
:- include('board_draw.pl').
:- include('moves.pl').

% [--------------------]
% [-------TESTS--------]
% [--------------------]

test_board([
	[black_soldier, black_soldier, black_soldier, white_soldier, black_soldier, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, black_dux, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, black_soldier, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, white_soldier, white_dux, empty_cell, empty_cell, empty_cell],
  	[white_soldier, white_soldier, empty_cell, white_soldier, white_soldier, white_soldier, white_soldier, empty_cell]]).


testMove :-
  test_board(Board),
  drawBoard(Board),
  
  Xi is 1,
  Yi is 7,
  Xf is 1,
  Yf is 1,
  move(Board, Xi, Yi, Xf, Yf, FinalBoard),
  isCaptured(FinalBoard, 0, 1),

  drawBoard(FinalBoard).


testCapture :-
  test_board(Board),
  drawBoard(Board),

  move(Board, 5, 7, 5, 6, FinalBoard),
 
  drawBoard(FinalBoard).
