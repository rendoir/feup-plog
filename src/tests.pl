
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
	[white_dux, black_soldier, white_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, white_soldier],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, white_soldier, black_dux],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, black_soldier, empty_cell, empty_cell, empty_cell],
  	[black_soldier, white_soldier, white_soldier, white_soldier, white_soldier, empty_cell, empty_cell, white_soldier]]).

test_board_2([
	[white_dux, black_soldier, black_soldier, black_soldier, empty_cell, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, white_soldier, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, black_dux, empty_cell, white_soldier, empty_cell, black_soldier, empty_cell, white_soldier],
	[empty_cell, white_soldier, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
  	[black_soldier, empty_cell, white_soldier, empty_cell, white_soldier, empty_cell, empty_cell, white_soldier]]).

testAll :-
  testDuxCaptureCorner,
  testSoldierCaptureCorner,
  testDuxCaptureBorder,
  testSoldierCaptureBorder,
  testDuxCaptureMid,
  testSoldierCaptureMid,
  testOrthogonal.

testDuxCaptureCorner :-
  test_board(Board),
  drawBoard(Board),
  move(Board, 0, 7, 0, 1, FinalBoard),
  isCaptured(FinalBoard, 0, 0),
  drawBoard(FinalBoard).

testSoldierCaptureCorner :-
  test_board(Board),
  drawBoard(Board),
  move(Board, 0, 0, 0, 6, FinalBoard),
  isCaptured(FinalBoard, 0, 7),
  drawBoard(FinalBoard).

testDuxCaptureBorder:-
  test_board(Board),
  drawBoard(Board),
  move(Board, 7, 7, 7, 3, FinalBoard),
  isCaptured(FinalBoard, 7, 2),
  drawBoard(FinalBoard).

testSoldierCaptureBorder :-
  test_board(Board),
  drawBoard(Board),
  move(Board, 6, 0, 6, 1, FinalBoard),
  isCaptured(FinalBoard, 7, 1),
  drawBoard(FinalBoard).

testDuxCaptureMid :-
  test_board_2(Board),
  drawBoard(Board),
  move(Board, 0, 0, 0, 3, Board2),
  not(isCaptured(Board2, 1, 3)),
  drawBoard(Board2),
  move(Board2, 2, 7, 2, 3, Board3),
  isCaptured(Board3, 1, 3),
  drawBoard(Board3).

testSoldierCaptureMid :-
  test_board_2(Board),
  drawBoard(Board),
  move(Board, 3, 3, 4, 3, Board2),
  not(isCaptured(Board2, 5, 3)),
  drawBoard(Board2),
  move(Board2, 7, 3, 6, 3, Board3),
  isCaptured(Board3, 5, 3),
  drawBoard(Board3).

testOrthogonal :-
  test_board(Board),
  drawBoard(Board),
  not(move(Board, 0, 0, 1, 1, Board)).

testPiecesBetween :-
  test_board(Board),
  drawBoard(Board),
  not(move(Board, 3, 7, 3, 3, Board)).