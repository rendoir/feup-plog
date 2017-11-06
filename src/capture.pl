/**
  Check if a piece if a piece is between enemies
**/
isBetweenEnemies(Board, X, Y) :-
  isEnemyAround(Board, X, Y, next, horizontal),
  isEnemyAround(Board, X, Y, before, horizontal).
isBetweenEnemies(Board, X, Y) :-
  isEnemyAround(Board, X, Y, next, vertical),
  isEnemyAround(Board, X, Y, before, vertical).

/**
 Check if an adjacent piece is an enemy
**/
isEnemyAround(Board, X, Y, Step, Direction) :-
  getMatrixElement(Y, X, Board, Piece),
  stepDirection(X, Y, StepX, StepY, Step, Direction),
  isInsideBoard(StepX, StepY),
  getMatrixElement(StepY, StepX, Board, Element),
  isEnemy(Piece, Element).
isEnemyAround(Board, X, Y, Step, Direction, Piece) :-
  stepDirection(X, Y, StepX, StepY, Step, Direction),
  isInsideBoard(StepX, StepY),
  getMatrixElement(StepY, StepX, Board, Element),
  isEnemy(Piece, Element).

/**
  Get the number of enemies around a piece
**/
getEnemiesAround(Board, X, Y, Counter) :-
  getMatrixElement(Y, X, Board, Piece),
  not(isEmptyCell(Piece)),
  Counter0 is 0,
  check(isEnemyAround(Board, X, Y, next, horizontal, Piece), Result0),
  Counter1 is Counter0 + Result0,
  check(isEnemyAround(Board, X, Y, before, horizontal, Piece), Result1),
  Counter2 is Counter1 + Result1,
  check(isEnemyAround(Board, X, Y, next, vertical, Piece), Result2),
  Counter3 is Counter2 + Result2,
  check(isEnemyAround(Board, X, Y, before, vertical, Piece), Result3),
  Counter is Counter3 + Result3.

/**
 Check if an adjacent piece is a friend
**/
isFriendAround(Board, X, Y, Step, Direction) :-
  getMatrixElement(Y, X, Board, Piece),
  stepDirection(X, Y, StepX, StepY, Step, Direction),
  isInsideBoard(StepX, StepY),
  getMatrixElement(StepY, StepX, Board, Element),
  isFriend(Piece, Element).
isFriendAround(Board, X, Y, Step, Direction, Piece) :-
  stepDirection(X, Y, StepX, StepY, Step, Direction),
  isInsideBoard(StepX, StepY),
  getMatrixElement(StepY, StepX, Board, Element),
  isFriend(Piece, Element).

/**
  Get the number of friends around a piece
**/
getFriendsAround(Board, X, Y, Counter) :-
  getMatrixElement(Y, X, Board, Piece),
  not(isEmptyCell(Piece)),
  Counter0 is 0,
  check(isFriendAround(Board, X, Y, next, horizontal, Piece), Result0),
  Counter1 is Counter0 + Result0,
  check(isFriendAround(Board, X, Y, before, horizontal, Piece), Result1),
  Counter2 is Counter1 + Result1,
  check(isFriendAround(Board, X, Y, next, vertical, Piece), Result2),
  Counter3 is Counter2 + Result2,
  check(isFriendAround(Board, X, Y, before, vertical, Piece), Result3),
  Counter is Counter3 + Result3.

/**
  Get the number of blocked paths
**/
getBlockedPaths(Board, X, Y, Counter) :-
  getEnemiesAround(Board, X, Y, CounterE),
  CounterE > 0,
  getFriendsAround(Board, X, Y, CounterF),
  Counter is CounterE + CounterF.
getBlockedPaths(_, _, _, Counter) :- Counter is 0.

/**
  Captures a piece, removing it from the board
**/
capturePiece(Board, X, Y, ModifiedBoard) :-
  setMatrixElement(Y, X, empty_cell, Board, ModifiedBoard).

/**
  Check if a soldier around is captured by the classic rules
**/
isEnemySoldierCapturedClassic(Board, Xf, Yf) :- isEnemySoldierCapturedClassic(Board, Xf, Yf, next, horizontal).
isEnemySoldierCapturedClassic(Board, Xf, Yf) :- isEnemySoldierCapturedClassic(Board, Xf, Yf, before, horizontal).
isEnemySoldierCapturedClassic(Board, Xf, Yf) :- isEnemySoldierCapturedClassic(Board, Xf, Yf, next, vertical).
isEnemySoldierCapturedClassic(Board, Xf, Yf) :- isEnemySoldierCapturedClassic(Board, Xf, Yf, before, vertical).
isEnemySoldierCapturedClassic(Board, X, Y, Step, Direction) :-
  stepDirection(X, Y, StepX, StepY, Step, Direction),
  isCaptured(Board, StepX, StepY).

/**
  Check if a soldier is captured by the XII rules
**/
isEnemySoldierCapturedXII(Board, Xi, Yi, Xf, Yf) :- isPushAndCrush(Board, Xi, Yi, Xf, Yf, _, _).


/**
  Check if a move causes a Push and Crush attack
**/
isPushAndCrush(Board, Xi, Yi, Xf, Yf, EnemyX, EnemyY) :- 
  getMatrixElement(Yi, Xi, Board, Piece),
  getDirection(Xi, Yi, Xf, Yf, Direction),
  getStep(Xi, Yi, Xf, Yf, Step, Direction),
  stepDirection(Xf, Yf, FriendX, FriendY, Step, Direction),
  getMatrixElement(FriendY, FriendX, Board, FriendPiece),
  isFriend(Piece, FriendPiece),
  stepDirection(FriendX, FriendY, EnemyX, EnemyY, Step, Direction),
  getMatrixElement(EnemyY, EnemyX, Board, EnemyPiece),
  isEnemy(Piece, EnemyPiece),
  isSoldier(EnemyPiece).


/**
  Check if a soldier should be captured
**/
isCaptured(Board, X, Y) :-
  isInCorner(X, Y),
  isSoldier(Board, X, Y),
  getEnemiesAround(Board, X, Y, Counter),
  Counter =:= 2.
isCaptured(Board, X, Y) :-
  isInBorder(X, Y),
  isSoldier(Board, X, Y),
  getEnemiesAround(Board, X, Y, Counter),
  Counter >= 2.
isCaptured(Board, X, Y) :-
  not(isInCorner(X, Y)),
  not(isInBorder(X, Y)),
  isSoldier(Board, X, Y),
  isBetweenEnemies(Board, X, Y).

/**
  Check if a dux should be captured
**/
isCaptured(Board, X, Y) :-
  isInCorner(X, Y),
  isDux(Board, X, Y),
  getBlockedPaths(Board, X, Y, Counter),
  Counter =:= 2.
isCaptured(Board, X, Y) :-
  isInBorder(X, Y),
  isDux(Board, X, Y),
  getBlockedPaths(Board, X, Y, Counter),
  Counter =:= 3.
isCaptured(Board, X, Y) :-
  not(isInCorner(X, Y)),
  not(isInBorder(X, Y)),
  isDux(Board, X, Y),
  getBlockedPaths(Board, X, Y, Counter),
  Counter =:= 4.


capturePushAndCrush(Board, Xi, Yi, Xf, Yf, NewBoard) :-
  isPushAndCrush(Board, Xi, Yi, Xf, Yf, EnemyX, EnemyY),
  capturePiece(Board, EnemyX, EnemyY, NewBoard).
capturePushAndCrush(Board, _, _, _, _, NewBoard) :-
  NewBoard = Board.


captureXII(Board, Xi, Yi, Xf, Yf, CaptureBoard) :-
  capturePushAndCrush(Board, Xi, Yi, Xf, Yf, CaptureBoard).

captureClassic(Board, Xf, Yf, Step, Direction, FinalBoard) :-
  stepDirection(Xf, Yf, StepX, StepY, Step, Direction),
  isInsideBoard(StepX, StepY),
  isCaptured(Board, StepX, StepY),
  capturePiece(Board, StepX, StepY, FinalBoard).
captureClassic(Board, _, _, _, _, FinalBoard) :-
  FinalBoard = Board.

captureClassic(Board, Xf, Yf, FinalBoard) :-
  captureClassic(Board, Xf, Yf, next, horizontal, Board2),
  captureClassic(Board2, Xf, Yf, before, horizontal, Board3),
  captureClassic(Board3, Xf, Yf, next, vertical, Board4),
  captureClassic(Board4, Xf, Yf, before, vertical, FinalBoard).  
