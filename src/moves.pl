isValidMove(Xi, Yi, Xf, Yf).		%! Checks if the move from (Xi, Yi) to (Xf, Yf) can be done based on the set of rules of the game.

isInsideBoard(X, Y).				%! Checks if the 2D point (X,Y) is inside the board.

isEmptyCell(X, Y).					%! Checks if the cell (X,Y) is set with an empty cell atom.

move(Xi, Yi, Xf, Yf).				%! Moves a piece from (Xi, Yi) to (Xf, Yf). This substitutes (Xf, Yf) with the cell atom from (Xi, Yi) and sets (Xi, Yi) with the empty cell atom.
