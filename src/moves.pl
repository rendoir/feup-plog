:-include('utils.pl').

/**isValidMove(Board, Xi, Yi, Xf, Yf).		%! Checks if the move from (Xi, Yi) to (Xf, Yf) can be done based on the set of rules of the game.

isInsideBoard(X, Y).				          %! Checks if the 2D point (X,Y) is inside the board.

isEmptyCell(Board, X, Y).					    %! Checks if the cell (X,Y) is set with an empty cell atom.
**/
/**
 * Moves a piece from (Xi, Yi) to (Xf, Yf). This substitutes (Xf, Yf) with the cell atom from (Xi, Yi) and sets (Xi, Yi) with the empty cell atom.
**/
move(Board, Xi, Yi, Xf, Yf, NewBoard) :-
  getListElement(Yi, Board, Row),
  getListElement(Xi, Row, ElementToMove),
  setListElement(Xf, ElementToMove, Row, NewRow),
  setListElement(Yf, NewRow, Board, NewBoard).
