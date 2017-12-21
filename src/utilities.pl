/*
  utilities.pl

  This file is responsible for supplying utility predicates.
*/


/*
  label(+Board, +LabelingOptions)
    @brief Labels the board variables

	@param Board - The matrix (inner board)
	@param LabelingOptions - Option list for the labeling/2 predicate
*/
label(Board, LabelingOptions) :-
  flattenBoard(Board, Label),!,
  labeling(LabelingOptions, Label).


/*
  flattenBoard(+Board, -Flat)
    @brief Takes a board (list of lists) and returns a single list containing all variables

	@param Board - The matrix (inner board)
	@param Flat - A list containing all variables from Board
*/
flattenBoard(Board, Flat) :-
  flattenBoard(Board, Flat, []).
flattenBoard([], Flat, Flat).
flattenBoard([Row | Rest], Flat, TmpFlat) :-
  append(TmpFlat, Row, NewTmpFlat),
  flattenBoard(Rest, Flat, NewTmpFlat).


/*
  checkArguments(?Size, ?TopSums, ?RightSums)
    @brief Checks if the arguments provided are valid

    @param Size - The size of the matrix
	@param TopSums - The sums on top of the board
	@param RightSums - The sums on the right of the board
*/
checkArguments(Size, TopSums, LeftSums) :-
  length(TopSums, Size),
  length(LeftSums, Size),
  Size > 1.
  