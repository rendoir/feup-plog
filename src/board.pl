initialBoard :- [
	[black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier, black_soldier],
	[empty_cell, empty_cell, empty_cell, empty_cell, black_dux, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, empty_cell],
	[empty_cell, empty_cell, empty_cell, empty_cell, empty_cell, white_dux, empty_cell, empty_cell],
    [white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier, white_soldier]].


drawBoard([]).
drawBoard([Line | Remainder]) :- 
	write(' ________________________________________'), nl,
	drawLine(Line), nl,
	drawBoard(Remainder).

drawLine([]).
drawLine([Cell | Remainder]) :-
	write(' | '),
	drawCell(Cell),
	drawLine(Remainder).

drawCell(black_soldier) :- write('BS').
drawCell(white_soldier) :- write('WS').
drawCell(black_dux)		:- write('BD').
drawCell(white_dux)		:- write('WD').
drawCell(empty_cell)	:- write('  ').

drawInitialBoard :- 
	initialBoard(Board),
	drawBoard(Board).
