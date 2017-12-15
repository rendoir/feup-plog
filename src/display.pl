/**
  display.pl
 
  This file is responsible for the Console Display of the board.
**/


drawBoard(Board, Size) :-
  write(' '), drawHeader(Size), nl,
  drawBoardRest(Board, Size).


drawBoardRest([], _).
drawBoardRest([Row | Rest], Size) :-
  drawUpSeparatorLine(Size),
  write('|'),
  drawRow(Row, Size), nl,
  drawDownSeparatorLine(Size),
  drawBoardRest(Rest, Size).


drawRow([], _).
drawRow([Cell | Remainder], Size) :-
  write('  '),
  drawCell(Cell, Size),
  write('  |'),
  drawRow(Remainder, Size).


drawUpSeparatorLine(Size) :-
  write('|'),
  drawUpSeparatorLine(Size, Size), nl.
drawUpSeparatorLine(_, 0).
drawUpSeparatorLine(Size, Counter) :- 
  write('     |'), 
  NextCounter is Counter - 1,
  drawUpSeparatorLine(Size, NextCounter).


drawDownSeparatorLine(Size) :-
  write('|'),
  drawDownSeparatorLine(Size, Size), nl.
drawDownSeparatorLine(_, 0).
drawDownSeparatorLine(Size, Counter) :- 
  write('_____|'), 
  NextCounter is Counter - 1,
  drawDownSeparatorLine(Size, NextCounter).


drawHeader(Size) :-
  drawHeader(Size, Size).
drawHeader(_, 0).
drawHeader(Size, Counter) :-
  write('_____ '),
  NextCounter is Counter - 1,
  drawHeader(Size, NextCounter).


/**
  drawCell/2: Draws a board cell
    The black cells have the values '0' and 'size - 1'.
**/
drawCell(0, _) :- 
  write('X').
drawCell(Black2, Size) :- 
  Black2 is Size - 1,
  write('X').
drawCell(Cell, _) :- 
  write(Cell).
