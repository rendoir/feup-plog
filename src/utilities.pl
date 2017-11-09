:- use_module(library(random)).

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

findMatrixElement([Row|_], ElementToSearch) :-
	member(ElementToSearch, Row).
findMatrixElement([_|RemainingRows], ElementToSearch) :-
	findMatrixElement(RemainingRows, ElementToSearch).

stepNDirection(X, Y, StepX, StepY, _, _, 0) :-
  StepX = X,
  StepY = Y.
stepNDirection(X, Y, StepX, StepY, Step, Direction, Number) :-
	Number > 0,
  stepDirection(X, Y, TempStepX, TempStepY, Step, Direction),
  NextNumber is Number - 1,
  stepNDirection(TempStepX, TempStepY, StepX, StepY, Step, Direction, NextNumber).

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

getOppositeDirection(horizontal, OppositeDirection) :- OppositeDirection = vertical.
getOppositeDirection(vertical, OppositeDirection) :- OppositeDirection = horizontal.


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

abs(Number, Absolute) :-
  Number > 0,
  Absolute is Number.
abs(Number, Absolute) :-
  Absolute is Number * (-1).

readOption(Number, Minimum, Maximum) :-
	read(Number), get_char(_),
	integer(Number),
	Number >= Minimum,
	Number =< Maximum.

readCoordinates(X, Y) :-
	read(X),
	integer(X),
	read(Y),
	integer(Y),
	isInsideBoard(X, Y).

pressEnterToContinue:-
  write('Press [Enter] to continue.'), nl,
  get_char(_).
		