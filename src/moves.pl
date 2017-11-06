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
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :- friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, next, horizontal).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :- friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, before, horizontal).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :- friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, next, vertical).
friendDuxImmobilized(Board, Xi, Yi, Xf, Yf) :- friendDuxImmobilized(Board, Xi, Yi, Xf, Yf, before, vertical).
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


/**
  Checks if there is an enemy dux around (X, Y)
**/
isEnemyDuxAround(Board, X, Y) :- isEnemyDuxAround(Board, X, Y, next, horizontal).
isEnemyDuxAround(Board, X, Y) :- isEnemyDuxAround(Board, X, Y, before, horizontal).
isEnemyDuxAround(Board, X, Y) :- isEnemyDuxAround(Board, X, Y, next, vertical).
isEnemyDuxAround(Board, X, Y) :- isEnemyDuxAround(Board, X, Y, before, vertical).
isEnemyDuxAround(Board, X, Y, Step, Direction) :-
  getMatrixElement(Y, X, Board, Piece),
  stepDirection(X, Y, StepX, StepY, Step, Direction),
  getMatrixElement(StepY, StepX, Board, AdjacentPiece),
  isDux(AdjacentPiece),
  isEnemy(AdjacentPiece, Piece).  


/**
  Check if move is offensive
**/
moveIsOffensive(Board, Xi, Yi, Xf, Yf) :-
  simulateMove(Board, Xi, Yi, Xf, Yf, SimulationBoard),
  isEnemyDuxAround(SimulationBoard, Xf, Yf).
moveIsOffensive(Board, Xi, Yi, Xf, Yf) :-
  simulateMove(Board, Xi, Yi, Xf, Yf, SimulationBoard),
  isEnemySoldierCapturedClassic(SimulationBoard, Xf, Yf).
moveIsOffensive(Board, Xi, Yi, Xf, Yf) :-
  isEnemySoldierCapturedXII(Board, Xi, Yi, Xf, Yf).


/**
  Check if move is defensive
**/
moveIsDefensive(Board, Xi, Yi, Xf, Yf) :-
  not(moveIsOffensive(Board, Xi, Yi, Xf, Yf)).


/**
  Simulates a move without checking if it is a possible move
**/
simulateMove(Board, Xi, Yi, Xf, Yf, FinalBoard) :-
  getMatrixElement(Yi, Xi, Board, FromCell),
  setMatrixElement(Yi, Xi, empty_cell, Board, ModifiedBoard),
  setMatrixElement(Yf, Xf, FromCell, ModifiedBoard, FinalBoard).


/**
  Check if a soldier can move given that he could be locked
  Even if he is locked, there are situations where he can still move
**/
checkLockedSoldier(Board, Xi, Yi, _, _) :- not(isSoldier(Board, Xi, Yi)).
checkLockedSoldier(Board, Xi, Yi, Xf, Yf) :- moveIsOffensive(Board, Xi, Yi, Xf, Yf).
checkLockedSoldier(Board, Xi, Yi, _, _) :-
  not(checkLockedSoldier(Board, Xi, Yi, _, _, next, horizontal)),
  not(checkLockedSoldier(Board, Xi, Yi, _, _, before, horizontal)),
  not(checkLockedSoldier(Board, Xi, Yi, _, _, next, vertical)),
  not(checkLockedSoldier(Board, Xi, Yi, _, _, before, vertical)).
checkLockedSoldier(Board, X, Y, _, _, Step, Direction) :- 
  getMatrixElement(Y, X, Board, Piece),
  stepDirection(X, Y, StepX, StepY, Step, Direction),
  getMatrixElement(StepY, StepX, Board, Adjacent),
  isEnemy(Piece, Adjacent),
  getEnemiesAround(Board, StepX, StepY, Counter),
  Counter < 2.
  
  

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
  checkLockedSoldier(Board, Xi, Yi, Xf, Yf),
  not(friendDuxImmobilized(Board, Xi, Yi, Xf, Yf)),
  
  captureXII(Board, Xi, Yi, Xf, Yf, CaptureBoard),

  setMatrixElement(Yi, Xi, empty_cell, CaptureBoard, MovedBoard),
  setMatrixElement(Yf, Xf, FromCell, MovedBoard, MovedBoard2),
  
  captureClassic(MovedBoard2, Xf, Yf, FinalBoard).
