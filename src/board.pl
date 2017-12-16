:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- include('utilities.pl').

%TODO
applyConstraints(List, Size).


initRow(Board, Size, NewBoard) :-
  length(Row, Size),
  MaxNumber is Size - 2,
  domain(Row, 0, MaxNumber),
  applyConstraints(Row, Size),
  append(Board, [Row], NewBoard).


initColumns(Board, Size) :-
  initColumns(Board, Size, Size).
initColumns(_, _, 0).
initColumns(Board, Size, Counter) :-
  Counter > 0,
  getColumn(Board, Counter, Column),
  applyConstraints(Column, Size),
  NextCounter is Counter - 1,
  initColumns(Board, Size, NextCounter).


initBoard(Board, Size) :-
  Size > 2,
  initBoard(Board, Size, Size, []).
initBoard(Board, Size, 0, TmpBoard) :-
  Board = TmpBoard,
  initColumns(Board, Size).
initBoard(Board, Size, Counter, TmpBoard) :-
  Counter > 0,
  initRow(TmpBoard, Size, NewTmpBoard),
  NextCounter is Counter - 1, !,
  initBoard(Board, Size, NextCounter, NewTmpBoard).


labelBoard([]).
labelBoard([Row | Rest]) :-
  labeling([], Row),
  labelBoard(Rest).
