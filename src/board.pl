:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- include('utilities.pl').

getCardinality(Size, Cardinality) :-
  MaxIterations is Size - 1,
  getCardinality(MaxIterations, 1, Cardinality, [0-2]).
getCardinality(Size, Size, Cardinality, Cardinality).
getCardinality(Size, Counter, Cardinality, Tmp) :-
  append(Tmp, [Counter-1], NewTmp),
  NextCounter is Counter + 1,
  getCardinality(Size, NextCounter, Cardinality, NewTmp).


applyConstraints(List, Sum, Cardinality) :-
  global_cardinality(List, Cardinality),
  sumConstraint(Sum, List).


initRow(Board, Size, NewBoard, Sum, Cardinality) :-
  length(Row, Size),
  MaxNumber is Size - 2,
  domain(Row, 0, MaxNumber),
  applyConstraints(Row, Sum, Cardinality),
  append(Board, [Row], NewBoard).


initColumns(Board, Size, SumList, Cardinality) :-
  initColumns(Board, Size, 1, SumList, Cardinality).
initColumns(_, Size, Counter, _, _) :-
  Size is Counter - 1.
initColumns(Board, Size, Counter, SumList, Cardinality) :-
  getColumn(Board, Counter, Column),
  element(Counter, SumList, Sum),
  applyConstraints(Column, Sum, Cardinality),
  NextCounter is Counter + 1, 
  initColumns(Board, Size, NextCounter, SumList, Cardinality).


initBoard(Board, Size, TopSums, LeftSums, Cardinality) :-
  initBoard(Board, Size, 1, [], TopSums, LeftSums, Cardinality).
initBoard(Board, Size, Counter, TmpBoard, TopSums, _, Cardinality) :-
  Size is Counter - 1,
  Board = TmpBoard,
  initColumns(Board, Size, TopSums, Cardinality).
initBoard(Board, Size, Counter, TmpBoard, TopSums, LeftSums,Cardinality) :-
  element(Counter, LeftSums, Sum),
  initRow(TmpBoard, Size, NewTmpBoard, Sum, Cardinality),
  NextCounter is Counter + 1,
  initBoard(Board, Size, NextCounter, NewTmpBoard, TopSums, LeftSums, Cardinality).


sumBetweenBlack(List, Sum, Black1, Black2) :-
  Counter #= Black1 + 1,
  sumBetweenBlack(List, Sum, 0, Black1, Black2, Counter).
sumBetweenBlack(List, Sum, TmpSum, _, Black2, Counter) :-
  Counter #< Black2,
  element(Counter, List, Element),
  NewTmpSum #= TmpSum + Element,
  NewTmpSum #=< Sum,
  NewCounter #= Counter + 1,
  sumBetweenBlack(List, Sum, NewTmpSum, _, _, NewCounter).
sumBetweenBlack(_, Sum, TmpSum, _, Black2, Counter) :-
  Sum #= TmpSum,
  Black2 #= Counter.


sumConstraint(Sum, List) :-
  element(Black1, List, 0),
  element(Black2, List, 0),
  Black2 #> Black1,
  sumBetweenBlack(List, Sum, Black1, Black2).


label(Board) :-
  flattenBoard(Board, Label),
  labeling([], Label).
