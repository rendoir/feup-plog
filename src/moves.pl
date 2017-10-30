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
 * Checks if the 2D point (X,Y) is inside the board.
 **/
isInsideBoard(X, Y) :-
  X >= 0, X =< 7,
  Y >= 0, Y =< 7.


/**
 * Checks if the cell is set with an empty cell atom.
 **/
isEmptyCell(empty_cell).


/**
 * Checks if an element is in the corner of the board. (X,Y)
 **/
isInCorner(0, 0).
isInCorner(7, 0).
isInCorner(0, 7).
isInCorner(7, 7).


/**
 * Checks if an element is in the border. (X,Y)
**/
isInBorder(0, _).
isInBorder(7, _).
isInBorder(_, 0).
isInBorder(_, 7).


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
