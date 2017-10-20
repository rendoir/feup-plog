:-include('utils.pl').


/**
 * Checks if there is an element between (Xi, Yi) and (Xf, Yf). 
 * In Latrunculi, pieces cannot jump over other pieces.
 **/
isElementBetween(Board, X, Y, X, Y).
isElementBetween(Board, Xi, Yi, Xf, Yf) :-
  Yf = Yi, /*Horizontal Move*/
  nextStep(Xi,Xf,Xn),
  %! Get the element that will be moved
  getListElement(Yi, Board, FromRow),
  getListElement(Xn, FromRow, ElementOnBoard),
  isEmptyCell(ElementOnBoard),
  isElementBetween(Board, Xn, Yi, Xf, Yf).

isElementBetween(Board, Xi, Yi, Xf, Yf) :-
  Xf = Xi, /*Vertical Move*/
  nextStep(Yi,Yf,Yn),
  %! Get the element that will be moved
  getListElement(Yn, Board, FromRow),
  getListElement(Xi, FromRow, ElementOnBoard),
  isEmptyCell(ElementOnBoard),
  isElementBetween(Board, Xi, Yn, Xf, Yf).

nextStep(I,F,N) :-
  I < F,
  N is I + 1.

nextStep(I,F,N) :-
  I > F,
  N is I - 1.


/**
 * Checks if the move is orthogonal.
 **/
isOrthogonal(Xi, Yi, Xf, Yf) :-
  %! Check if the move is orthogonal
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
 * Moves a piece from (Xi, Yi) to (Xf, Yf). This substitutes (Xf, Yf) with the cell atom from (Xi, Yi) and sets (Xi, Yi) with the empty cell atom.
 **/
move(Board, Xi, Yi, Xf, Yf, FinalBoard) :-
  % !Check if both cells belong to the board
  isInsideBoard(Xi, Yi),
  isInsideBoard(Xf, Yf),

  % !Check if the move would be orthogonal
  isOrthogonal(Xi, Yi, Xf, Yf),

  % !Check if have element between the movement
  isElementBetween(Board, Xi, Yi, Xf, Yf),

  %! Get the row to where it will be moved
  getListElement(Yf, Board, ToRow),

  %! Get the cell to where it will be moved and check if it is empty
  getListElement(Xf, ToRow, ToCell),
  isEmptyCell(ToCell),

  %! Get the element that will be moved
  getListElement(Yi, Board, FromRow),
  getListElement(Xi, FromRow, ElementToMove),

  %! Replace the empty cell with the element that was moved
  setListElement(Xf, ElementToMove, ToRow, NewToRow),
  setListElement(Yf, NewToRow, Board, NewBoard),

  %! Replace the cell the element moved from with an empty cell
  setListElement(Xi, empty_cell, FromRow, NewFromRow),
  setListElement(Yi, NewFromRow, NewBoard, FinalBoard).
