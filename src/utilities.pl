getColumn(Board, ColumnNumber, Column) :-
  getColumn(Board, ColumnNumber, Column, []).
getColumn([], _, Column, TmpColumn) :-
  Column = TmpColumn.
getColumn([Row | Rest], ColumnNumber, Column, TmpColumn) :-
  element(ColumnNumber, Row, Element),
  append(TmpColumn, [Element], NewTmpColumn), !,
  getColumn(Rest, ColumnNumber, Column, NewTmpColumn).
