initialBoard([
	[black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, empty_cell, black_dux, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, white_dux, empty_cell, empty_cell],
  [white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier]]).


drawBoard([]) :-
	drawHorizontalSeparator, nl.
drawBoard([Line | Remainder]) :-
	drawHorizontalSeparator, nl,
	drawLine(Line), drawVerticalSeparator, nl,
	drawBoard(Remainder).

drawLine([]).
drawLine([Cell | Remainder]) :-
	drawVerticalSeparator,
	drawCell(Cell),
	drawLine(Remainder).

drawCell(black_soldier) :- write('BS').
drawCell(white_soldier) :- write('WS').
drawCell(black_dux)		:- write('BD').
drawCell(white_dux)		:- write('WD').
drawCell(empty_cell)	:- write('  ').

drawHorizontalSeparator :-
	write('  ---------------------------------------').
drawVerticalSeparator :-
	write(' | ').

drawInitialBoard :-
	initialBoard(Board),
	drawBoard(Board).
