
initialBoard([
	[black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, black_dux, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, white_dux, empty_cell, empty_cell, empty_cell],
  	[white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier]]).


isPlayer(1, white_soldier).
isPlayer(1, white_dux).
isPlayer(2, black_soldier).
isPlayer(2, black_dux).


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

isFriend(Piece1, Piece2) :-
  isPlayer(1, Piece1),
  isPlayer(1, Piece2).
isFriend(Piece1, Piece2) :-
  isPlayer(2, Piece2),
  isPlayer(2, Piece1).

isEnemy(Piece1, Piece2) :-
  isPlayer(1, Piece1),
  isPlayer(2, Piece2).
isEnemy(Piece1, Piece2) :-
  isPlayer(1, Piece2),
  isPlayer(2, Piece1).


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
