:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- include('utilities.pl').

/**
  board.pl

  This file is responsible for holding and defining information about a board, its atoms and players.
**/

initBoard(Board, N) :- 
  length(Board, N),
  initBoardCycle(Board, N, 0).

initBoardCycle(Board, N, Counter) :-
  Counter < N,
  length(List, N),
  Domain is N - 2,
  domain(List, 0, Domain),
  count(0, List, #=, 2),
  setDistinctValues(List, Domain, 1),
  nth0(Counter, Board, List),
  Ncounter is Counter + 1, !,
  initBoardCycle(Board, N, Ncounter).
initBoardCycle(_,_,_).

setDistinctValues(List, Domain, Counter) :-
  Counter =< Domain,
  count(Counter, List, #=, 1),
  NewCounter is Counter + 1,
  setDistinctValues(List, Domain, NewCounter).
setDistinctValues(_, _, _).

applySumsConstrains([],[]):- !.
applySumsConstrains([BoardH|BoardT], [SumH|SumT]) :-
  sumConstraint(BoardH, SumH),
  applySumsConstrains(BoardT, SumT).

sumBetweenBlack(List, Sum, Black1, Black2) :-
  Counter #= Black1 + 1,!,
  sumBetweenBlack(List, Sum, 0, Black1, Black2, Counter).
sumBetweenBlack(_, Sum, TmpSum, _, Black2, Counter) :-
  Sum #= TmpSum,
  Black2 #= Counter.
sumBetweenBlack(List, Sum, TmpSum, Black1, Black2, Counter) :-
  element(Counter, List, Element),
  NewTmpSum #= TmpSum + Element,
  NewTmpSum #=< Sum,
  NewCounter #= Counter + 1, !,
  sumBetweenBlack(List, Sum, NewTmpSum, Black1, Black2, NewCounter).

sumConstraint(List, Sum) :-
  element(Black1, List, 0),
  element(Black2, List, 0),
  Black2 #> Black1, !,
  sumBetweenBlack(List, Sum, Black1, Black2).