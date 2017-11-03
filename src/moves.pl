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
  Checks if a move will immobilize its own dux
**/
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :-
  friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, next, horizontal).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :-
  friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, before, horizontal).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :-
  friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, next, vertical).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :-
  friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, before, vertical).

friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, Step, Direction) :-
  getMatrixElement(Yi, Xi, Board, PieceToMove),
  stepDirection(Xf, Yf, StepX, StepY, Step, Direction),  
  getMatrixElement(StepY, StepX, Board, AdjacentPiece),
  isDux(AdjacentPiece),
  isFriend(AdjacentPiece, PieceToMove),
  getFriendsAround(Board, StepX, StepY, CounterF),
  getEnemiesAround(Board, StepX, StepY, CounterE),  
  Counter is CounterF + CounterE,
  getMaxPiecesAround(StepX, StepY, Max),
  DuxMax is Max - 1,
  Counter >= DuxMax.

  /*
moveIsOffensive(Board, Xi, Yi, Xf, Yf) :-
  simulateMove(Board, Xi, Yi, Xf, Yf, SimulationBoard),
  isDuxAround(SimulationBoard, Xf, Yf).

moveIsOffensive(Board, Xi, Yi, Xf, Yf) :-
  simulateMove(Board, Xi, Yi, Xf, Yf, SimulationBoard),
  isSoldierAroundCaptured(SimulationBoard, Xf, Yf).

moveIsDefensive(Board, Xi, Yi, Xf, Yf) :-
  not(moveIsOffensive(Board, Xi, Yi, Xf, Yf)).
  */
simulateMove(Board, Xi, Yi, Xf, Yf, FinalBoard) :-
  getMatrixElement(Yi, Xi, Board, FromCell),
  setMatrixElement(Yi, Xi, empty_cell, Board, ModifiedBoard),
  setMatrixElement(Yf, Xf, FromCell, ModifiedBoard, FinalBoard).

/**
  Moves a piece from (Xi, Yi) to (Xf, Yf). This substitutes (Xf, Yf) with the cell atom from (Xi, Yi) and sets (Xi, Yi) with the empty cell atom.
 **/
move(Board, Xi, Yi, Xf, Yf, FinalBoard) :-
  isInsideBoard(Xi, Yi),
  isInsideBoard(Xf, Yf),
  isOrthogonal(Xi, Yi, Xf, Yf),

  getMatrixElement(Yi, Xi, Board, FromCell),
  getMatrixElement(Yf, Xf, Board, ToCell),

  isEmptyCell(ToCell),

  isElementBetween(Board, Xi, Yi, Xf, Yf),
  not(friendDuxImmobilized(Board, Xi, Yi, Xf, Yf)),
  
  setMatrixElement(Yi, Xi, empty_cell, Board, ModifiedBoard),
  setMatrixElement(Yf, Xf, FromCell, ModifiedBoard, FinalBoard).
