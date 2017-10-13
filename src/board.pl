initialBoard([
	[black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, empty_cell, black_dux, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, white_dux, empty_cell, empty_cell],
  [white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier]]).

drawBoard([], _) :-
	drawHorizontalSeparator, nl,
	write('    a    b    c    d    e    f    g    h'), nl.
drawBoard([Line | Remainder], LineNumber) :-
	drawHorizontalSeparator, nl,
	write(LineNumber), NextLineNumber is LineNumber - 1,
	drawLine(Line), drawVerticalSeparator, nl,
	drawBoard(Remainder, NextLineNumber).

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
	write('   ---------------------------------------').
drawVerticalSeparator :-
	write(' | ').

drawInitialBoard :-
	initialBoard(Board),
	LineNumber is 8,
	drawBoard(Board, LineNumber).
