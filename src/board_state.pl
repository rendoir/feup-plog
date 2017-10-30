
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

isEnemy(X, Y) :-
  isPlayer1(X),
  isPlayer2(Y).
isEnemy(X, Y) :-
  isPlayer1(Y),
  isPlayer2(X).
