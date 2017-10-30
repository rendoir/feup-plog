
% [--------------------]
% [----Board Initial---]
% [-------State--------]
% [--------------------]

emptyBoard([
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell]]).


initialBoard([
	[black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, black_dux, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, white_dux, empty_cell, empty_cell, empty_cell],
  	[white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier]]).


isPlayer1(black_soldier).
isPlayer1(black_dux).
isPlayer2(white_soldier).
isPlayer2(white_dux).

isSoldier(Board, X, Y) :-
  getMatrixElement(Y, X, Board, Piece),
  isSoldier(Piece).

isDux(Board, X, Y) :-
  getMatrixElement(Y, X, Board, Piece),
  isDux(Piece).

isSoldier(black_soldier).
isSoldier(white_soldier).

isDux(black_dux).
isDux(white_dux).

isEnemy(X, Y) :-
  isPlayer1(X),
  isPlayer2(Y).
isEnemy(X, Y) :-
  isPlayer1(Y),
  isPlayer2(X).


/**
  Checks if a cell is empty
**/
isEmptyCell(empty_cell).


/**
 * Checks if the 2D point (X,Y) is inside the board.
 **/
isInsideBoard(X, Y) :-
  X >= 0, X =< 7,
  Y >= 0, Y =< 7.


/**
 * Checks if an element is in the corner of the board. (X,Y)
 **/
isInCorner(0, 0).
isInCorner(7, 0).
isInCorner(0, 7).
isInCorner(7, 7).


/**
 * Checks if an element is in the border. (X,Y)
**/
isInBorder(0, _).
isInBorder(7, _).
isInBorder(_, 0).
isInBorder(_, 7).