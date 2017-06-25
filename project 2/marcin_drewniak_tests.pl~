:- module(marcin_drewniak_tests, [resolve_tests/5, prove_tests/4]).

:- op(200, fx, ~).
:- op(500, xfy, v).





resolve_tests(resolve_single_result, p, p v q, ~p, q).
resolve_tests(resolve_simple, p, p v q, ~p v r, q v r).
resolve_tests(resolve_empty, p, p, ~p, []).
resolve_tests(resolve_small, p, p v r v s, ~p v t, r v s v t).
resolve_tests(resolve_big_and_single, n, p v r v ~t v u v ~d v ~k v l v n v o v e, ~n, p v r v ~t v u v ~d v ~k v l v o v e).
resolve_tests(resolve_big_and_small, k, k v l v o, r v t v ~u v i v ~k v ~p v ~a v d v f v g v ~h, l v o v r v t v ~u v i v ~p v ~a v d v f v g v ~h).
resolve_tests(resolve_big, o, ~w v e v ~r v ~t v u v i v o v ~p v a v d v ~f v ~g, h v j v k v ~l v z v c v ~x v ~b v ~n v ~o, ~w v e v ~r v ~t v u v i v ~p v a v d v ~f v ~g v h v j v k v ~l v z v c v ~x v ~b v ~n).
resolve_tests(resolve_second_is_almost_first, k, l v k v ~u v ~o, l v ~k v ~u v ~o, l v ~u v ~o).
resolve_tests(resolve_small_mixed, w, ~e v r v w, ~t v r v ~u v ~w, ~e v r v ~t v ~u).
resolve_tests(resolve_big_mixed, e, ~w v e v r v ~t v ~u v ~i v ~o v p v a v d v ~f v g v ~h v j, r v ~w v l v ~u v k v n v b v ~i v ~e v ~f v a v c, ~w v r v ~t v ~u v ~i v ~o v p v a v d v ~f v g v ~h v j v l v k v n v b v c).
resolve_tests(resolve_big_and_small_mixed, u, w v ~r v t v u v ~i v o v a v ~d v f v g v h v ~j v ~k v ~l v ~z, ~u v ~r v t, w v ~r v t v ~i v o v a v ~d v f v g v h v ~j v ~k v ~l v ~z).
resolve_tests(resolve_all_contrary, u, w v ~r v u, ~w v r v ~u, w v ~r v ~w v r).




prove_tests(prove_val_empty, validity, [], sat).
prove_tests(prove_val_empty_clause, validity, [[]], unsat).
prove_tests(prove_val_empty_clause_inside, validity, [a v b, b v ~c, [], d v e v a], unsat).
prove_tests(prove_val_singleton, validity, [a], sat).
prove_tests(prove_val_excluded_middle, validity, [p v ~p], sat).
prove_tests(prove_val_modus_ponens, validity, [~p v r, p], sat).
prove_tests(prove_val_simplification, validity, [~p v ~r v p], sat).
prove_tests(prove_val_simple, validity, [r v p, s v ~p], sat).
prove_tests(prove_val_negative_literals, validity, [~a v ~b, ~b v ~d v ~e, ~d, ~a v ~c, ~b v ~d], sat).
prove_tests(prove_val_positive_literals, validity, [a v b, b v c v d, d v a, e, e v a], sat).
prove_tests(prove_val_tauthology, validity, [p v ~p v ~r, ~r v r], sat).
prove_tests(prove_val_big, validity, [~a v c v ~b v c, a v ~a, a v b v ~a v ~b, a v b v ~a v c, c v a v ~a v ~a], sat).
prove_tests(prove_val_big2, validity, [~c v ~a v a v a, ~b v ~a v b v a, b v a v ~b, m v n v s, t v q v e v r v p], sat).
prove_tests(prove_val_huge, validity, [~o v ~l, ~o v h v ~k, ~n v ~c v a, ~m v ~e v f, ~j v o v ~j, ~i v ~g, ~i v m, ~f v ~o, ~f v b, ~d v d v c, ~b v ~l v ~d, ~b v ~b v b, a v k, a v m v l, c v g, c v o, d v ~c v b, d v e v ~j, d v m v ~d, e v e, f v b v ~j, g v ~n, h v ~l v m, h v ~i v ~o, i v ~b, k v ~f v e, l v ~g v ~f, l v a, m v ~k v c, m v l v ~g], sat).
prove_tests(prove_val_huge2, validity, [~n v ~d, ~n v c v ~j, ~l v ~l, ~k v ~b, ~j v ~d v ~h, ~j v f, ~i v ~f v ~g, ~h v ~o v n, ~h v ~h v ~n, ~h v ~g, ~g v ~k v a, ~g v ~i, ~g v e v ~a, ~g v e v l, ~e v b v k, ~b v ~f v ~c, ~a v c v k, b v ~l v ~m, d v a v ~o, d v e, e v ~h v i, e v d, e v d v ~b, e v o v ~i, g v ~a, j v o, k v ~n, k v j v b, n v ~a, n v ~a v i], sat).

prove_tests(prove_val_fail, validity, [~p v r, p v r, ~r], unsat).
prove_tests(prove_val_next_to_unsat, validity, [a v b, ~b v c, ~c v d, ~d v e, ~a, ~e], unsat).
prove_tests(prove_val_lot_of_repetitions_unsat, validity, [~c v ~c v b, ~c v a v a, ~a v ~a, ~a v b v ~a v ~b, c v c], unsat).
prove_tests(prove_val_big_unsat, validity, [~p v ~r, t v ~s, p, k v l, m v n, o v p, b, r v s, ~h v y, ~o v ~p, q v e, i v u, ~b v ~t, c v ~c, x v p, p, z v k, l v u], unsat).
prove_tests(prove_val_big2_unsat, validity, [~c v b v a v b, ~b v ~b, ~b v ~a v b v a, a v ~a v ~a v ~a, b, m v n, n v ~m, k v ~l, s v ~p, p v o, ~y v ~u v ~e v ~r, i v ~e v r], unsat).
prove_tests(prove_val_huge_unsat, validity, [~o v e, ~n v ~k, ~l v ~i v m, ~k v g, ~j v ~j, ~j v f v l, ~i v ~g, ~i v f v m, ~i v i, ~h v ~f, ~f v j, ~d v ~b, ~c v m, ~a v g, a v ~l, a v ~l v k, a v ~a v l, a v h, b v f, c v o v o, e v f, f v b v g, g v ~d, i v ~k v ~m, i v ~g v k, i v m v ~i, l v ~b, l v d v ~k, m v ~o, m v ~e], unsat).
prove_tests(prove_val_huge2_unsat, validity, [~o v ~n, ~o v ~l v f, ~n v ~d v j, ~m v h v ~m, ~l v ~e, ~l v h, ~k v o, ~j v m v o, ~h v ~a v m, ~g v ~h v ~i, ~f v ~e v ~n, ~e v b, ~e v k v ~a, ~d v c v ~k, ~b v ~b, a v ~c v a, a v j v ~m, a v l v e, b v o, d v l v ~b, f v ~g, f v ~e v ~i, g v c, g v n v ~o, h v i, j v b v e, m v h, n v ~j, o v ~m v o, o v n], unsat).
prove_tests(prove_val_huge3_unsat, validity, [~o v c, ~n v ~a v d, ~l v ~j, ~l v i, ~k v ~h v g, ~i v ~i, ~i v g, ~i v i v ~c, ~i v m v ~e, ~h v ~h v e, ~g v ~o v ~j, ~g v ~a, ~g v ~a v ~i, ~f v k v ~o, ~e v ~k v g, ~d v ~i v ~m, ~c v ~b, ~c v k v d, a v i, b v d, c v h v i, g v ~k v ~i, h v ~o v ~k, i v g v j, i v i v ~j, k v ~l v l, l v ~d v f, m v ~b v ~c, m v m, n v g v ~i], unsat).





prove_tests(prove_per_frequent, performance, [~o v h, ~n v ~a, ~k v o, ~j v j, ~j v k v e, ~i v a, ~i v n v ~n, ~g v ~m, ~g v ~k, ~d v ~j, ~d v d, ~c v h v ~j, ~b v ~c v ~j, ~b v ~b, ~b v c v ~f, c v ~i v ~a, c v i v h, e v c, f v ~f, f v ~e, f v h v ~c, f v i v d, f v l v k, g v ~b, h v o, i v ~l, i v a v ~f, j v ~n, k v o v l, l v ~i v ~m], sat).
%bo często jest spełniony


prove_tests(prove_per_rare, performance, [~r v ~g v i, ~r v p v n v ~f v ~m, ~q v p v r v ~f v c, ~p v d v ~l v ~i v p, ~o v ~i v p v ~m v ~a, ~o v ~e v ~g v p, ~o v ~d v ~p, ~o v f v n, ~o v k v ~k v r v b, ~n v ~f v ~e v ~d v k, ~n v r v ~k, ~n v r v ~a, ~m v ~o v d v i v o, ~m v a v ~n v j, ~m v h v ~q, ~m v k v ~r v i, ~m v p v ~l v ~e, ~l v f v ~d v c v c, ~l v n, ~k v ~j v ~o v j, ~k v k, ~k v p v ~m, ~k v p v d v ~n, ~j v ~g, ~j v c v a, ~i v ~g v h v ~a v ~g, ~i v l v ~d v i, ~i v q v ~q v r v ~o, ~h v ~i v ~m v d v ~l, ~h v ~c, ~h v ~b, ~h v a v ~d, ~g v d v e v b v q, ~g v p v g v ~k, ~f v ~m v ~f v d v ~b, ~e v q v o, ~d v ~m v j v h, ~d v ~b, ~d v i, ~d v r v h v o, ~c v ~r v o v k v ~n, ~c v g, ~c v j, ~c v l v g, ~b v ~r v a v ~p v ~c, ~b v a, ~b v d v b, ~a v ~r v ~g v ~b v g, ~a v o v g, a v ~h, a v ~b v ~r v ~n, a v n, a v o v ~r v ~b v ~c, b v ~k v ~i v ~h v l, b v ~b v d v ~k, b v o v i v ~j, b v p v n, c v ~a v ~k v m, d v ~o v ~e v ~e, d v ~f v o v l, d v ~a v l, d v e v ~r, d v f v l v f, f v ~l, f v n v ~o v ~l, f v p v h v o v ~d, g v ~g v ~f, g v ~d v d, g v ~a, h v ~m v ~m, i v ~p v ~o, i v ~h v ~p, i v g v ~m v ~a, i v h, i v k, i v o v ~l, j v ~j v ~f, j v ~e v ~g v j v ~h, j v ~d v i, k v ~f, k v ~d v h, k v h v ~m v f, k v m v i v p, k v p v ~o v g v ~n, l v ~b v b v ~c v b, l v q, m v ~r v l, m v ~b v ~o v ~o, m v l v g, m v n v g v i, m v o v o v n v f, n v c v ~n, n v c v ~j, n v k v ~p v ~c, n v r v ~k v ~a v ~g, o v ~p v ~r v ~n, p v ~n, q v ~q v j v r v ~f, q v m, r v g], sat).  
%bo rzadko jest spełniony 


prove_tests(prove_per_fail, performance, [~s v b, ~r v ~o v ~r, ~r v ~n v q, ~r v ~e, ~q v ~d, ~q v ~c v ~m, ~p v ~r v o, ~p v ~l, ~p v ~d v ~d v ~l, ~p v a v k v p, ~p v e v ~l v z v ~i, ~o v l v ~d v m, ~o v n v ~p, ~n v ~n v ~i v ~r, ~n v ~e v p v ~g, ~n v e v ~m, ~m v ~r v k, ~m v ~d v ~c v ~o v z, ~m v s, ~l v ~k v r, ~l v ~j v p v g, ~k v ~s v ~p, ~k v ~c, ~j v ~g v ~j, ~i v ~g v q v h, ~i v z v ~e, ~i v z v e v ~n, ~i v r v ~r v m, ~h v ~j v r v ~g, ~h v ~a, ~h v p, ~g v ~s v ~c v ~p, ~g v ~r, ~z v ~d v o v l v a, ~z v d v p v d, ~e v o v e, ~d v ~n v r v ~d v ~d, ~d v a v ~i, ~c v ~s, ~c v g, ~c v l v ~g v ~o, ~b v s v ~j, ~a v ~s v z, ~a v ~n v ~r v ~q, ~a v o v s v n, a v ~j, a v c, b v ~r v b v ~d, b v ~l, b v ~c v ~d v ~b v ~o, b v j v ~l v ~a v p, b v k v ~d v j v ~l, b v r, c v ~q v ~i v p, c v ~j, c v b v d, c v k, d v ~m v ~g v l, d v ~b v l v ~g v ~o, d v b, d v i, d v p v ~s v l, e v j v ~d v c v ~o, e v l v ~m, z v ~l v ~d v ~p v ~c, z v ~k v ~b v c, g v ~r, g v s v ~n v ~d v i, h v d v q v ~z v n, h v j v ~j v ~s, i v ~r, i v ~i, i v ~h v ~j v o, i v j v q v ~a, i v k v ~m v h, i v n, j v ~o v ~k v b, j v c v d, j v i, k v ~a v ~r, l v ~b v ~n v ~s v a, l v i, l v s v z v c, m v ~q v ~d v o, m v ~n, m v ~b, n v ~l v i v ~i, n v d v p v ~l v ~b, n v j v d v p v s, n v p v ~o v ~j, n v r, p v s v o v o v h, q v ~g v ~b v ~b, q v k v ~n v s, q v p v d v ~r v h, r v ~i v o v p, r v ~g v r v z v ~e, r v ~e v ~g v ~m, s v ~k v ~g, s v ~i v s], unsat).


prove_tests(prove_per_fail2, performance, [~s v ~q v h, ~s v ~c, ~s v q, ~r v ~n, ~r v j v b v j, ~r v k, ~q v ~m, ~q v ~b v q, ~q v f v ~e v o v r, ~q v j v s v ~q, ~q v l v e v ~j v n, ~p v b v f v ~q v ~p, ~m v ~m, ~l v ~o v i v l, ~k v ~k, ~j v ~q v a v s v f, ~j v l v ~j, ~i v ~h v n v q v a, ~i v ~h v q, ~i v ~d v ~o v ~l, ~i v d v ~l, ~h v ~s v ~b, ~g v f v ~b, ~g v k v ~h v ~m, ~g v k v a v e v ~r, ~g v n v ~g v ~s v ~q, ~g v o v ~i v ~o v b, ~g v o v d v ~b v ~s, ~f v ~m, ~f v ~i v ~d v f v ~b, ~f v ~e v g, ~f v ~c, ~f v ~a v ~j v ~o, ~f v n v ~k, ~e v ~g, ~e v ~g v ~p v ~k v ~f, ~e v l, ~e v l v n v ~l, ~e v n v m v ~h, ~d v b v e v i v g, ~d v e v i, ~d v e v m v a, ~c v ~p v ~d, ~c v ~h v m v h, ~b v ~f v ~c, ~b v j v q v ~a v ~n, ~b v q, ~a v ~m, ~a v ~k v ~h v ~l v h, ~a v ~e v ~g, ~a v ~c, a v ~s v ~g v ~g v ~h, a v ~s v j v ~k, a v ~c v ~g v l v ~c, a v h v b v m, b v ~q v ~q v a v n, b v ~m, b v g v ~a v ~a v r, c v ~b v ~p, d v ~h, d v g, d v i v ~h, f v ~o v ~o, f v ~d v ~f v ~m v o, g v e, h v r v ~d v n, i v ~o v ~c, i v ~e v ~b, i v a, i v c v k, i v d v i v ~d v ~d, i v p, j v ~a v r v ~l, j v i v ~k v b v ~a, j v i v ~e v ~p v a, j v k v h v ~g v l, k v ~e v ~s v ~i v ~q, k v c v k v ~r v ~a, k v o v p v ~f, l v ~b, l v h v ~f v c, m v ~h, m v ~d, m v ~a v f, n v ~j v ~q v ~r, n v ~b, n v j v ~d, o v ~r v ~e, o v ~g v ~k, o v l, p v ~j v g v r v n, p v ~h, q v ~q v ~q v ~r v ~q, q v e, q v l v ~d v g v c, r v ~c, s v d v a v ~h, s v d v p v k v j, s v o v m], unsat).


prove_tests(prove_per_big, performance, [~j v g v j v ~d v j, ~i v ~d v z v a v d v g v i v z, ~i v ~c v ~c v ~e v ~c v d v z v ~a, ~i v ~a v ~h v d, ~i v b v ~g, ~i v h v b v e v ~z v ~a v a v b v ~e v ~g, ~h v ~b v d v c v h v ~i v ~a, ~h v z v d v e v ~b, ~h v h v ~d v d v ~z v ~d v ~g v h v ~j v ~b, ~g v e v g v ~e v ~d, ~g v h v ~e v b v c v c v h v ~g v i, ~g v j v d v b, ~z v d v ~b v i v d v ~a v ~h v ~h, ~z v j v h v ~j v ~e v g v ~a v z v ~c v ~j, ~e v ~e v ~z v ~d v ~e v ~z v ~d v ~j v ~i, ~e v ~d v b, ~e v e v ~a v g v ~e v ~h v ~e v ~e v ~e v z, ~e v i v ~a, ~d v ~i v e v ~z v c v ~j v ~c v ~c, ~d v ~g v z v ~z, ~d v ~a v ~h v b v e v ~a v ~z v ~d v ~h, ~c v ~d v ~h v ~a v ~e v ~b v ~j v ~a, ~c v ~b v c v ~c v z v ~h v z v c v ~j v ~g, ~b v ~e v i v ~d v ~d v ~d, ~a v ~e v a v ~i v i v ~g v ~e, ~a v ~a v b v ~h v g v b v a v ~z, a v ~d v e v a v ~h v ~c, a v ~a v c v ~c v i v ~i v c, a v e v ~h v ~e v a v ~e v ~g v h v i v h, b v ~j v ~c v h v d v d v z v ~j v ~h, b v ~b v h v z v j v ~h v j v a, b v a v d v d v e v h v ~i v ~j, c v ~g v a v ~g, d v ~d v ~d v ~g v ~b v ~g v h v ~c v j, d v b v b v ~d v h v ~a v ~e v j, e v d v ~h v ~i v ~i, e v e v i, e v h v ~i v a v ~e, z v ~g v a v d, z v e v a v ~c v ~c v d, g v ~g v i v ~a v ~c v d, g v c v ~z v ~j v d v a v b v d v ~c v ~e, g v z v ~c v z v h v z v ~z v e, g v z v b v h v ~b v ~g v c, h v z v z v h v h v ~c v ~i v ~j v ~i v b, i v ~d v j v ~h v j v j v a v d, i v ~c v i v i, i v b v b v c, i v c v c v ~e v ~i v ~c v ~z v z v i, j v a v ~a v ~d v ~d v ~b v ~j v z v a], sat).


prove_test(prove_per_biggest, performance, [~j v ~e v ~a v ~g, ~j v g v a v ~g v ~e v j v d v ~g v h v i, ~i v z v ~b v g v ~i, ~i v g v c v ~c v z v g v ~j v e, ~i v h v ~i v ~g v z v b v c v a v ~j v b, ~i v j v z v d v z v a v ~e v ~c v ~e v h, ~h v ~h v j v ~e v ~d v i v ~j v ~b v e, ~h v a v i v ~g v h v h v ~i v c v h v a, ~z v ~j v ~g v ~z v d v g, ~z v ~c v c v ~j v i v ~e v b v z, ~z v ~a v c v c v ~h v g v ~b v ~h, ~e v i v ~z v g v ~d v ~j, ~d v ~b v h v ~d v ~h v ~j v ~e v ~z v c, ~d v c v e v d v a v a v e, ~d v d v ~b v ~z v ~c v ~j v z v d v ~c v b, ~c v ~z v z v ~h, ~c v ~d v ~h v b v j v j v ~e v g v d v ~h, ~b v ~a v g v ~h v ~g v i v z, ~b v a v ~d, ~b v d v ~j v g v ~h v ~a v ~c, ~a v ~j v ~d v e v j v g v c, ~a v ~j v ~b v b v e v ~h v z v ~g v ~z, ~a v e v c, ~a v i v ~i v z v e v ~z v c v ~g, a v ~g v h v c v e v ~j v ~i, a v z v ~j v ~d v ~i v ~h v ~g v h, b v a v ~e v ~e v g v ~j v ~c v ~i v ~d, b v d v ~i v e v ~a v j, b v j v ~i, c v ~g v c v ~i v e v b v j, d v ~z v a v e, d v c v e v z v e v ~c v d v g, d v h v ~d v ~a v j v ~c v c v c v e v ~j, d v h v ~b v ~b v b v h v ~b v ~i v ~e v j, d v h v b v e v g v c v ~i v ~d v ~i v a, e v ~g v i v ~i v ~h, e v ~e v ~d v j v ~h v ~h v ~a v d v ~d v e, e v ~a v g v ~a v c v ~i v e v j, e v j v b, g v ~d v ~b v z v g v ~h, g v ~a v a v ~j v ~d v e v g v ~i v c v ~b, g v b v z v a v ~h, g v e v i v a v ~z v ~b v ~d v h v c v ~j, h v ~j v ~a, h v ~c v ~j v ~h v c v b v ~e, h v e v a v ~a v e v b v ~c v ~b v ~h, h v j v ~d v ~g v ~h v c v j, i v c v d v ~b, i v e v ~e v ~j v a v ~c v ~i v ~h v ~d v ~g, i v j v c v ~b v ~b v a v ~b], sat).


prove_tests(prove_per_lots_of_small, performance, [~o v b, ~n v a v j, ~n v m, ~l v ~a v ~h, ~k v ~d, ~k v ~a v ~c, ~j v k v l, ~i v ~j, ~h v ~d, ~h v j v l, ~h v k v ~n, ~g v j v ~m, ~z v b v ~g, ~e v c v ~a, ~e v h v ~m, ~d v ~j, ~c v ~i v ~g, ~a v ~i, c v ~j, c v k v o, z v j v ~l, h v k v b, i v ~i, i v h v ~l, k v j, l v a, n v ~n, n v m v ~i, o v ~h, o v a], sat).
