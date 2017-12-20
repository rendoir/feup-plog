
label(Board) :-
  flattenBoard(Board, Label),!,
  labeling([], Label).

label(Board, LabelingOptions) :-
  flattenBoard(Board, Label),!,
  labeling(LabelingOptions, Label).

flattenBoard(Board, Flat) :-
  flattenBoard(Board, Flat, []).
flattenBoard([], Flat, Flat).
flattenBoard([Row | Rest], Flat, TmpFlat) :-
  append(TmpFlat, Row, NewTmpFlat),
  flattenBoard(Rest, Flat, NewTmpFlat).

checkArguments(Size, TopSums, LeftSums) :-
  length(TopSums, Size),
  length(LeftSums, Size),
  Size > 1.

