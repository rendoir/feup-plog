/**
  utilities.pl

  This file is responsible for all the tools a normal board game program would need.
**/


/**
  getListElement/3: Gets the List Element at Index.
    Index, List, Element.
**/
getListElement(0, [HeadElement | _], HeadElement).
getListElement(Index, [_ | RemainingElements], Element):-
  Index > 0,
  NewIndex is Index - 1,
  getListElement(NewIndex, RemainingElements, Element).


/**
  setListElement/4: Sets the List Element at Index.
    Index, NewElement,	InList, OutList.
**/
setListElement(0, Element, [_ | Tail], [Element | Tail]).
setListElement(Index, Element, [Head | Tail], [Head | NewTail]):-
  Index > 0,
  NewIndex is Index - 1,
  setListElement(NewIndex, Element, Tail, NewTail).


/**
  getMatrixElement/4: Gets the Matrix Element at the pair "Row and Column".
    Row, Column, Matrix, Element.
**/
getMatrixElement(0, ElementColumn, [Row|_], Element):-
  getListElement(ElementColumn, Row, Element).
getMatrixElement(ElementRow, ElementColumn, [_|RemainingLists], Element):-
  ElementRow > 0,
  NextRow is ElementRow - 1,
  getMatrixElement(NextRow, ElementColumn, RemainingLists, Element).


/**
  getMatrixElement/5: Sets the Matrix Element at the pair "Row and Column".
    Row, Column, NewElement, InMatrix, OutMatrix.
**/
setMatrixElement(0, ElementColumn, NewElement, [OldRow|RemainingRows], [NewRow|RemainingRows]):-
  setListElement(ElementColumn, NewElement, OldRow, NewRow).
setMatrixElement(ElementRow, ElementColumn, NewElement, [Row|RemainingRows], [Row|ModifiedRemainingRows]):-
  ElementRow > 0,
  NextRow is ElementRow - 1,
  setMatrixElement(NextRow, ElementColumn, NewElement, RemainingRows, ModifiedRemainingRows).
