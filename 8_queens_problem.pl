% render solutions nicely.
:- use_rendering(chess).

%%    queens(+N, -Queens) is nondet.
%
%	@param	Queens is a list of column numbers for placing the queens.
%	@author Richard A. O'Keefe (The Craft of Prolog)

queens(N, Queens) :-
    length(Queens, N),
	board(Queens, Board, 0, N, _, _),
	queens(Board, 0, Queens).

%This is the main predicate, queens/2, which takes as input the number of queens N and outputs a solution Queens. It initializes the solution list with the appropriate length, sets up the chessboard using the board/6 predicate, and then calls the helper predicate queens/3 to find a solution.

board([], [], N, N, _, _).

%This rule states that if the list of queens is empty, the corresponding list of variables and the board are also empty.

board([_|Queens], [Col-Vars|Board], Col0, N, [_|VR], VC) :-
	Col is Col0+1,
	functor(Vars, f, N),
	constraints(N, Vars, VR, VC),
	board(Queens, Board, Col, N, VR, [_|VC]).

%This rule is responsible for generating the board. It recursively processes each queen, assigning it a column (Col) and creating a set of variables (Vars) representing the constraints on that queen. The constraints/4 predicate sets up the constraints, and the recursion continues for the rest of the queens.

constraints(0, _, _, _) :- !.
constraints(N, Row, [R|Rs], [C|Cs]) :-
	arg(N, Row, R-C),
	M is N-1,
	constraints(M, Row, Rs, Cs).

%The constraints/4 predicate sets up the constraints for a queen. It recursively processes each row, assigning a constraint to the queen. The constraint is represented as Row-Column, where Row is the row number and Column is the column number.

queens([], _, []).

%This rule states that if the list of remaining columns is empty, the solution is also empty.

queens([C|Cs], Row0, [Col|Solution]) :-
	Row is Row0+1,
	select(Col-Vars, [C|Cs], Board),
	arg(Row, Vars, Row-Row),
	queens(Board, Row, Solution).

%This rule is the heart of the solution. It recursively processes each column (C) and selects a queen (Col-Vars) from the list of columns. It then assigns the row constraint to the corresponding variable and continues the recursion with the remaining columns (Board). The final result is the solution list.


/** <examples>

?- queens(8, Queens).

*/
