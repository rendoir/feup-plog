:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- include('utilities.pl').

getCardinality(Size, Cardinality) :-
  MaxIterations is Size - 1,
  getCardinality(MaxIterations, 1, Cardinality, [0-2]).
getCardinality(Size, Size, Cardinality, Cardinality).
getCardinality(Size, Counter, Cardinality, Tmp) :-
  append(Tmp, [Counter-1], NewTmp),
  NextCounter is Counter + 1, !,
  getCardinality(Size, NextCounter, Cardinality, NewTmp).


applyConstraints(List, Size, Sum) :-
  getCardinality(Size, Cardinality), !,
  global_cardinality(List, Cardinality),
  sumConstraint(Sum, List).


initRow(Board, Size, NewBoard, Sum) :-
  length(Row, Size),
  MaxNumber is Size - 2,
  domain(Row, 0, MaxNumber),
  applyConstraints(Row, Size, Sum),
  append(Board, [Row], NewBoard).


initColumns(Board, Size, SumList) :-
  initColumns(Board, Size, 1, SumList).
initColumns(_, Size, Counter, _) :-
  Size is Counter - 1.
initColumns(Board, Size, Counter, SumList) :-
  getColumn(Board, Counter, Column),
  element(Counter, SumList, Sum),
  applyConstraints(Column, Size, Sum),
  NextCounter is Counter + 1,
  initColumns(Board, Size, NextCounter, SumList).


initBoard(Board, Size, TopSums, LeftSums) :-
  Size > 1,
  initBoard(Board, Size, 1, [], TopSums, LeftSums).
initBoard(Board, Size, Counter, TmpBoard, TopSums, _) :-
  Size is Counter - 1,
  Board = TmpBoard,
  initColumns(Board, Size, TopSums).
initBoard(Board, Size, Counter, TmpBoard, TopSums, LeftSums) :-
  element(Counter, LeftSums, Sum),
  initRow(TmpBoard, Size, NewTmpBoard, Sum),
  NextCounter is Counter + 1, !,
  initBoard(Board, Size, NextCounter, NewTmpBoard, TopSums, LeftSums).


getMaxSum(MaxSum, Size) :-
  N is Size - 2,
  SumOfNFirstNumbers is div(N * (N + 1), 2),
  MaxSum = SumOfNFirstNumbers.


initSums(TopSums, LeftSums, Size) :-
  length(TopSums, Size),
  length(LeftSums, Size),
  getMaxSum(MaxSum, Size),
  domain(TopSums, 0, MaxSum),
  domain(LeftSums, 0, MaxSum).


sumBetweenBlack(List, Sum, Black1, Black2) :-
  Counter #= Black1 + 1,
  sumBetweenBlack(List, Sum, 0, Black1, Black2, Counter).
sumBetweenBlack(_, Sum, TmpSum, _, Black2, Counter) :-
  Sum #= TmpSum,
  Black2 #= Counter.
sumBetweenBlack(List, Sum, TmpSum, _, _, Counter) :-
  element(Counter, List, Element),
  NewTmpSum #= TmpSum + Element,
  NewTmpSum #<= Sum,
  NewCounter #= Counter + 1,
  sumBetweenBlack(List, Sum, NewTmpSum, _, _, NewCounter).


sumConstraint(Sum, List) :-
  Black2 #> Black1,
  element(Black1, List, 0),
  element(Black2, List, 0),
  sumBetweenBlack(List, Sum, Black1, Black2).


label(Board, TopSums, LeftSums) :-
  flattenBoard(Board, Label),
  append(Label, TopSums, Label2),
  append(Label2, LeftSums, Label3),
  labeling([], Label3).
