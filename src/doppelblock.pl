:- use_module(library(timeout)).
:- include('board.pl').
:- include('display.pl').

%doppelblock(6,[4,8,4,5,6,5],[9,7,2,10,3,1],Board).
doppelblock(Size, TopSums, LeftSums, Board) :- !,
  statistics(runtime, [T0|_]),
  checkArguments(Size, TopSums, LeftSums),
  initBoard(Board, Size),
  transpose(Board, TransposeBoard),
  initBoard(TransposeBoard, Size),
  applySumsConstrains(Board, LeftSums),
  applySumsConstrains(TransposeBoard, TopSums),
  label(Board),
  statistics(runtime, [T1|_]),
  ElapsedTime is T1 - T0,
  format('Solution found in: ~3d seconds', [ElapsedTime]), nl,
  drawBoard(Board, TopSums, LeftSums, Size).
doppelblock(_, _, _, _) :-
  printUsage, !.

doppelblock(Size, TopSums, LeftSums, Board, LabelingOptions) :- !,
  statistics(runtime, [T0|_]),
  checkArguments(Size, TopSums, LeftSums),
  initBoard(Board, Size),
  transpose(Board, TransposeBoard),
  initBoard(TransposeBoard, Size),
  applySumsConstrains(Board, LeftSums),
  applySumsConstrains(TransposeBoard, TopSums),
  label(Board, LabelingOptions),
  statistics(runtime, [T1|_]),
  ElapsedTime is T1 - T0,
  format('Solution found in: ~3d seconds', [ElapsedTime]), nl,
  drawBoard(Board, TopSums, LeftSums, Size).
doppelblock(_, _, _, _, _) :-
  printUsage, !.

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