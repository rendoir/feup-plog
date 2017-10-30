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