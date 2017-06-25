:- module(marcin_drewniak_tests, [tests/5]).

:- op(200, fx, ~).
:- op(500, xfy, v).

tests(empty, validity, [], 500, count(1)).
tests(one_single_clause, validity, [a], 500, solution([(a,t)])).
tests(excluded_middle, validity, [p v ~p], 500, solution([(p,t)])).
tests(simple, validity, [p v r], 500, solution([(p,t),(r,f)])).
tests(two_middles, validity, [p v ~p, r v ~r], 500, solution([(p,t),(r,t)])).
tests(modus_ponens, validity, [~p v r, p], 500, solution([(p,t),(r,t)])).
tests(failure, validity, [~p v r, p v r, ~r], 500, count(0)).
tests(simplification, validity, [~p v ~r v p], 500, count(4)).
tests(resolution, validity, [a v b, ~a v c], 500, solution([(a,t),(b,f),(c,t)])).
tests(modus_tollens, validity, [~p v r, r v ~p], 500, count(3)).
tests(many_short_clauses, validity, [p v r, z, z v u, u v ~p, z v ~r], 500, solution([(p,t),(z,t),(u,t),(r,f)])).
tests(two_big_clauses, validity, [p v r v u v z, z v ~r v ~z v u], 500, solution([(p,f),(r,f),(u,t),(z,f)])).
tests(single_clauses, validity, [a, b, c, d, e], 500, count(1)).
tests(negated_single, validity, [~a, ~b, ~c, ~d, ~e], 500, solution([(a,f),(b,f),(c,f),(d,f),(e,f)])).
tests(steps, validity, [a v b, b v c, c v d], 500, count(8)).
tests(socrates_mystery, validity, [~a v b, ~c v a], 500, solution([(a,f),(b,f),(c,f)])).
tests(one_possible, validity, [a v ~b, b v ~c, c], 500, solution([(a,t),(b,t),(c,t)])).
tests(big_example, validity, [p v z v r, ~r v ~z v ~p, ~z v r, ~r v p], 500, solution([(p,t),(z,f),(r,t)])).
tests(tauthology, validity, [p v ~p v ~r, ~r v r], 500, count(4)).
tests(peirce, validity, [~p v r, ~p v p], 500, solution([(p,f), (r,f)])).
tests(hipothetical_syllogism, validity, [~p v z, z, ~r v ~p v r], 500, solution([(z,t),(r,f),(p,f)])).
tests(huge, validity, [a v ~b v c v ~d v e, c v ~b, a v c, d v e v b, e v c v d v a], 500, solution([(a,t),(b,f),(c,f),(d,f),(e,t)])).
tests(possitive, validity, [a v b, b v c v d, d v a, e, e v a], 500, solution([(a,f),(b,t),(c,f),(d,t),(e,t)])).
tests(negative, validity, [~a v ~b, ~b v ~d v ~e, ~d, ~a v ~c, ~b v ~d], 500, solution([(a,f),(b,t),(d,f),(c,t),(e,t)])).
tests(separable, validity, [a v b, c v ~d, e v g], 500, count(27)).
tests(empty_member, validity, [a v b v c, ~d v ~e, e v f, [], c],500,count(0)).





tests(per_small, performance, [~c, ~c v ~b v ~a v ~a, ~b v a v b v c, a v c v c v c, b], 500, solution([(a, t) ,(b, t) ,(c, f)])).
tests(per_biggest, performance, [~j v ~e v ~a v ~g, ~j v g v a v ~g v ~e v j v d v ~g v h v i, ~i v z v ~b v g v ~i, ~i v g v c v ~c v z v g v ~j v e, ~i v h v ~i v ~g v z v b v c v a v ~j v b, ~i v j v z v d v z v a v ~e v ~c v ~e v h, ~h v ~h v j v ~e v ~d v i v ~j v ~b v e, ~h v a v i v ~g v h v h v ~i v c v h v a, ~z v ~j v ~g v ~z v d v g, ~z v ~c v c v ~j v i v ~e v b v z, ~z v ~a v c v c v ~h v g v ~b v ~h, ~e v i v ~z v g v ~d v ~j, ~d v ~b v h v ~d v ~h v ~j v ~e v ~z v c, ~d v c v e v d v a v a v e, ~d v d v ~b v ~z v ~c v ~j v z v d v ~c v b, ~c v ~z v z v ~h, ~c v ~d v ~h v b v j v j v ~e v g v d v ~h, ~b v ~a v g v ~h v ~g v i v z, ~b v a v ~d, ~b v d v ~j v g v ~h v ~a v ~c, ~a v ~j v ~d v e v j v g v c, ~a v ~j v ~b v b v e v ~h v z v ~g v ~z, ~a v e v c, ~a v i v ~i v z v e v ~z v c v ~g, a v ~g v h v c v e v ~j v ~i, a v z v ~j v ~d v ~i v ~h v ~g v h, b v a v ~e v ~e v g v ~j v ~c v ~i v ~d, b v d v ~i v e v ~a v j, b v j v ~i, c v ~g v c v ~i v e v b v j, d v ~z v a v e, d v c v e v z v e v ~c v d v g, d v h v ~d v ~a v j v ~c v c v c v e v ~j, d v h v ~b v ~b v b v h v ~b v ~i v ~e v j, d v h v b v e v g v c v ~i v ~d v ~i v a, e v ~g v i v ~i v ~h, e v ~e v ~d v j v ~h v ~h v ~a v d v ~d v e, e v ~a v g v ~a v c v ~i v e v j, e v j v b, g v ~d v ~b v z v g v ~h, g v ~a v a v ~j v ~d v e v g v ~i v c v ~b, g v b v z v a v ~h, g v e v i v a v ~z v ~b v ~d v h v c v ~j, h v ~j v ~a, h v ~c v ~j v ~h v c v b v ~e, h v e v a v ~a v e v b v ~c v ~b v ~h, h v j v ~d v ~g v ~h v c v j, i v c v d v ~b, i v e v ~e v ~j v a v ~c v ~i v ~h v ~d v ~g, i v j v c v ~b v ~b v a v ~b], 6000, count(309)).

tests(per_big, performance, [~j v g v j v ~d v j, ~i v ~d v z v a v d v g v i v z, ~i v ~c v ~c v ~e v ~c v d v z v ~a, ~i v ~a v ~h v d, ~i v b v ~g, ~i v h v b v e v ~z v ~a v a v b v ~e v ~g, ~h v ~b v d v c v h v ~i v ~a, ~h v z v d v e v ~b, ~h v h v ~d v d v ~z v ~d v ~g v h v ~j v ~b, ~g v e v g v ~e v ~d, ~g v h v ~e v b v c v c v h v ~g v i, ~g v j v d v b, ~z v d v ~b v i v d v ~a v ~h v ~h, ~z v j v h v ~j v ~e v g v ~a v z v ~c v ~j, ~e v ~e v ~z v ~d v ~e v ~z v ~d v ~j v ~i, ~e v ~d v b, ~e v e v ~a v g v ~e v ~h v ~e v ~e v ~e v z, ~e v i v ~a, ~d v ~i v e v ~z v c v ~j v ~c v ~c, ~d v ~g v z v ~z, ~d v ~a v ~h v b v e v ~a v ~z v ~d v ~h, ~c v ~d v ~h v ~a v ~e v ~b v ~j v ~a, ~c v ~b v c v ~c v z v ~h v z v c v ~j v ~g, ~b v ~e v i v ~d v ~d v ~d, ~a v ~e v a v ~i v i v ~g v ~e, ~a v ~a v b v ~h v g v b v a v ~z, a v ~d v e v a v ~h v ~c, a v ~a v c v ~c v i v ~i v c, a v e v ~h v ~e v a v ~e v ~g v h v i v h, b v ~j v ~c v h v d v d v z v ~j v ~h, b v ~b v h v z v j v ~h v j v a, b v a v d v d v e v h v ~i v ~j, c v ~g v a v ~g, d v ~d v ~d v ~g v ~b v ~g v h v ~c v j, d v b v b v ~d v h v ~a v ~e v j, e v d v ~h v ~i v ~i, e v e v i, e v h v ~i v a v ~e, z v ~g v a v d, z v e v a v ~c v ~c v d, g v ~g v i v ~a v ~c v d, g v c v ~z v ~j v d v a v b v d v ~c v ~e, g v z v ~c v z v h v z v ~z v e, g v z v b v h v ~b v ~g v c, h v z v z v h v h v ~c v ~i v ~j v ~i v b, i v ~d v j v ~h v j v j v a v d, i v ~c v i v i, i v b v b v c, i v c v c v ~e v ~i v ~c v ~z v z v i, j v a v ~a v ~d v ~d v ~b v ~j v z v a], 5000, count(205)).

tests(per_solution, performance, [~n v ~j, ~n v ~h v z, ~n v o, ~m v l v z, ~l v g, ~k v k, ~j v z, ~h v m, ~g v ~k, ~z v h, ~e v ~z v ~z, ~d v b, ~c v b v a, ~c v z, ~b v ~g, d v ~c v l, d v z v ~a, e v ~d, z v ~j, z v e, g v ~e, g v ~b, g v ~a, g v h v z, k v ~m v k, m v m, n v ~m v m, n v ~z, o v ~o v ~n, o v l], 3000, solution([(a, f) ,(b, f) ,(c, f) ,(d, f) ,(e, f) ,(z, t) ,(g, f) ,(h, t) ,(j, f) ,(k, t) ,(l, f) ,(m, t) ,(n, t) ,(o, t)])).

tests(per_fail, performance, [~o v n v l, ~n v l, ~m v ~h v ~n, ~m v h, ~k v ~z v l, ~i v l, ~h v ~a, ~g v ~l, ~e v ~m, ~d v a v a, ~c v b v ~l, ~c v e, b v k v ~d, c v ~k, c v b v e, c v z, d v ~n, z v ~k, z v z v a, g v ~o, g v a v ~d, h v ~k v c, h v o, i v ~m v ~h, i v ~j, k v z v ~j, l v d v ~o, m v ~g, m v ~d v l, o v o], 2000, count(0)).

tests(per_biggest_count, performance, [~o v ~j v k, ~o v k, ~m v ~a, ~k v o v j, ~j v m v n, ~i v z, ~g v ~j v ~a, ~g v m v j, ~z v z, ~e v ~i, ~e v ~e v ~i, ~d v ~k v ~i, ~d v ~c v d, ~d v o v ~g, ~b v z, ~b v k, ~a v h, b v ~b, b v ~a v ~l, b v m v ~h, c v i v ~j, d v m v ~c, e v ~z v d, e v ~z v e, g v o v ~g, j v ~g, m v ~z, m v b v ~l, m v h v c, n v ~d v l], 3000, count(474)).

tests(per_lots_of_small, performance, [~o v b, ~n v a v j, ~n v m, ~l v ~a v ~h, ~k v ~d, ~k v ~a v ~c, ~j v k v l, ~i v ~j, ~h v ~d, ~h v j v l, ~h v k v ~n, ~g v j v ~m, ~z v b v ~g, ~e v c v ~a, ~e v h v ~m, ~d v ~j, ~c v ~i v ~g, ~a v ~i, c v ~j, c v k v o, z v j v ~l, h v k v b, i v ~i, i v h v ~l, k v j, l v a, n v ~n, n v m v ~i, o v ~h, o v a], 2000, count(81)).

tests(per_many_variables, performance, [a v b v ~c, c v ~d v ~e, b v a v ~g v h, z v b v a, o v a, a v u v y v ~z, x v c v g v ~t, ~y v ~u v ~e v ~q, m v n v b v ~x v ~o, g v q v e, y v ~u v ~r, p, ~p], 10000, count(0)).

tests(check_for_shortest, performance, [q v w v e v r v y v u v i v o v p v a v s v d v g v h v j v k v l v z v c v n v m, b, ~b], 10000, count(0)).

tests(tricky_but_less_variables, performance, [p0 v p1 v p2 v p3 v p4 v p5 v p6 v p7 v p8 v p9 v p10 v p11 v p12 v p13 v p14 v p15 v p16 v p17 v p18 v p19 v p20 v p21 v p22 v p23, ~p0 v p19, p0], 10000, count(4194304)).
