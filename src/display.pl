/**
  display.pl

  This file is responsible for the Console Display of the board.
**/


drawBoard(Board, TopSums, LeftSums, Size) :-
  write('   '), drawTopSums(TopSums), nl,
  write('   '), drawHeader(Size), nl,
  drawBoardRest(Board, LeftSums, Size), !.


drawBoardRest([], _, _).
drawBoardRest([Row | Rest], [Sum | OtherSums], Size) :-
  drawUpSeparatorLine(Size),
  write('  |'),
  drawRow(Row), 
  write(' '),
  write(Sum), nl,
  drawDownSeparatorLine(Size),
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


printUsage :-
  write('Usage: doppelblock(?Size, ?TopSums, ?LeftSums, ?Board, (Optinal) +LabelingOptions).'), nl,
  write('  Size            - Integer      - The Size of the Board'), nl,
  write('  TopSums         - Integer List - The sums on top of the board'), nl,
  write('  LeftSums        - Integer List - The sums on the left of the board'), nl,
  write('  Board           - Integer List - The Board correspondent to the sums'), nl,
  write('  LabelingOptions - Integer List - Optins to labeling the variables'), nl.
