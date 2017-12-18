:- include('board.pl').
:- include('display.pl').


doppelblock(Size) :-
  initSums(TopSums, LeftSums, Size),
  initBoard(Board, Size, TopSums, LeftSums),
  label(Board, TopSums, LeftSums),
  drawBoard(Board, TopSums, LeftSums, Size).
