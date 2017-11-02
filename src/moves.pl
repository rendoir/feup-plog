:-include('capture.pl').
:-include('utils.pl').

/**
  Checks if there is an element between (Xi, Yi) and (Xf, Yf).
**/
isElementBetween(_, X, Y, X, Y).

isElementBetween(Board, Xi, Yi, Xf, Yf) :-
  Yf = Yi, /*Horizontal Move*/
  nextStep(Xi,Xf,Xn),
  getMatrixElement(Yf, Xn, Board, CurrentCell),
  isEmptyCell(CurrentCell),
  isElementBetween(Board, Xn, Yi, Xf, Yf).

isElementBetween(Board, Xi, Yi, Xf, Yf) :-
  Xf = Xi, /*Vertical Move*/
  nextStep(Yi,Yf,Yn),
  getMatrixElement(Yn, Xf, Board, CurrentCell),
  isEmptyCell(CurrentCell),
  isElementBetween(Board, Xi, Yn, Xf, Yf).
  
   
/**
  Checks if the move is orthogonal.
 **/
isOrthogonal(Xi, Yi, Xf, Yf) :-
  Xi = Xf ; Yi = Yf.

/**
  Calculates the maximum number of pieces that can be around a piece
**/
getMaxPiecesAround(X, Y, Max) :-
  isInCorner(X, Y),
  Max is 2.
getMaxPiecesAround(X, Y, Max) :-
  isInBorder(X, Y),
  Max is 3.
getMaxPiecesAround(_, _, Max) :-
  Max is 4.

/**
  Checks if a move will immobilize its own dux
**/
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :-
  friendDuxImmobilizedHorizontal(Board, Xi, Yi, Xf, Yf, next).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :-
  friendDuxImmobilizedHorizontal(Board, Xi, Yi, Xf, Yf, before).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :-
  friendDuxImmobilizedVertical(Board, Xi, Yi, Xf, Yf, next).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :-
  friendDuxImmobilizedVertical(Board, Xi, Yi, Xf, Yf, before).

friendDuxImmobilizedHorizontal(Board, Xi, Yi, Xf, Yf, Search) :-
  getMatrixElement(Yi, Xi, Board, PieceToMove),
  stepNumber(Xf, NextX, Search),
  getMatrixElement(Yf, NextX, Board, AdjacentPiece),
  isDux(AdjacentPiece),
  isFriend(AdjacentPiece, PieceToMove),
  getFriendsAround(Board, NextX, Yf, CounterF),
  getEnemiesAround(Board, NextX, Yf, CounterE),
  Counter is CounterF + CounterE,
  getMaxPiecesAround(NextX, Yf, Max),
  DuxMax is Max - 1,
  Counter < DuxMax.

friendDuxImmobilizedVertical(Board, Xi, Yi, Xf, Yf, Search) :-
  getMatrixElement(Yi, Xi, Board, PieceToMove),
  stepNumber(Yf, NextY, Search),
  getMatrixElement(NextY, Xf, Board, AdjacentPiece),
  isDux(AdjacentPiece),
  isFriend(AdjacentPiece, PieceToMove),
  getFriendsAround(Board, NextX, Yf, CounterF),
  getEnemiesAround(Board, NextX, Yf, CounterE),
  Counter is CounterF + CounterE,
  getMaxPiecesAround(Xf, NextY, Max),
  DuxMax is Max - 1,
  Counter < DuxMax.


/**
  Moves a piece from (Xi, Yi) to (Xf, Yf). This substitutes (Xf, Yf) with the cell atom from (Xi, Yi) and sets (Xi, Yi) with the empty cell atom.
 **/
move(Board, Xi, Yi, Xf, Yf, FinalBoard) :-
  isInsideBoard(Xi, Yi),
  isInsideBoard(Xf, Yf),

  isOrthogonal(Xi, Yi, Xf, Yf),
  isElementBetween(Board, Xi, Yi, Xf, Yf),
  not(friendDuxImmobilized(Board, Xi, Yi, Xf, Yf)),

  getMatrixElement(Yi, Xi, Board, FromCell),
  getMatrixElement(Yf, Xf, Board, ToCell),

  isEmptyCell(ToCell),

  setMatrixElement(Yi, Xi, empty_cell, Board, ModifiedBoard),
  setMatrixElement(Yf, Xf, FromCell, ModifiedBoard, FinalBoard).
