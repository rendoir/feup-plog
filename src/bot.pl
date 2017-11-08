:-include('moves.pl').

moveComputer(Board, Player, Diffulty, NewBoard) :- 
  getAllMoves(Board, Player, MoveList),
  pickMove(Diffulty, MoveList, Move),
  applyComputerMove(Board, Move, NewBoard).


pickMove(1, MoveList, Move) :-
  length(MoveList, ListLength),
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
  runThroughBoard(Board, Player, MoveList, 0).

runThroughBoard(_, _, _, 8).
runThroughBoard(Board, Player, MoveList, Row) :-
  Row < 8,
  runThroughRow(Board, Player, MoveList, Row, 0),
  NextRow is Row + 1,
  runThroughBoard(Board, Player, MoveList, NextRow).

runThroughRow(_, _, _, _, 8).
runThroughRow(Board, Player, MoveList, 0, 0) :-
  MoveList = [],
  runThroughRow(Board, Player, MoveList, 0, 0).
runThroughRow(Board, Player, MoveList, Row, Column) :-
  Column < 8,
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
   getPieceMoveList(Board, Player, Y, X, _, _, Step, Direction, PieceMoves, -1).
/**
  -1 -> First iteration
  0  -> Last iteration failed
  1  -> Last iteration succeeded
**/
getPieceMoveList(_, _, _, _, _, _, _, _, _, 0).
getPieceMoveList(Board, Player, Y, X, _, _, Step, Direction, PieceMoves, -1) :-
  PieceMoves = [],
  stepDirection(X, Y, CheckX, CheckY, Step, Direction), 
  check(move(Player, Board, X, Y, CheckX, CheckY, _), Result),
  getPieceMoveList(Board, Player, Y, X, CheckX, CheckY, Step, Direction, PieceMoves, Result).
getPieceMoveList(Board, Player, Y, X, StepX, StepY, Step, Direction, PieceMoves, 1) :-
  append(PieceMoves, [[X, Y, StepX, StepY]], NewPieceMoves),
  stepDirection(StepX, StepY, CheckX, CheckY, Step, Direction), 
  check(move(Player, Board, X, Y, CheckX, CheckY, _), Result),
  getPieceMoveList(Board, Player, Y, X, CheckX, CheckY, Step, Direction, NewPieceMoves, Result).
