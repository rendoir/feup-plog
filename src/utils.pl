getListElement(0, [HeadElement | _], HeadElement).
getListElement(Index, [_ | RemainingElements], Element):-
	NewIndex is Index - 1,
	getListElement(NewIndex, RemainingElements, Element).

setListElement(0, Element, [_ | Tail], [Element | Tail]).
setListElement(Index, Element, [Head | Tail], [Head | NewTail]):-
  	NewIndex is Index - 1,
  	setListElement(NewIndex, Element, Tail, NewTail).

getMatrixElement(0, ElementColumn, [Row|_], Element):-
	getListElement(ElementColumn, Row, Element).
getMatrixElement(ElementRow, ElementColumn, [_|RemainingLists], Element):-
	isInsideBoard(ElementColumn, ElementRow),
	NextRow is ElementRow - 1,
	getMatrixElement(NextRow, ElementColumn, RemainingLists, Element).

setMatrixElement(0, ElementColumn, NewElement, [OldRow|RemainingRows], [NewRow|RemainingRows]):-
	setListElement(ElementColumn, NewElement, OldRow, NewRow).
setMatrixElement(ElementRow, ElementColumn, NewElement, [Row|RemainingRows], [Row|ModifiedRemainingRows]):-
	isInsideBoard(ElementColumn, ElementRow),
	NextRow is ElementRow - 1,
	setMatrixElement(NextRow, ElementColumn, NewElement, RemainingRows, ModifiedRemainingRows).

stepDirection(X, Y, StepX, StepY, Step, horizontal) :-
	stepNumber(X, StepX, Step),
	StepY is Y.
stepDirection(X, Y, StepX, StepY, Step, vertical) :-
	stepNumber(Y, StepY, Step),
	StepX is X.

stepNumber(Input, Output, next) :- Output is Input + 1.
stepNumber(Input, Output, before) :- Output is Input - 1.

nextStep(I,F,N) :-
   I < F,
   N is I + 1.
nextStep(I,F,N) :-
   I > F,
   N is I - 1.

getDirection(Xi, _, Xf, _, Direction) :-
  Xi =:= Xf,
  Direction = vertical.
getDirection(_, Yi, _, Yf, Direction) :-
  Yi =:= Yf,
  Direction = horizontal.

getStep(Xi, _, Xf, _, Step, horizontal) :-
  Xf > Xi,
  Step = next.
getStep(Xi, _, Xf, _, Step, horizontal) :-
  Xf < Xi,
  Step = before.
getStep(_, Yi, _, Yf, Step, vertical) :-
  Yf > Yi,
  Step = next.
getStep(_, Yi, _, Yf, Step, vertical) :-
  Yf < Yi,
  Step = before.


/**
  Calculates the maximum number of pieces that can be around a piece
**/
getMaxPiecesAround(X, Y, Max) :-
  isInCorner(X, Y),
  Max is 2.
getMaxPiecesAround(X, Y, Max) :-
  isInBorder(X, Y),
  Max is 3.
getMaxPiecesAround(_, _, Max) :-
  Max is 4.


not(Goal) :- Goal, !, fail.
not(_).

check(Goal, Result) :- Goal, Result is 1.
check(_, Result) :- Result is 0.