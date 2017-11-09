:-include('moves.pl').

moveComputer(Board, Player, Diffulty, NewBoard) :-
  getAllMoves(Board, Player, MoveList),
  write('GOT ALL MOVES'), nl,
  pickMove(Diffulty, MoveList, Move),
  write('PICKED A MOVE'), nl,
  applyComputerMove(Board, Move, NewBoard),
  write('APPLIED MOVE'), nl.


pickMove(1, MoveList, Move) :-
  length(MoveList, ListLength),
  write('LIST LENGTH='), write(ListLength), nl,
  random(0, ListLength, RandomIndex),
  getListElement(RandomIndex, MoveList, Move).
/* TODO */
%pickMove(2, MoveList, Move).


applyComputerMove(Board, Move, NewBoard) :-
  getListElement(0, Move, Xi),
  getListElement(1, Move, Yi),
  getListElement(2, Move, Xf),
  getListElement(3, Move, Yf),
  move(Board, Xi, Yi, Xf, Yf, NewBoard).


/* TODO */
getAllMoves(Board, Player, MoveList) :-
  runThroughBoard(Board, Player, MoveList, -1).

runThroughBoard(_, _, _, Row) :- Row >= 8.
runThroughBoard(Board, Player, MoveList, -1) :-
  MoveList = [],
  runThroughBoard(Board, Player, MoveList, 0).
runThroughBoard(Board, Player, MoveList, Row) :-
  runThroughRow(Board, Player, MoveList, Row, 0),
  NextRow is Row + 1,
  runThroughBoard(Board, Player, MoveList, NextRow).

runThroughRow(_, _, _, _, Column) :- Column >= 8.
runThroughRow(Board, Player, MoveList, Row, Column) :-
  getPieceMoveList(Board, Player, Row, Column, PieceMoves),
  append(MoveList, PieceMoves, NewMoveList),
  NextColumn is Column + 1,
  runThroughRow(Board, Player, NewMoveList, Row, NextColumn).

getPieceMoveList(Board, Player, Row, Column, PieceMoves) :-
  getPieceMoveList(Board, Player, Row, Column, next, horizontal, PieceMoves1),
  getPieceMoveList(Board, Player, Row, Column, before, horizontal, PieceMoves2),
  getPieceMoveList(Board, Player, Row, Column, next, vertical, PieceMoves3),
  getPieceMoveList(Board, Player, Row, Column, before, vertical, PieceMoves4),
  append(PieceMoves1, PieceMoves2, PieceMovesTmp),
  append(PieceMovesTmp, PieceMoves3, PieceMovesTmp2),
  append(PieceMovesTmp2, PieceMoves4, PieceMoves).

getPieceMoveList(Board, Player, Y, X, Step, Direction, PieceMoves) :-
   getPieceMoveList(Board, Player, Y, X, _, _, Step, Direction, _, PieceMoves, 1, -1).
/**
  -1 -> First iteration
  0  -> Last iteration failed
  1  -> Last iteration succeeded
**/
getPieceMoveList(_, _, _, _, _, _, _, _, TmpMoves, FinalMoves, NumberSteps, _) :- NumberSteps >= 8, FinalMoves = TmpMoves.
getPieceMoveList(Board, Player, Y, X, StepX, StepY, Step, Direction, PieceMoves, FinalMoves, NumberSteps, 0) :-
  stepDirection(StepX, StepY, CheckX, CheckY, Step, Direction),
  check(move(Player, Board, X, Y, CheckX, CheckY, _), Result),
  NextNumberSteps is NumberSteps + 1,
  getPieceMoveList(Board, Player, Y, X, CheckX, CheckY, Step, Direction, PieceMoves, FinalMoves, NextNumberSteps, Result).
getPieceMoveList(Board, Player, Y, X, _, _, Step, Direction, PieceMoves, FinalMoves, NumberSteps, -1) :-
  PieceMoves = [],
  stepDirection(X, Y, CheckX, CheckY, Step, Direction),
  check(move(Player, Board, X, Y, CheckX, CheckY, _), Result),
  NextNumberSteps is NumberSteps + 1,
  getPieceMoveList(Board, Player, Y, X, CheckX, CheckY, Step, Direction, PieceMoves, FinalMoves, NextNumberSteps, Result).
getPieceMoveList(Board, Player, Y, X, StepX, StepY, Step, Direction, PieceMoves, FinalMoves, NumberSteps, 1) :-
  append(PieceMoves, [[X, Y, StepX, StepY]], NewPieceMoves),
  stepDirection(StepX, StepY, CheckX, CheckY, Step, Direction),
  check(move(Player, Board, X, Y, CheckX, CheckY, _), Result),
  NextNumberSteps is NumberSteps + 1,
  getPieceMoveList(Board, Player, Y, X, CheckX, CheckY, Step, Direction, NewPieceMoves, FinalMoves, NextNumberSteps, Result).
