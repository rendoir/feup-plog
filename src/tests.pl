
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
	[empty_cell, empty_cell, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, black_dux, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, black_soldier, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, white_dux, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, black_soldier, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
  	[white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier]]).

testMove :-
  test_board(Board),
  drawBoard(Board),
  
  Xi is 3,
  Yi is 4,
  Xf is 2,
  Yf is 4,
  move(Board, Xi, Yi, Xf, Yf, FinalBoard),

  drawBoard(FinalBoard).
