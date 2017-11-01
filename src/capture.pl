% [-------------------]
% [--CLASSIC CAPTURE--]
% [-------------------]

/**
  Check if a piece if a piece is between enemies
**/
isBetweenEnemies(Board, X, Y) :-
  isBetweenEnemiesHorizontal(Board, X, Y).
isBetweenEnemies(Board, X, Y) :-
  isBetweenEnemiesVertical(Board, X, Y).

/**
 Check if the adjacent pieces are enemies
**/
isBetweenEnemiesHorizontal(Board, X, Y) :-
  getMatrixElement(Y, X, Board, Piece),
  isEnemyHorizontal(Board, X, Y, next, Piece),
  isEnemyHorizontal(Board, X, Y, before, Piece).
isBetweenEnemiesVertical(Board, X, Y) :-
  getMatrixElement(Y, X, Board, Piece),
  isEnemyVertical(Board, X, Y, next, Piece),
  isEnemyVertical(Board, X, Y, before, Piece).

/**
 Check if an adjacent piece is an enemy
**/
isEnemyHorizontal(Board, X, Y, Search, Piece) :-
  stepNumber(X, StepX, Search),
  isInsideBoard(StepX, Y),
  getMatrixElement(Y, StepX, Board, Element),
  isEnemy(Piece, Element).
isEnemyVertical(Board, X, Y, Search, Piece) :-
  stepNumber(Y, StepY, Search),
  isInsideBoard(X, StepY),
  getMatrixElement(StepY, X, Board, Element),
  isEnemy(Piece, Element).

/**
  Get the number of enemies around a piece
**/
getEnemiesAround(Board, X, Y, Counter) :-
  getMatrixElement(Y, X, Board, Piece),
  not(isEmptyCell(Piece)),
  Counter0 is 0,
  check(isEnemyHorizontal(Board, X, Y, next, Piece), Result0),
  Counter1 is Counter0 + Result0,
  check(isEnemyHorizontal(Board, X, Y, before, Piece), Result1),
  Counter2 is Counter1 + Result1,
  check(isEnemyVertical(Board, X, Y, next, Piece), Result2),
  Counter3 is Counter2 + Result2,
  check(isEnemyVertical(Board, X, Y, before, Piece), Result3),
  Counter is Counter3 + Result3.

/**
 Check if an adjacent piece is a friend
**/
isFriendHorizontal(Board, X, Y, Search, Piece) :-
  stepNumber(X, StepX, Search),
  isInsideBoard(StepX, Y),
  getMatrixElement(Y, StepX, Board, Element),
  isFriend(Piece, Element).
isFriendVertical(Board, X, Y, Search, Piece) :-
  stepNumber(Y, StepY, Search),
  isInsideBoard(X, StepY),
  getMatrixElement(StepY, X, Board, Element),
  isFriend(Piece, Element).

/**
  Get the number of friends around a piece
**/
getFriendsAround(Board, X, Y, Counter) :-
  getMatrixElement(Y, X, Board, Piece),
  not(isEmptyCell(Piece)),
  Counter0 is 0,
  check(isFriendHorizontal(Board, X, Y, next, Piece), Result0),
  Counter1 is Counter0 + Result0,
  check(isFriendHorizontal(Board, X, Y, before, Piece), Result1),
  Counter2 is Counter1 + Result1,
  check(isFriendVertical(Board, X, Y, next, Piece), Result2),
  Counter3 is Counter2 + Result2,
  check(isFriendVertical(Board, X, Y, before, Piece), Result3),
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