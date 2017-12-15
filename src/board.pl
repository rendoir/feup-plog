:- use_module(library(clpfd)).
:- use_module(library(lists)).


initRow(Board, Size, NewBoard) :-
  length(Row, Size),
  MaxNumber is Size - 1,
  domain(Row, 0, MaxNumber),
  all_different(Row),
  applyBlackConstrain(Row, Size),
  append(Board, [Row], NewBoard).


initBoard(Board, Size) :-
  Size > 2,
  initBoard(Board, Size, Size, []).
initBoard(Board, _, 0, TmpBoard) :- Board = TmpBoard.
initBoard(Board, Size, Counter, TmpBoard) :-
  Counter > 0,
  initRow(TmpBoard, Size, NewTmpBoard),
  NextCounter is Counter - 1, !,
  initBoard(Board, Size, NextCounter, NewTmpBoard).


applyBlackConstrain(Row, Size) :-
  element(Black1, Row, 0),
  Black2Value is Size - 1,
  element(Black2, Row, Black2Value),
  Black1 #< Black2.


labelBoard([]).
labelBoard([Row | Rest]) :-
  labeling([], Row),
  labelBoard(Rest).