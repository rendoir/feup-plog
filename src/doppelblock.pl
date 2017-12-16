:- include('board.pl').
:- include('display.pl').


doppelblock(Size) :-
  initSums(TopSums, LeftSums, Size),
  initBoard(Board, Size, TopSums, LeftSums),
  labelBoard(Board), 
  labeling([], TopSums),
  labeling([], LeftSums),
  write(TopSums),
  write(LeftSums),
  drawBoard(Board, Size).
