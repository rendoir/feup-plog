/**
  display.pl

  This file is responsible for the Console Display of the board.
**/


drawBoard(Board, TopSums, LeftSums, Size) :-
  write('    '), drawTopSums(TopSums), nl,
  write('    '), drawHeader(Size), nl,
  drawBoardRest(Board, LeftSums, Size).


drawBoardRest([], _, _).
drawBoardRest([Row | Rest], [Sum | OtherSums], Size) :-
  write(' '), drawUpSeparatorLine(Size),
  write(Sum),
  write('  |'),
  drawRow(Row), nl,
  write(' '), drawDownSeparatorLine(Size),
  drawBoardRest(Rest, OtherSums, Size).


drawRow([]).
drawRow([Cell | Remainder]) :-
  write('  '),
  drawCell(Cell),
  write('  |'),
  drawRow(Remainder).


drawUpSeparatorLine(Size) :-
  write('  |'),
  drawUpSeparatorLine(Size, Size), nl.
drawUpSeparatorLine(_, 0).
drawUpSeparatorLine(Size, Counter) :-
  write('     |'),
  NextCounter is Counter - 1,
  drawUpSeparatorLine(Size, NextCounter).


drawDownSeparatorLine(Size) :-
  write('  |'),
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


drawTopSums([]).
drawTopSums([Sum | Rest]) :-
  write('  '), write(Sum), write('   '),
  drawTopSums(Rest).


/**
  drawCell/2: Draws a board cell
    The black cells have the values '0'.
**/
drawCell(0) :-
  write('X').
drawCell(Cell) :-
  write(Cell).
