:- include('board.pl').
:- include('display.pl').

%doppelblock(6,[4,8,4,5,6,5],[9,7,2,10,3,1]).
doppelblock(Size, TopSums, LeftSums) :-
  checkArguments(Size, TopSums, LeftSums), !,
  getCardinality(Size, Cardinality), !,
  initBoard(Board, Size, TopSums, LeftSums, Cardinality),
  label(Board),
  drawBoard(Board, TopSums, LeftSums, Size).
doppelblock(_, _, _) :-
  printUsage, !.
