:-include('capture.pl').
:-include('utils.pl').

/**
 * Checks if there is an element between (Xi, Yi) and (Xf, Yf).
 **/
 isElementBetween(_, X, Y, X, Y).

 isElementBetween(Board, Xi, Yi, Xf, Yf) :-
   Yf = Yi, /*Horizontal Move*/
   nextStep(Xi,Xf,Xn),
   %! Get the current cell
   getMatrixElement(Yf, Xn, Board, CurrentCell),
   isEmptyCell(CurrentCell),
   isElementBetween(Board, Xn, Yi, Xf, Yf).

 isElementBetween(Board, Xi, Yi, Xf, Yf) :-
   Xf = Xi, /*Vertical Move*/
   nextStep(Yi,Yf,Yn),
   %! Get the current cell
   getMatrixElement(Yn, Xf, Board, CurrentCell),
   isEmptyCell(CurrentCell),
   isElementBetween(Board, Xi, Yn, Xf, Yf).

 
 /**
 * Checks if the move is orthogonal.
 **/
isOrthogonal(Xi, Yi, Xf, Yf) :-
  Xi = Xf ; Yi = Yf.

/**
 * Moves a piece from (Xi, Yi) to (Xf, Yf). This substitutes (Xf, Yf) with the cell atom from (Xi, Yi) and sets (Xi, Yi) with the empty cell atom.
 **/
move(Board, Xi, Yi, Xf, Yf, FinalBoard) :-
  isInsideBoard(Xi, Yi),
  isInsideBoard(Xf, Yf),

  isOrthogonal(Xi, Yi, Xf, Yf),

  getMatrixElement(Yi, Xi, Board, FromCell),
  getMatrixElement(Yf, Xf, Board, ToCell),

  isEmptyCell(ToCell),
  isElementBetween(Board, Xi, Yi, Xf, Yf),

  setMatrixElement(Yi, Xi, empty_cell, Board, ModifiedBoard),
  setMatrixElement(Yf, Xf, FromCell, ModifiedBoard, FinalBoard).
