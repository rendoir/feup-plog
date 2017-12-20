:- use_module(library(timeout)).
:- include('board.pl').
:- include('display.pl').

%doppelblock([4,8,4,5,6,5],[9,7,2,10,3,1]).
doppelblock(Size, TopSums, LeftSums, Board) :- !,
  checkArguments(Size, TopSums, LeftSums),
  initBoard(Board, Size),
  transpose(Board, TransposeBoard),
  initBoard(TransposeBoard, Size),
  applySumsConstrains(Board, LeftSums),
  applySumsConstrains(TransposeBoard, TopSums),
  label(Board),
  drawBoard(Board, TopSums, LeftSums, Size).
doppelblock(_, _, _, _) :-
  printUsage, !.

doppelblock(Size, TopSums, LeftSums, Board, LabelingOptions) :- !,
  checkArguments(Size, TopSums, LeftSums),
  initBoard(Board, Size),
  transpose(Board, TransposeBoard),
  initBoard(TransposeBoard, Size),
  applySumsConstrains(Board, LeftSums),
  applySumsConstrains(TransposeBoard, TopSums),
  label(Board, LabelingOptions),
  drawBoard(Board, TopSums, LeftSums, Size).
doppelblock(_, _, _, _, _) :-
  printUsage, !.

test(List, Size, Sum) :-
  length(List, Size),
  Domain is Size - 2,
  domain(List, 0, Domain),
  count(0, List, #=, 2),
  setDistinctValues(List, Domain, 1),
  sumConstraint(List, Sum),
  labeling([], List).

printAllSolutions(OutputFile, Time, R, [Size, TopSums, LeftSums, Board]) :-
  open(OutputFile, write, X),
  current_output(CO),
  set_output(X),
  printAllSolutions(Time, R, [Size, TopSums, LeftSums, Board]),
  close(X),
  set_output(CO).

printAllSolutions(Time, R, [Size, TopSums, LeftSums, Board]) :-
  time_out((doppelblock(Size, TopSums, LeftSums, Board), fail), Time, R).
printAllSolutions(_, _, _).