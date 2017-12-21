/*
  doppelblock.pl

  This file holds the predicates that are entry points to the solver.
*/

:- use_module(library(timeout)).
:- include('board.pl').
:- include('display.pl').


/*
  doppelblock(?Size, ?TopSums, ?RightSums, ?Board)
    @brief Solves an instance of the puzzle

    @param Size - The size of the matrix
	@param TopSums - The sums on top of the board
	@param RightSums - The sums on the right of the board
	@param Board - The matrix (inner board)
  
    Example: doppelblock(6, [4,8,4,5,6,5], [9,7,2,10,3,1], Board).
*/
doppelblock(Size, TopSums, RightSums, Board) :- !,
  doppelblock(Size, TopSums, RightSums, Board, []).
doppelblock(_, _, _, _) :-
  printUsage, !.


/*
  doppelblock(?Size, ?TopSums, ?RightSums, ?Board, +LabelingOptions)
    @brief Solves an instance of the puzzle

    @param Size - The size of the matrix
	@param TopSums - The sums on top of the board
	@param RightSums - The sums on the right of the board
	@param Board - The matrix (inner board)
	@param LabelingOptions - Option list for the labeling/2 predicate
  
    Example: doppelblock(6, [4,8,4,5,6,5], [9,7,2,10,3,1], Board, [ffc]).
*/
doppelblock(Size, TopSums, RightSums, Board, LabelingOptions) :- !,
  statistics(runtime, [T0|_]),
  checkArguments(Size, TopSums, RightSums),
  initBoard(Board, Size),
  transpose(Board, TransposeBoard),
  initBoard(TransposeBoard, Size),
  applySumsConstrains(Board, RightSums),
  applySumsConstrains(TransposeBoard, TopSums),
  label(Board, LabelingOptions),
  statistics(runtime, [T1|_]),
  ElapsedTime is T1 - T0,
  format('Solution found in: ~3d seconds', [ElapsedTime]), nl,
  drawBoard(Board, TopSums, RightSums, Size).
doppelblock(_, _, _, _, _) :-
  printUsage, !.


/*
  printAllSolutions(+OutputFile, +Time, -Result, ?Game)
    @brief Writes all the solutions generated during a timeout

    @param OutputFile - The file to write the results to
	@param Time - Timeout in milliseconds (the predicates end once it is reached)
	@param Result - The timout result
	@param Game - A list representing an instance of the game
  
    Example: printAllSolutions('solutions.txt', 5000, Result, [6, _, _, _]).
*/
printAllSolutions(OutputFile, Time, Result, [Size, TopSums, RightSums, Board]) :-
  open(OutputFile, write, X),
  current_output(CO),
  set_output(X),
  printAllSolutions(Time, Result, [Size, TopSums, RightSums, Board]),
  close(X),
  set_output(CO).
printAllSolutions(Time, Result, [Size, TopSums, RightSums, Board]) :-
  time_out((doppelblock(Size, TopSums, RightSums, Board), fail), Time, Result).
printAllSolutions(_, _, _).