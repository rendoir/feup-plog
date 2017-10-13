getListElement(0, [HeadElement | _], HeadElement).
getListElement(Index, [_ | RemainingElements], Element):-
	NewIndex is Index - 1,
	getListElement(NewIndex, RemainingElements, Element).

setListElement(0, Element, [_ | Tail], [Element | Tail]).
setListElement(Index, Element, [Head | Tail], [Head | NewTail]):-
  	NewIndex is Index - 1,
  	setListElement(NewIndex, Element, Tail, NewTail).
