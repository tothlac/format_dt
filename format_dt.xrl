Definitions.

Rules.

[%][a-zA-Z]+       : {token, {function, TokenLine, to_function(TokenChars)}}.
.                  : {token, {string, TokenLine, TokenChars}}.
Erlang code.

-spec to_function(Chars :: string()) -> atom().
to_function([$%, $L | Cs]) -> to_function(Cs, "local");
to_function([$%, $U | Cs]) -> to_function(Cs, "universal");
to_function([$% | Cs])     -> to_function(Cs, "local").

-spec to_function(Chars :: string(), TZ :: local | universal) -> atom().
to_function("a", TZ) -> to_func("abbreviated_weekday_name", TZ);
to_function("A", TZ) -> to_func("full_weekday_name", TZ);
to_function("b", TZ) -> to_func("abbreviated_month_name", TZ);
to_function("B", TZ) -> to_func("full_month_name", TZ).

to_func(Name, TZ) ->
    list_to_atom(TZ ++ "_" ++ Name).
