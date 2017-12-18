getColumn(Board, ColumnNumber, Column) :-
  getColumn(Board, ColumnNumber, Column, []).
getColumn([], _, Column, TmpColumn) :-
  Column = TmpColumn.
getColumn([Row | Rest], ColumnNumber, Column, TmpColumn) :-
  element(ColumnNumber, Row, Element),
  append(TmpColumn, [Element], NewTmpColumn), !,
  getColumn(Rest, ColumnNumber, Column, NewTmpColumn).


flattenBoard(Board, Flat) :-
  flattenBoard(Board, Flat, []).
flattenBoard([], Flat, Flat).
flattenBoard([Row | Rest], Flat, TmpFlat) :-
  append(TmpFlat, Row, NewTmpFlat),
  flattenBoard(Rest, Flat, NewTmpFlat).


checkArguments(Size, TopSums, LeftSums) :-
  Size > 1,
  length(TopSums, Size),
  length(LeftSums, Size).
