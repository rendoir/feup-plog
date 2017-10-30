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

stepNumber(Input, Output, next) :- Output is Input + 1.
stepNumber(Input, Output, before) :- Output is Input - 1.

nextStep(I,F,N) :-
   I < F,
   N is I + 1.
nextStep(I,F,N) :-
   I > F,
   N is I - 1.

not(Goal) :- Goal, !, fail.
not(_).

check(Goal, Result) :- Goal, Result is 1.
check(_, Result) :- Result is 0.