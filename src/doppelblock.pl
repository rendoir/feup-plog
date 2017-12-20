:- include('board.pl').
:- include('display.pl').

%doppelblock([4,8,4,5,6,5],[9,7,2,10,3,1]).
doppelblock(Size, TopSums, LeftSums, Board) :-
  checkArguments(Size, TopSums, LeftSums),
  initBoard(Board, Size),
  transpose(Board, TransposeBoard),
  initBoard(TransposeBoard, Size), !,
  applySumsConstrains(Board, LeftSums),
  applySumsConstrains(TransposeBoard, TopSums),
  label(Board),
  drawBoard(Board, TopSums, LeftSums, Size).
doppelblock(_, _, _, _) :-
  printUsage, !.

doppelblock(Size, TopSums, LeftSums, Board, LabelingOptions) :-
  checkArguments(Size, TopSums, LeftSums),
  initBoard(Board, Size),
  transpose(Board, TransposeBoard),
  initBoard(TransposeBoard, Size), !,
  applySumsConstrains(Board, LeftSums),
  applySumsConstrains(TransposeBoard, TopSums),
  label(Board, LabelingOptions),
  drawBoard(Board, TopSums, LeftSums, Size).
doppelblock(_, _, _, _, _) :-
  printUsage, !.