:-include('moves.pl').

moveComputer(Board, Player, NewBoard, Difficulty) :-
  getAllMoves(Board, Player, MoveList),
  pickMove(Difficulty, MoveList, Move),
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
  format('  Moving from (~d,~d) to (~d,~d)', [Xi, Yi, Xf, Yf]), nl,
  pressEnterToContinue,
  move(Board, Xi, Yi, Xf, Yf, NewBoard).


/* TODO */
getAllMoves(Board, Player, MoveList) :-
  runThroughBoard(Board, Player, _, MoveList, -1).

runThroughBoard(_, _, MoveList, FinalMoveList, Row) :- Row >= 8, FinalMoveList = MoveList.
runThroughBoard(Board, Player, MoveList, FinalMoveList, -1) :-
  MoveList = [],
  runThroughBoard(Board, Player, MoveList, FinalMoveList, 0).
runThroughBoard(Board, Player, MoveList, FinalMoveList, Row) :-
  runThroughRow(Board, Player, MoveList, FinalMoveListRow, Row, 0),
  NextRow is Row + 1,
  runThroughBoard(Board, Player, FinalMoveListRow, FinalMoveList, NextRow).

runThroughRow(_, _, MoveList, FinalMoveListRow, _, Column) :- Column >= 8, FinalMoveListRow = MoveList.
runThroughRow(Board, Player, MoveList, FinalMoveListRow, Row, Column) :-
  getPieceMoveList(Board, Player, Row, Column, PieceMoves),
  append(MoveList, PieceMoves, NewMoveList),
  NextColumn is Column + 1,
  runThroughRow(Board, Player, NewMoveList, FinalMoveListRow, Row, NextColumn).

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
  getPieceMoveList/12:
   Board, Player, Row, Column, LastCheckedX, LastCheckedY, Step, Direction,
   MoveList - temporary (unified to [] in the first iteration),
   FinalMoveList - final (not unified until stop condition),
   NumberSteps - squares visited in the current step and direction,
   Result - result of the last move checked (-1 -> first iteration, 0 -> last move failed, 1 -> last move succeeded).
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
