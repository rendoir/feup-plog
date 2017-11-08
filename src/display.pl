/**
  This file is responsible for the Console display of the board.
**/


drawBoard([Line | Remainder]) :-
  drawBoardHeader,
  drawBoardRest([Line | Remainder], 0), nl.


drawBoardHeader :- 
  write('       0     1     2     3     4     5     6     7'), nl,
  write('     _______________________________________________'), nl.


drawBoardRest([], _).
drawBoardRest([Line | Remainder], LineNumber) :-
  drawUpSeparatorLine,
  write(LineNumber), write('   |'), drawValueLine(Line), nl,
  drawDownSeparatorLine,
  NextLineNumber is LineNumber + 1,
  drawBoardRest(Remainder, NextLineNumber).


drawValueLine([]).
drawValueLine([Cell | Remainder]) :-
	drawCell(Cell),
	drawValueLine(Remainder).


drawUpSeparatorLine :- write('    |     |     |     |     |     |     |     |     |'), nl.
drawDownSeparatorLine   :- write('    |_____|_____|_____|_____|_____|_____|_____|_____|'), nl.


drawCell(black_soldier) :- write('  x  |').
drawCell(white_soldier) :- write('  o  |').
drawCell(black_dux)     :- write('  X  |').
drawCell(white_dux)     :- write('  O  |').
drawCell(empty_cell)    :- write('     |').


clearScreen :-  write('\33\[2J').
