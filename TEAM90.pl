:- dynamic word/2.
is_category(C):-
	word(_,C).
 
 categories(L):-	
	setof(C,is_category(C),L).

get_length([],[]).

get_length([H|T],Y):-
	get_length(T, Y),
	string_length(H,H1),
	member(H1,Y).

get_length([H|T],[H1|Y]):-
	get_length(T, Y),
	string_length(H,H1),
	\+member(H1,Y).
	
available_length(X):-
	setof(W,(W,Y)^word(W,Y),R1),
	get_length(R1,L),
	member(X,L).
	
pick_word(W,L,C):-
	word(W,C),
	available_length(L),
	string_length(W, L).
	
correct_letters([H|T],L2,[H|T1]):-
	member(H,L2),
	correct_letters(T,L2,T1),
    \+member(H, T1).

correct_letters([H|T],L2,T1):-
	member(H,L2),
	correct_letters(T,L2,T1),
    member(H, T1).

correct_letters([H|T],L2,T1):-
	\+member(H,L2),
	correct_letters(T,L2,T1).

correct_letters([] ,_ ,[] ).


correct_positions([],_,[]).

correct_positions([H1|T1], [H1|T2], [H1|T3]):-
	correct_positions(T1, T2, T3).

correct_positions([H1|T1], [H2|T2], T3):-
	H1 \== H2,
	correct_positions(T1, T2, T3).
	
available_len_of_a_specific_cate(C,R):-
	setof(L,(X,L,C)^pick_word(X,L,C),R).

build_kb:-
	write("Welcome to Pro-Wordle!"),nl,
	write("----------------------"),nl,nl,
	build_help,nl,
	write("Done building the words database..."), nl, nl.
	
build_help:-
	write("Please enter a word and its category on seperate lines:"),nl,
	read(Word),
	( 	Word = done;
		read(Category),
		assert(word(Word, Category)),
		build_help
	).

choose_category(X):-
	write("Choose a category: "), nl,
	read(C),
	(	(is_category(C), X = C);
		write("This category does not exist."), nl,
		choose_category(X)
	).

choose_length(X,C):-
	write("Choose a length: "), nl,
	read(Y),
	(	(available_len_of_a_specific_cate(C,L), member(Y,L), X=Y);
		write("There are no words of this length. "), nl,
		choose_length(X,C)
	).
	
game(0, _, _):-
	write("You lost!").
	
game(Ng,L,W1):-
	write("Enter a word composed of "),
	write(L),write(" letters:"), nl,
	read(W),
	(   (string_length(W,X),
	    X\=L,
        write("Word is not composed of "),write(L),write(" letters. Try again."),nl,
        write("Remaining Guesses are "),write(Ng), nl, nl,
        game(Ng,L,W1));
	
        ((
            W\=W1,
            Ng1 is Ng-1,
            (   
                (
                    Ng1 = 0,
                    game(Ng1,L,W1)
                );
                (
                    string_chars(W,X),
                    string_chars(W1,Y),
                    correct_letters(X,Y,R),
                    write("Correct letters are: "),
                    write(R), nl,
                    correct_positions(X,Y,R1),
                    write("Correct letters in correct positions are: "),
                    write(R1),nl,
                    write("Remaining Guesses are "),
                    write(Ng1), nl, nl,
                    game(Ng1,L,W1)
                )
            ));
        
            (W=W1, write("You Won!"))
        )
    ).


play:-
	write("The available categories are: "),
	categories(L),
	write(L),nl,
	choose_category(X),
	choose_length(A,X),
	write("Game started. You have "),
	R is A+1,
	write(R),write(" guesses."), nl, nl,
	pick_word(W,A,X),
	game(R,A,W).
	
main:-
	build_kb,nl,play.