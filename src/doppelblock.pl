:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- include('utilities.pl').

/* Black1 will be 0 */
/* Black2 will be size-1 */

initRow(Board, Size, RowNumber, NewBoard) :-
  length(Row, Size),
  setListElement(RowNumber, Row, Board, NewBoard),
  MaxNumber is Size - 1,
  domain(Row, 0, MaxNumber),
  all_different(Row),
  applyBlackConstrain(Row, Size).

initBoard(Board, Size) :-
  Size > 2,
  length(Board, Size),
  initBoard(Board, Size, Size).
initBoard(Board, Size, Counter) :-
  initRow(Board, Size, Counter, NewBoard),
  NextCounter is Counter - 1,
  initBoard(NewBoard, Size, NextCounter).
initBoard(_, _, 0).

applyBlackConstrain(Row, Size) :-
  element(Black1, Row, 0),
  Black2Value is Size - 1,
  element(Black2, Row, Black2Value),
  Black1 #< Black2.

doppelblock(Size) :-
  initBoard(Board, Size),
  labeling([], Board).
