:- module(marcin_drewniak, [resolve/4, prove/2]).
:- op(200, fx, ~).
:- op(500, xfy, v).


%set_prolog_flag(answer_write_options, [quoted(true), portray(true), spacing(next_argument)]).


variable(X) :- X\= _ v _, X\= ~_.
literal(X) :- variable(X), !.
literal(X) :- X= ~Y, variable(Y).

list_from_clause(X v Y, [X|T]) :- !, literal(X), list_from_clause(Y,T).
list_from_clause(X,[X]).

list_from_clause_no_repetitions(X, Y) :- list_from_clause(X, Z), sort(Z, Y).

clause_from_list([],[]) :- !.
clause_from_list([X], X) :- !.
clause_from_list([H|T], H v X) :- clause_from_list(T,X).

remove_duplicates(X, Y) :- list_from_clause_no_repetitions(X,Z), clause_from_list(Z,Y).

merge([],[],[]) :- !.
merge(Clause1, [], Clause1) :- !.
merge([], Clause2, Clause2) :- !.
merge(Clause1, Clause2, Resolvent) :- merge_two(Clause1, Clause2, Resolvent).

merge_two(X v Y, Clause2, Result) :- !, Result=X v Result2, merge_two(Y, Clause2, Result2). 
merge_two(X, Clause2, X v Clause2).

half(Var, Var v Y v Z, Acc) :- !, half(Var, Y v Z, Acc).
half(Var, X v Y v Z, Acc) :- !, Acc=X v Acc2, half(Var, Y v Z, Acc2).
half(Var, Var v Y, Y) :- !.
half(Var, X v Var, X) :- !.
half(_, X v Y, X v Y) :- !.
half(Var, Var, []) :- !.     %to nie baza indukcji, tylko obsluga sytuacji, kiedy dostane singleton
half(_, X, X).     %to nie baza indukcji, tylko obsluga sytuacji, kiedy dostane singleton


resolve(Var, Clause1, Clause2, Resolvent) :- remove_duplicates(Clause1, Clause1Res), half(Var, Clause1Res, Acc2), remove_duplicates(Clause2, Clause2Res), half(~Var, Clause2Res, Acc3), 
					     merge(Acc2, Acc3, ResolventAcc), remove_duplicates(ResolventAcc, Resolvent).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

remove_duplicates_from_list([H], [H2]) :- !, remove_duplicates(H, H2).
remove_duplicates_from_list([H|T], [H2|T2]) :- remove_duplicates(H,H2), remove_duplicates_from_list(T,T2).

list_from_clause_var(X,[X]) :- variable(X).
list_from_clause_var(X,[Y]) :- literal(X), X= ~Y.
list_from_clause_var(X v Y, [X|T]) :- variable(X), !, list_from_clause_var(Y,T).
list_from_clause_var(X v Y, [Z|T]) :- literal(X), X= ~Z, list_from_clause_var(Y,T).

list_from_clauses([H], H2) :- !, list_from_clause_var(H,H2).
list_from_clauses([H|T], X) :- list_from_clause_var(H, H2), append(H2, X2, X), list_from_clauses(T,X2).

list_from_clauses_no_repetitions(X,Y) :- list_from_clauses(X,Z), sort(Z,Y).

add_axioms([H], [node(leaf, H, leaf)]) :- !.
add_axioms([H|T], [node(leaf, H, leaf)|T2]) :- add_axioms(T,T2).

memb(Var, Var) :- !.
memb(Var, Var v _) :- !.
memb(Var, _ v Y) :- memb(Var, Y). 

leng([],_,0).
leng(_ v Y, Acc, R) :- !, Acc2 is Acc+1, leng(Y, Acc2, R).
leng(_, Acc, Acc).


resolve_two_clauses_step([X], node(_,C1,_), node(_,C2,_), _) :- memb(X, C1), memb( ~X , C2), !.
resolve_two_clauses_step([X], node(_,C1,_), node(_,C2,_), _) :- !, memb(X, C2), memb( ~X , C1).

resolve_two_clauses_step([Var|_], node(_, C1, _), node(_, C2, _), _) :- memb(Var,C1), memb( ~Var , C2),!.
resolve_two_clauses_step([Var|_], node(_, C1, _), node(_, C2, _), _) :- memb(Var,C2), memb( ~Var ,C1), !.
resolve_two_clauses_step([_|T], node(X1, C1, Y1), node(X2, C2, Y2), _) :- resolve_two_clauses_step(T, node(X1,C1,Y1), node(X2,C2,Y2),_).


resolve_two_clauses([X], node(X1,C1,Y1), node(X2,C2,Y2), node(node(X1,C1,Y1), R, node(X2,C2,Y2))) :- C1\=C2, memb(X, C1), memb( ~X , C2), !, resolve(X, C1, C2, R), R\=C1, R\=C2.
resolve_two_clauses([X], node(X1,C1,Y1), node(X2,C2,Y2), node(node(X2,C2,Y2), R, node(X1,C1,Y1))) :- !, C1\=C2, memb(X, C2), memb( ~X , C1), resolve(X, C2, C1, R), R\=C1, R\=C2.

resolve_two_clauses([Var|T], node(X1, C1, Y1), node(X2, C2, Y2), node(node(X1,C1,Y1), R, node(X2,C2,Y2))) :- C1\=C2, memb(Var,C1), memb( ~Var , C2), !, 
												\+resolve_two_clauses_step(T, node(X1, C1, Y1), node(X2, C2, Y2), _), resolve(Var, C1, C2, R), R\=C1, R\=C2.

resolve_two_clauses([Var|T], node(X1, C1, Y1), node(X2, C2, Y2), node(node(X2,C2,Y2), R, node(X1,C1,Y1))) :- C1\=C2, memb(Var,C2), memb( ~Var ,C1), !, 
											     \+resolve_two_clauses_step(T, node(X1, C1, Y1), node(X2, C2, Y2), _), resolve(Var, C2, C1, R), R\=C1, R\=C2.

resolve_two_clauses([_|T], node(X1, C1, Y1), node(X2, C2, Y2), X) :- C1\=C2, resolve_two_clauses(T, node(X1,C1,Y1), node(X2,C2,Y2),X).


resolve_all_clauses(_, [], [], []) :- !.
resolve_all_clauses(VarList, [_|T1], [], X) :- !, resolve_all_clauses(VarList, T1, T1, X).
resolve_all_clauses(VarList, [H1|T1], [H2|T2], [R|RT]) :- resolve_two_clauses(VarList, H1, H2, R2), !, R2=node(X,C,Y), list_from_clause_var(C, List), \+tauthology_test(List,C), remove_duplicates(C, CR), 
							  R=node(X,CR,Y), resolve_all_clauses(VarList, [H1|T1], T2, RT).
resolve_all_clauses(VarList, [H1|T1], [_|T2], X) :- resolve_all_clauses(VarList, [H1|T1], T2, X).


resolution(VarList, Trees, NewTrees) :- resolve_all_clauses(VarList, Trees, Trees, NT), append(Trees, NT, NT2), ((member(node(_,[],_), NT), NewTrees=NT2) ; (remove_repetitions_trees(NT2, NTR2), delete_subsumptions(NTR2, NTR2, NTS2), remove_tauthology_trees(NTS2, NTT2), sort(NTT2, NTT2Sorted), sort(Trees,TreesSorted), NTT2Sorted\=TreesSorted, resolution(VarList, NTT2, NewTrees))).

%resolution(VarList, Trees, NT2) :- resolve_all_clauses(VarList, Trees, Trees, NT), append(Trees, NT, NT2), member(node(_,[],_), NT), !.

%resolution(VarList, Trees, NewTrees) :- resolve_all_clauses(VarList, Trees, Trees, NT), NT\=[], append(Trees, NT, NT2), remove_repetitions_trees(NT2, NTR2), delete_subsumptions(NTR2, NTR2, NTS2), %remove_tauthology_trees(NTS2, NTT2), sort(NTT2, NTT2Sorted), sort(Trees,TreesSorted), NTT2Sorted\=TreesSorted, resolution(VarList, NTT2, NewTrees).



subsumption(X,X) :- !.
subsumption(X v Y, Z) :- !, memb(X,Z), subsumption(Y,Z).
subsumption(X,Z) :- memb(X,Z).


exists_smaller(A,[H|_]) :- H=node(_,CL,_), subsumption(CL,A), leng(CL,0,CLL), leng(A,0,AL), CLL < AL.
exists_smaller(A,[_|T]) :- exists_smaller(A,T).

delete_subsumptions([],_,[]) :- !.
delete_subsumptions([H|T],CL,[H|T1]) :- H=node(_,CLA,_), \+exists_smaller(CLA,CL), !, delete_subsumptions(T,CL,T1).
delete_subsumptions([_|T],CL,T1) :- delete_subsumptions(T,CL,T1).


remove_repetitions_trees([TreeH|TreeT], TreeResult) :- flat_tree([TreeH|TreeT], List), sort(List, SList), create_new_trees(SList, [TreeH|TreeT], [TreeH|TreeT], TreeResult).

create_new_trees([],_,_,[]) :- !.
create_new_trees([H|T], Full, [TreeH|_], [TreeH|Result]) :- TreeH=node(_,H,_), create_new_trees(T, Full, Full, Result).
create_new_trees([H|T], Full, [_|TreeT], Result) :- create_new_trees([H|T], Full,  TreeT, Result).

flat_tree([],[]) :- !.
flat_tree([H|T], [L|LT]) :- H=node(_,L,_), flat_tree(T, LT).





generate_proof(node(leaf, C, leaf), [(C,axiom)]) :- !.
generate_proof(node(X, C, Y), [H|T]) :- X=node(_, C1, _), Y=node(_, C2, _), H=(C, C1, C2), generate_proof(X, T1), generate_proof(Y, T2), append(T1,T2,T).


where([C|_], F, Acc, Acc) :- C=(F,axiom),!.
where([C|_], F, Acc, Acc) :- C=(F,_,_),!.
where([_|T], C, Acc, Res) :- Acc2 is Acc+1, where(T, C, Acc2, Res).


generate_numeric_proof(_, _, [H], [H]) :- H=(_,axiom), !.
generate_numeric_proof(VarList, All, [H], [HR]) :- !, H=(C,C1,C2), where(All, C1, 1, R1), where(All, C2, 1, R2), select(Var, VarList, _), memb(Var, C1), memb(~Var, C2), 
						   HR=(C,(Var,R1,R2)).
generate_numeric_proof(VarList, All, [H|T], [H|Proof]) :- H=(_,axiom), !, generate_numeric_proof(VarList, All, T, Proof).
generate_numeric_proof(VarList, All, [H|T], [HR|Proof]) :- H=(C,C1,C2), where(All, C1, 1, R1), where(All, C2, 1, R2), select(Var, VarList, _), memb(Var, C1), memb(~Var, C2), 
							   HR=(C,(Var,R1,R2)), generate_numeric_proof(VarList, All, T, Proof).

empty_inside(node(_,Val,_)) :- Val=[], !.
empty_inside(node(X,_,Y)) :- empty_inside(X), empty_inside(Y).


find_empty([H|_], H) :- empty_inside(H), !.
find_empty([_|T], X) :- find_empty(T,X).


give_proof(VarList, Trees, Proof) :- find_empty(Trees, Tree), generate_proof(Tree, Prototype), reverse(Prototype, RP), generate_numeric_proof(VarList, RP, RP, Proof).


trees_axioms([H], [node(leaf,H,leaf)]) :- !.
trees_axioms([H|T], [node(leaf,H,leaf)|T1]) :- trees_axioms(T,T1).


tauthology_test([H|_], X) :- memb(H, X), memb(~H, X),!.
tauthology_test([_|T],X) :- tauthology_test(T,X).
 


remove_tauthology([],[]) :- !.
remove_tauthology([H|T], [H|T1]) :- list_from_clause_var(H, List), \+tauthology_test(List, H), !, remove_tauthology(T,T1).
remove_tauthology([_|T], T1) :- remove_tauthology(T,T1).


remove_tauthology_trees([],[]) :-!.
remove_tauthology_trees([H|T],[H|T1]) :- H=node(_,C,_), list_from_clause_var(C,List), \+tauthology_test(List,C), !, remove_tauthology_trees(T,T1).
remove_tauthology_trees([_|T],T1) :- remove_tauthology_trees(T,T1).


prove([], _) :- !, fail.
prove(Clauses,[([],axiom)]) :- memberchk([], Clauses), !.
prove([_], _) :- !, fail.
prove(Clauses, Proof) :- sort(Clauses, ClausesSorted), remove_tauthology(ClausesSorted, ClausesTauth), remove_duplicates_from_list(ClausesTauth, ClausesRemoved), sort(ClausesRemoved, ClausesR),
			 list_from_clauses_no_repetitions(ClausesR, ListOfVariables), trees_axioms(ClausesR, Tree), 
			 resolution(ListOfVariables, Tree, AllTrees), give_proof(ListOfVariables, AllTrees, Proof),!.
