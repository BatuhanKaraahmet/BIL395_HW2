:- dynamic var/2.

start :-
    write('> '), flush_output,
    read_line_to_string(user_input, input),
    ( input = "exit" ; input = "quit" -> true
    ; parse_and_eval(input), start).

parse_and_eval(Line) :-
    split_string(Line, "=", " ", Parts),
    ( Parts = [VarStr, ExprStr] ->
        atom_string(Var, VarStr),
        tokenize(ExprStr, Tokens),
        ( catch(eval(Tokens, Val), E, (print_message(error, E), fail)) ->
            retractall(var(Var, _)),
            assertz(var(Var, Val)),
            format("~w~n", [Val])
        ; true )
    ; tokenize(Line, Tokens),
      ( catch(eval(Tokens, Val), E, (print_message(error, E), fail)) ->
          format("~w~n", [Val])
      ; true )
    ).

tokenize(Str, Tokens) :-
    split_string(Str, " ", " ", Tokens).

lookup(Token, Val) :-
    atom_string(Name, Token),
    ( var(Name, Val) -> true
    ; catch(number_string(Val, Token), _, fail) -> true
    ; throw(error(unknown_variable(Token), _))).

eval([A], Val) :- lookup(A, Val).
eval([A, Op, B], Result) :-
    lookup(A, Val1), lookup(B, Val2),
    ( Op = "+" -> Result is Val1 + Val2
    ; Op = "-" -> Result is Val1 - Val2
    ; Op = "*" -> Result is Val1 * Val2
    ; Op = "/" -> (Val2 =:= 0 -> throw(error(division_by_zero, _)) ; Result is Val1 / Val2)
    ; throw(error(invalid_operator(Op), _)) ).

