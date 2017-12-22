/*
  display.pl

  This file is responsible for the console interface of the program.
*/


/*
  drawBoard(+Board, +TopSums, +RightSums, +Size)
    @brief Prints the board to the screen

	@param Board - The matrix (inner board)
	@param TopSums - The sums on top of the board
	@param RightSums - The sums on the right of the board
	@param Size - The size of the matrix
*/
drawBoard(Board, TopSums, RightSums, Size) :-
  write('   '), drawTopSums(TopSums), nl,
  write('   '), drawHeader(Size), nl,
  drawBoard(Board, RightSums, Size), !.
drawBoard([], _, _).
drawBoard([Row | Rest], [Sum | OtherSums], Size) :-
  drawUpSeparatorLine(Size),
  write('  |'),
  drawRow(Row), 
  write('  '),
  write(Sum), nl,
  drawDownSeparatorLine(Size),
  drawBoard(Rest, OtherSums, Size).


/*
  drawRow(+Row)
    @brief Prints a row of the board

	@param Row - A row of the board
*/
drawRow([]).
drawRow([Cell | Remainder]) :-
  write('  '),
  drawCell(Cell),
  write('  |'),
  drawRow(Remainder).


/*
  drawUpSeparatorLine(+Size)
    @brief Prints the upper separator between rows

	@param Size - The size of the matrix
*/
drawUpSeparatorLine(Size) :-
  write('  |'),
  drawUpSeparatorLine(Size, Size), nl.
drawUpSeparatorLine(_, 0).
drawUpSeparatorLine(Size, Counter) :-
  write('     |'),
  NextCounter is Counter - 1,
  drawUpSeparatorLine(Size, NextCounter).


/*
  drawDownSeparatorLine(+Size)
    @brief Prints the bottom separator between rows

	@param Size - The size of the matrix
*/
drawDownSeparatorLine(Size) :-
  write('  |'),
  drawDownSeparatorLine(Size, Size), nl.
drawDownSeparatorLine(_, 0).
drawDownSeparatorLine(Size, Counter) :-
  write('_____|'),
  NextCounter is Counter - 1,
  drawDownSeparatorLine(Size, NextCounter).


/*
  drawHeader(+Size)
    @brief Prints the separator between the TopSums and the matrix

	@param Size - The size of the matrix
*/
drawHeader(Size) :-
  drawHeader(Size, Size).
drawHeader(_, 0).
drawHeader(Size, Counter) :-
  write('_____ '),
  NextCounter is Counter - 1,
  drawHeader(Size, NextCounter).


/*
  drawTopSums(+TopSums)
    @brief Prints the top sums

	@param TopSums - The sums on top of the board
*/
drawTopSums([]).
drawTopSums([Sum | Rest]) :-
  write('  '), write(Sum), write('   '),
  drawTopSums(Rest).


/*
  drawCell(+Cell)
    @brief Prints a cell. If the cell is zero, it is considered a black cell.

	@param Cell - A matrix element
*/
drawCell(0) :-
  write('X').
drawCell(Cell) :-
  write(Cell).

/*
  printUsage
    @brief Prints the usage in case the arguments are wrong.
*/
printUsage :-
  write('Usage: doppelblock(?Size, ?TopSums, ?RightSums, ?Board, [+LabelingOptions]).'), nl,
  write('  Size            - Integer      - The Size of the Board'), nl,
  write('  TopSums         - Integer List - The sums on top of the board'), nl,
  write('  RightSums       - Integer List - The sums on the left of the board'), nl,
  write('  Board           - Integer List - The Board correspondent to the sums'), nl,
  write('  LabelingOptions - Atom List    - Options to labeling the variables'), nl.
