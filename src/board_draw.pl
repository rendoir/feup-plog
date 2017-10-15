
% [--------------------]
% [------Includes------]
% [--------------------]

:- include('board_state.pl').
:- include('moves.pl').
:- include('design_variables.pl').

% [--------------------]
% [-----Draw Board-----]
% [--------------------]
drawBoard([]) :-
	emptyBoard(EmptyBoard),
	drawBoard(EmptyBoard).
drawBoard([Line | Remainder]) :-
	boardtopline(TopLine),
	drawBoardLine(TopLine), nl,
	write(8), write(' '), 
	NextLineNumber is 7,
	drawLine(Line), drawCell(boxlight_vertical), nl,
	drawBoardRest(Remainder, NextLineNumber),
	boardbuttomline(ButtomLine),
	drawBoardLine(ButtomLine), nl,
	write('   a  b  c  d  e  f  g  h'), nl.

drawBoardRest([], _).
drawBoardRest([Line | Remainder], LineNumber) :-
	boardmiddleline(X),
	drawBoardLine(X), nl,
	write(LineNumber), write(' '),  
	NextLineNumber is LineNumber - 1,
	drawLine(Line), drawCell(boxlight_vertical), nl,
	drawBoardRest(Remainder, NextLineNumber).

drawLine([]).
drawLine([Cell | Remainder]) :-
	drawCell(boxlight_vertical),
	drawCell(Cell),
	drawLine(Remainder).

drawBoardLine([]).
drawBoardLine([Cell | Remainder]) :-
	drawCell(Cell),
	drawBoardLine(Remainder).

drawInitialBoard :-
	initialBoard(Board),
	drawBoard(Board).
testMove :-
	drawInitialBoard,
	initialBoard(Board),
	Xi is 0, Yi is 0,
	Xf is 0, Yf is 1,
	move(Board, Xi, Yi, Xf, Yf, NewBoard),
	drawBoard(NewBoard).