:- module(marcin_drewniak, [parse/3]).

%lexer jest modyfikacja lexera z while-parsera umieszczonego na skosie. przy pisaniu parsera rowniez pomogl mi while-parser, choc moj parser nie jest juz modyfikacja.
%no i staralem sie pisac tak, zeby dlugie byly tylko komentarze



lexer(Tokens) -->
   white_space,
   (  (  ",",      !, { Token = tokComma }
      ;  "<>",       !, { Token = tokNotEq }
      ;  "<=",       !, { Token = tokLessEq }
      ;  ">=",       !, { Token = tokGreaterEq }
      ;  "=",       !, { Token = tokEqual }
      ;  "<",       !, { Token = tokLess }
      ;  ">",       !, { Token = tokGreater }
      ;  "^",       !, { Token = tokPow }
      ;  "|",      !, { Token = tokSpl }
      ;  "+",      !, { Token = tokPlus }
      ;  "-",       !, { Token = tokMinus }
      ;  "&",      !, { Token = tokAmp }
      ;  "*",       !, { Token = tokMult }
      ;  "/",       !, { Token = tokDiv }
      ;  "%",       !, { Token = tokMod }
      ;  "@",       !, { Token = tokAnn }
      ;  "#",       !, { Token = tokHash }
      ;  "~",       !, { Token = tokNeg }
      ;  "(",       !, { Token = tokLBracket }
      ;  ")",       !, { Token = tokRBracket }
      ;  "[",       !, { Token = tokLSqBracket }
      ;  "]",       !, { Token = tokRSqBracket }
      ;  "..",       !, { Token = tokTo}
      ;  digit(D),  !,
            number(D, N),
            { Token = tokNumber(N) }
      ;  letter(L), !, identifier(L, Id),
            {  member((Id, Token), [ (def, tokDef),
                                     (else, tokElse),
                                     (if, tokIf),
                                     (in, tokIn),
                                     (let, tokLet),
                                     (then, tokThen),
                                     ('_', tokUnder)]),
               !
            ;  Token = tokVar(Id)
            }
      ;  [_],
            { Token = tokUnknown }
      ),
      !,
         { Tokens = [Token | TokList] },
      lexer(TokList)
   ;  [],
         { Tokens = [] }
   ).

white_space -->
   [Char], { code_type(Char, space) }, !, white_space.
white_space --> "(*", !, comments(1), white_space.
white_space -->
   [].

comments(0) --> !.
comments(X) --> "*)", !, { X2 is X-1 }, comments(X2).
comments(X) --> "(*", !, { X2 is X+1 }, comments(X2).
comments(X) --> [_], comments(X).
   
digit(D) -->
   [D],
      { code_type(D, digit) }.

digits([D|T]) -->
   digit(D),
   !,
   digits(T).
digits([]) -->
   [].

number(D, N) -->
   digits(Ds),
      { number_chars(N, [D|Ds]) }.

letter(L) -->
   [L], { code_type(L, csymf) }.

alphanum([A|T]) -->
   [A], { A == 39 ; code_type(A, csym) }, !, alphanum(T).
alphanum([]) -->
   [].

identifier(L, Id) -->
   alphanum(As),
      { atom_codes(Id, [L|As]) }.



/*			GRAMATYKA HDML. Wersja zaimplementowana ulegla zmianom.

	program --> definicje
	definicje --> [] | definicja definicje
	definicja --> "def" identyfikator"(" wzorzec ")" "=" wyrazenie
	wzorzec --> "_" | zmienna | "(" wzorzec ")" | wzorzec "," wzorzec
	wyrazenie --> "if" wyrazenie "then" wyrazenie "else" wyrazenie
		    | "let" wzorzec "=" wyrazenie "in" wyrazenie
		    | wyrazenia_przecinek
	wyrazenia_przecinek --> relacyjne przecinek wyrazenia_przecinek | relacyjne
	relacyjne --> malpa op_rel malpa | malpa
	malpa --> plus_i_minus op_malpa malpa | plus_i_minus
	plus_i_minus --> plus_i_minus plus_i_koledzy dziel_i_mnoz | dziel_i_mnoz
	dziel_i_mnoz --> dziel_i_mnoz gwiazdka_i_koledzy un | un
	un --> op_un wyrazenie_proste, op_un "(" bin1 ")"
	wyrazenie_proste --> "("wyrazenie")" 
			   | wybor_bitu
			   | wybor_bitow
			   | wyrazenie_atomowe
	wybor_bitu --> wyrazenie_proste "["wyrazenie"]"
	wybor_bitow --> wyrazenie_proste "["wyrazenie ".." wyrazenie"]"
	wyrazenie_atomowe --> zmienna | wywolanie_funkcji | liczba
			    | pusty_wektor | pojedynczy_bit
	zmienna --> identyfikator
	wywolanie_funkcji --> identyfikator "("wyrazenie")"
	pusty_wektor --> "[""]"
	pojedynczy_bit --> "["wyrazenie"]"
	liczba --> cyfra | cyfra liczba
	cyfra --> 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9
	identyfikator --> poczatek dalej
	dalej --> [] | znak dalej
	poczatek --> "_" | "q" | "w" | "e" | "r" | "t" | "y" | "u" | "i" 
		   | "o" | "p" | "a" | "s" | "d" | "f" | "g" | "h" | "j"
		   | "k" | "l" | "z" | "x" | "c" | "v" | "b" | "n" | "m"
		   | "Q" | "W" | "E" | "R" | "T" | "Y" | "U" | "I" | "O"
		   | "P" | "A" | "S" | "D" | "F" | "G" | "H" | "J" | "K"
		   | "L" | "Z" | "X" | "C" | "V" | "B" | "N" | "M"

	dalej -->    "_" | "q" | "w" | "e" | "r" | "t" | "y" | "u" | "i" 
		   | "o" | "p" | "a" | "s" | "d" | "f" | "g" | "h" | "j"
		   | "k" | "l" | "z" | "x" | "c" | "v" | "b" | "n" | "m"
		   | "Q" | "W" | "E" | "R" | "T" | "Y" | "U" | "I" | "O"
		   | "P" | "A" | "S" | "D" | "F" | "G" | "H" | "J" | "K"
		   | "L" | "Z" | "X" | "C" | "V" | "B" | "N" | "M" | "'"
		   | "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8"
		   | "9"

	przecinek --> ","
	op_rel --> "=" | "<>" | "<" | ">" | "<=" | ">="
	gwiazdka_i_koledzy --> "&" | "*" | "/" | "%"
	plus_i_koledzy --> "|" | "^" | "+" | "-"
	op_malpa --> "@"
	op_un --> [] | "-" | "#" | "~"
*/




program(Prog) --> definicje(Prog).

definicje([H|T]) --> definicja(H), definicje(T).
definicje([]) --> [].

definicja(Def) --> [tokDef, tokVar(Id), tokLBracket], 
			wzorzec(Wz), [tokRBracket, tokEqual], 
			wyrazenie(Wyr), { Def = def(Id, Wz, Wyr) }.

wzorzec(Wz) --> wzorzec2(Wz).
wzorzec(Wz) --> wzorzec2(Wz2), [tokComma], wzorzec(Wz3), 
		{ Wz = pair(no, Wz2, Wz3) }. %chyba musze zejsc nizej, zeby sie nie zapetlalo, ale nie wiem. najwyzej potem poprawie

wzorzec2(Wz) --> [tokUnder], { Wz = wildcard(no) }.
wzorzec2(Wz) --> [tokVar(Id)], { Wz = var(no, Id) }.
wzorzec2(Wz) --> [tokLBracket], wzorzec(Wz), [tokRBracket]. %usuwanie nawiasow "nie sa potrzebne, jesli program jest juz w postaci drzewa"

wyrazenie(Wyr) --> [tokIf], wyrazenie(Wyr2), [tokThen], wyrazenie(Wyr3), 
		[tokElse], wyrazenie(Wyr4), { Wyr = if(no, Wyr2, Wyr3, Wyr4) }.
wyrazenie(Wyr) --> [tokLet], wzorzec(Wz), [tokEqual], wyrazenie(Wyr2), [tokIn], 
		wyrazenie(Wyr3), { Wyr = let(no, Wz, Wyr2, Wyr3) }.
wyrazenie(Wyr) --> wyrazenie_przecinek(Wyr).

wyrazenie_przecinek(Wyr) --> relacyjne(Wyr2), [tokComma], 
		wyrazenie_przecinek(Wyr3), { Wyr = pair(no, Wyr2, Wyr3) }.
wyrazenie_przecinek(Wyr) --> relacyjne(Wyr).

relacyjne(Wyr) --> malpa(Wyr2), operator_relacyjny(Op), malpa(Wyr3),
			{ Wyr = op(no, Op, Wyr2, Wyr3) }.  %musze zejsc poziom nizej, bo nielaczny
relacyjne(Wyr) --> malpa(Wyr).

malpa(Wyr) --> plus_i_minus(Wyr2), [tokAnn], malpa(Wyr3), 
		{ Wyr = op(no, '@', Wyr2, Wyr3) }.
malpa(Wyr) --> plus_i_minus(Wyr).

plus_i_minus(Wyr) --> dziel_i_mnoz(Wyr2), plus_i_minus(Wyr2, Wyr).

plus_i_minus(Acc, Acc) --> []. %potrzebuje kiedys zunifikowac wynik z drzewem w akumulatorze. albo po prostu pominac wyrazenia z operatorami priorytetu 4.
plus_i_minus(Acc, Wyr) --> plus_i_koledzy(Op), dziel_i_mnoz(Wyr2),
		{ Acc2 = op(no, Op, Acc, Wyr2) }, plus_i_minus(Acc2, Wyr). %akumulator tworzy drzewa dla trzeciego argumentu jakby rekurencyjnie. przechowuje stan poprzednich wyprowadzen.

dziel_i_mnoz(Wyr) --> unarne(Wyr2), dziel_i_mnoz(Wyr2, Wyr).

dziel_i_mnoz(Acc, Acc) --> [].
dziel_i_mnoz(Acc, Wyr) --> gwiazdka_i_koledzy(Op), unarne(Wyr2),
		{ Acc2 = op(no, Op, Acc, Wyr2) }, dziel_i_mnoz(Acc2, Wyr).

unarne(Wyr) --> operator_unarny(Op), unarne(Wyr2), { Wyr = op(no, Op, Wyr2) }. 
unarne(Wyr) --> wyrazenie_proste(Wyr).

wyrazenie_proste(Wyr) --> [tokLBracket], wyrazenie(Wyr), [tokRBracket].
wyrazenie_proste(Wyr) --> wyrazenie_atomowe(Wyr2), wyrazenie_proste(Wyr2, Wyr). %ten sam schemat, co przy pozostalych petlach. chociaz nie spodziewalem sie, ze akurat to mi sie zapetli.

wyrazenie_proste(Acc, Acc) --> [].  %w ten sposob zalatwiam dwie rzeczy. po pierwsze - dzieki temu zakoncze ewentualne wybory bitu/bitow. po drugie - wyrazenie_proste moze wyprowadzic wyrazenie_atomowe.
wyrazenie_proste(Acc, Wyr) --> wybor_bitu(Wyb), !, { Acc2 = bitsel(no, Acc, Wyb) },
				wyrazenie_proste(Acc2, Wyr). %jakby petla. zalatwiam w ten sposob fakt, ze przed nawiasami kwadratowymi stoi wyrazenie proste i zapobiegam petli
wyrazenie_proste(Acc, Wyr) --> wybor_bitow(Wyb1, Wyb2), 
		{ Acc2 = bitsel(no, Acc, Wyb1, Wyb2) }, wyrazenie_proste(Acc2, Wyr). %jak wyzej

wybor_bitu(Wyb) --> [tokLSqBracket], wyrazenie(Wyb), [tokRSqBracket].

wybor_bitow(Wyb1, Wyb2) --> [tokLSqBracket], wyrazenie(Wyb1), [tokTo], wyrazenie(Wyb2), [tokRSqBracket].

wyrazenie_atomowe(Wyr) --> [tokVar(Id)], { Wyr = var(no, Id) }. %zmienna
wyrazenie_atomowe(Wyr) --> [tokVar(Id), tokLBracket], 
		wyrazenie(Wyr2), [tokRBracket], { Wyr = call(no, Id, Wyr2) }. %wywolanie funkcji
wyrazenie_atomowe(Wyr) --> [tokNumber(N)], { Wyr = num(no, N) }. %literal calkowitoliczbowy
wyrazenie_atomowe(Wyr) --> [tokLSqBracket, tokRSqBracket], { Wyr = empty(no) }. %pusty wektor
wyrazenie_atomowe(Wyr) --> [tokLSqBracket], wyrazenie(Wyr2), 
			[tokRSqBracket], { Wyr = bit(no, Wyr2) }. %pojedynczy bit
wyrazenie_atomowe(Wyr) --> [tokLBracket], wyrazenie(Wyr), [tokRBracket]. %a bez tej petli z jakiegos powodu nie dzialalo za dobrze

%operatory
operator_relacyjny(Op) --> ([tokNotEq], { Op = '<>' } ).
operator_relacyjny(Op) --> ([tokLessEq], { Op = '<=' } ).
operator_relacyjny(Op) --> ([tokGreaterEq], { Op = '>=' } ).
operator_relacyjny(Op) --> ([tokEqual], { Op = '=' } ).
operator_relacyjny(Op) --> ([tokLess], { Op = '<' } ).
operator_relacyjny(Op) --> ([tokGreater], { Op = '>' } ).

plus_i_koledzy(Op) --> ([tokSpl], { Op = '|' } ).
plus_i_koledzy(Op) --> ([tokPow], { Op = '^' } ).
plus_i_koledzy(Op) --> ([tokPlus], { Op = '+' } ).
plus_i_koledzy(Op) --> ([tokMinus], { Op = '-' } ).

gwiazdka_i_koledzy(Op) --> ([tokAmp], { Op = '&' } ).
gwiazdka_i_koledzy(Op) --> ([tokMult], { Op = '*' } ).
gwiazdka_i_koledzy(Op) --> ([tokDiv], { Op = '/' } ).
gwiazdka_i_koledzy(Op) --> ([tokMod], { Op = '%' } ).

operator_unarny(Op) --> ([tokMinus], { Op = '-' } ).
operator_unarny(Op) --> ([tokHash], { Op = '#' } ).
operator_unarny(Op) --> ([tokNeg], { Op = '~' } ).









parse(Path, Codes, Program) :-
	phrase(lexer(Tokens), Codes),
	phrase(program(Program), Tokens).  %prawde mowiac nie wiedzialem, co zrobic. obecnosc Path wyrzuca warning, ale z drugiej strony to chyba nie moze byc _, bo specyfikacja.
