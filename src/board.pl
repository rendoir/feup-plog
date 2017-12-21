/*
  board.pl

  This file is responsible for applying the domain of each variable and its restrictions.
*/

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('utilities.pl').


/*
  initBoard(+Board, +Size, +Counter)
    @brief Initializes the Board, its domain and restrictions

	@param Board - The matrix (inner board)
	@param Size - The size of the matrix
*/
initBoard(Board, Size) :- 
  length(Board, Size),
  initBoardCycle(Board, Size, 0).


/*
  initBoardCycle(+Board, +Size, +Counter)
    @brief Initializes the Board, its domain and restrictions

	@param Board - The matrix (inner board)
	@param Size - The size of the matrix
	@param Counter - A counter to initialize all rows
*/
initBoardCycle(Board, Size, Counter) :-
  Counter < Size,
  length(List, Size),
  Domain is Size - 2,
  domain(List, 0, Domain),
  count(0, List, #=, 2),
  setDistinctValues(List, Domain, 1),
  nth0(Counter, Board, List),
  Ncounter is Counter + 1, !,
  initBoardCycle(Board, Size, Ncounter).
initBoardCycle(_,_,_).


/*
  setDistinctValues(+List, +Domain, +Counter)
    @brief Applies the constraint that defines that all numbers in a row/column must be different

	@param List - A row or column to apply the constraint to
	@param Domain - The maximum number of each list (Size - 2)
	@param Counter - A counter that starts at 1 and ends at Domain
*/
setDistinctValues(List, Domain, Counter) :-
  Counter =< Domain,
  count(Counter, List, #=, 1),
  NewCounter is Counter + 1,
  setDistinctValues(List, Domain, NewCounter).
setDistinctValues(_, _, _).


/*
  applySumsConstrains(+Board, +SumList)
    @brief Applies the sum constraint to the board in the horizontal direction

	@param Board - The matrix (inner board)
	@param SumList - A list of sums
*/
applySumsConstrains([],[]):- !.
applySumsConstrains([BoardH|BoardT], [SumH|SumT]) :-
  sumConstraint(BoardH, SumH),
  applySumsConstrains(BoardT, SumT).


/*
  sumBetweenBlack(+List, +Sum, +Black1, +Black2)
    @brief Applies the sum constraint to a List (the sum of all elements between Black1 and Black2 must be Sum)

	@param List - The list to apply the constraint
	@param Black1 - The position of the first black cell in the List
	@param Black2 - The position of the second black cell in the List
	@param Sum - The expected sum
*/
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


/*
  sumConstraint(+List, +Sum)
    @brief Applies the sum constraint to a List (the sum of all elements between black cells must be Sum)

	@param List - A row or column to apply the constraint to
	@param Sum - The expected sum
*/
sumConstraint(List, Sum) :-
  element(Black1, List, 0),
  element(Black2, List, 0),
  Black2 #> Black1, !,
  sumBetweenBlack(List, Sum, Black1, Black2).