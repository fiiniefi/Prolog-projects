:- module(marcin_drewniak_tests, [tests/3]).



tests(correct_tree_empty, input(""), program([])).
tests(correct_tree_def_only, input("def aA_1((a,b),(c,d)) = 123"), program([def( pair(no, pair(no, var(no, 'a'), var(no, 'b')), pair(no, var(no, 'c'), var(no, 'd'))),
							     num(no, 123))])).

tests(correct_number_test, input("def c(b) = if c<5
then c=5
else c=3"), program([def(c, var(file('test2.hdml', 1, 7, 7), 'b'),
				if(file('test2.hdml', 1, 12, 12), op(file('test2.hdml', 1, 15, 15), '<', var(file('test2.hdml', 1, 15, 15), 'c'), num(file('test2.hdml', 1, 17, 17), 5)),
								  op(file('test2.hdml', 2, 6, 24), '=', var(file('test2.hdml', 2, 6, 24), 'c'), num(file('test2.hdml', 2, 8, 26), 5)),
								  op(file('test2.hdml', 3, 6, 31), '=', var(file('test2.hdml', 3, 6, 31), 'c'), num(file('test2.hdml', 3, 8, 32), 3))))])).

tests(correct_number_test_with_length, input("def fun(a,b) = a%2"), program([def(fun, pair(file('test3.hdml', 1, 9, 9, 3), var(file('test3.hdml', 1, 9, 9, 1), 'a'), var(file('test3.hdml', 1, 11, 11, 1), 'b')),
									op(file('test3.hdml', 1, 16, 16, 3), '%', var(file('test3.hdml', 1, 16, 16, 1), 'a'), num(file('test3.hdml', 1, 18, 18, 1), 2)))])).

tests(correct_single, input("def asd(a,b,c) = if a<=b then a=b else c=b"), yes).
tests(correct_small, input("def fun1(_) = let _,_ = if fun1<fun2 then fun1<fun2 else fun1>=fun2 in if fun1>fun2 then fun1>fun2 else fun1<=fun2"), yes).
tests(correct_few_small_definitions, file('test8.hdml'), yes).
tests(correct_one_big_definition, file('test9.hdml'), yes).
tests(correct_quite_big, input("def fun1(a,b) = 
    if let a=b in [] 
    then a=b 
    else -fun(a) @ ( if a <= b then a <=b else a<=b)

def fun2(_) = 
    let (((a))) = 
    let (b) =
    let c = 4 in 5
    #b[ 6[if b=a then b=a else a=b .. 5]] 
    in if c^4 then 1 else 0  (* let(b) = *)
    ulubiona_liczba_wszystkich_matematykow = ( takiegoprzypisanianiktsieniespodziewal )
    in fun2(5) (* let(((a))) = *)"), yes).
tests(correct_huge, file('test4.hdml'), yes).





%wiekszosc niepoprawnych programow to pojedyncze niepoprawne wyprowadzenia

tests(incorrect_initialization, input("a=5"), no).
tests(incorrect_if_only, input("if a>=5 then a=5 else let b = a-5 in b-4"), no).
tests(incorrect_opbool_fail, input("def cos(a) = a<>5=4"), no).
tests(incorrect_c, file('universal-p.hdml'), no).
tests(incorrect_unary_and_bit, input("-a[a+b-c*d/3*a]"), no).
tests(incorrect_definition, file('test5.hdml'), no).
tests(incorrect_one_mistake, file('test6.hdml'), no).
tests(incorrect_comment, input("def a(b) = a+b (*debugger i tak by*) nie przepuscil*)"), no).
tests(incorrect_keyword_id, input("def then(if) = a"), no).
tests(incorrect_hdml_doesnt_speak_english, file('test10.hdml'), no).
tests(incorrect_one_big_fail, file('test7.hdml'), no).
