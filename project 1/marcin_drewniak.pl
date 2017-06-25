:- module(marcin_drewniak, [solve/2]).

:- op(200, fx, ~).
:- op(500, xfy, v).

variable(X) :- X\= _ v _, X\= ~_.
literal(X) :- variable(X).
literal(X) :- X= ~Y, variable(Y).

list_from_clause(X,[X]) :- variable(X).
list_from_clause(X,[Y]) :- literal(X), X= ~Y.
list_from_clause(X v Y, [X|T]) :- variable(X), !, list_from_clause(Y,T).
list_from_clause(X v Y, [Z|T]) :- literal(X), X= ~Z, list_from_clause(Y,T).

all_variables([], []) :- !.
all_variables([H|T], X) :- list_from_clause(H,X1), all_variables(T,X2), append(X2,X1,X).

delete_clause_true(P,P) :- !.
delete_clause_true(X v _, P) :- X=P,!.
delete_clause_true(_ v Y, P) :- delete_clause_true(Y,P).

delete_clause_false(~P,P) :- !.
delete_clause_false(X v _, P) :- X= ~Y, P= Y, !.
delete_clause_false(_ v Y, P) :- delete_clause_false(Y,P).

delete_contrary_variable_true(X v Y, P, R) :- X\= ~P, !, delete_contrary_variable_true(Y,P,U), ((var(U), R = X); (\+var(U), R = X v U)).
delete_contrary_variable_true(_ v Y, P, R) :- !,delete_contrary_variable_true(Y,P,R).
delete_contrary_variable_true(~P, P, _) :- !.
delete_contrary_variable_true(Z, _, Z).

delete_contrary_variable_false(X v Y, P, R) :- X\=P, !, delete_contrary_variable_false(Y,P,U), ((var(U), R = X) ; (\+var(U), R = X v U)).
delete_contrary_variable_false(_ v Y,P,R) :- !,delete_contrary_variable_false(Y,P,R).
delete_contrary_variable_false(P,P,_) :- !.
delete_contrary_variable_false(Z,_,Z).

delete_contrary_variables_true([],_,[]) :- !.
delete_contrary_variables_true([H|T],P,[W|R]) :- delete_contrary_variable_true(H,P,W), \+var(W), \+delete_clause_true(W,P),!, delete_contrary_variables_true(T,P,R).
delete_contrary_variables_true([H|T],P,X) :- delete_contrary_variable_true(H,P,W), \+var(W), delete_contrary_variables_true(T,P,X).

delete_contrary_variables_false([],_,[]) :- !.
delete_contrary_variables_false([H|T],P,[W|R]) :- delete_contrary_variable_false(H,P,W), \+var(W), \+delete_clause_false(W,P),!, delete_contrary_variables_false(T,P,R).
delete_contrary_variables_false([H|T],P,X) :- delete_contrary_variable_false(H,P,W), \+var(W), delete_contrary_variables_false(T,P,X).

sigma([], P, [], SigmaResult) :- !, SigmaResult=[(P,x)].
sigma(Clauses, P, ClausesResult, SigmaResult) :- SigmaResult=[(P,t)], delete_contrary_variables_true(Clauses,P,ClausesResult).
sigma(Clauses, P, ClausesResult, SigmaResult) :- SigmaResult=[(P,f)], delete_contrary_variables_false(Clauses,P,ClausesResult).

solve([],[]) :- !.
solve(Clauses,_) :- memberchk([],Clauses), !, fail.
solve(Clauses, Solution) :- all_variables(Clauses, X), sort(X, VarList), sort(Clauses,SortedClauses), solve(SortedClauses,VarList,Solution).
solve([],[],[]):- !.
solve(Clauses, [Var|List], Solution) :- sigma(Clauses,Var,ClausesNext,SolutionNext), solve(ClausesNext,List,Solution2), append(SolutionNext, Solution2, Solution). 



%baza indukcji dla jakiejs klauzuli pustej. potem jesli ~x (lub odpowiednio x) wystepuje w klauzuli to nie dolaczamy go do niby-ogona (Y). jesli wystepuje to dolaczamy. obsluguja to dwa predykaty.
%powyzszy predykat wywolywany z predykatu, ktory robi to wszystko dla calej listy. baza indukcji tego predykatu zawiera liste pusta klauzul.

%potrzebny bedzie predykat wbudowany sort usuwajacy powtorzenia zmiennych i sortujacy ofc
%jesli po delete_clauses lista zwracana pusta to wartosciowanie spelnia zbior
%moze jeszcze klauzula pusta
