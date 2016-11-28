-module(format_dt_test).

-export([test_lexer_speed/2]).
-export([recompile_all/0]).
-export([test_parser/0]).

-define(MAX, 10).

recompile_all() ->
    leex:file("format_dt.xrl"),
    compile:file(format_dt),
    yecc:file("format_dt_parser.yrl"),
    compile:file(format_dt_parser),
    compile:file(format_datetime).

test_parser() ->
    {ok, E, _} = format_dt:string("%d-%s:%m"),
    {_, _, Micros} = Now = erlang:now(),
    erlang:put(local_time, calendar:now_to_local_time(Now)),
    erlang:put(universal_time, calendar:now_to_universal_time(Now)),
    erlang:put(micros, Micros),
    format_dt_parser:parse(E).

test_lexer_speed(SLength, Count) ->
    Str = generate_str(SLength, []),
    io:format("Str = ~p~n", [Str]),
    {Time, _R} = timer:tc(fun() ->
                                 [format_dt:string(Str) || _ <- lists:seq(1, Count)]
                         end),
    io:format("Time = ~p~n", [Time]).

generate_str(0, R) -> lists:reverse(lists:flatten(R));
generate_str(C, R) -> generate_str(C - 1, [lists:reverse(get_el(random:uniform(?MAX))) | R]).

get_el(1)  -> "%a";
get_el(2)  -> "%A";
get_el(3)  -> "%b";
get_el(4)  -> "%LB";
get_el(5)  -> "%Ub";
get_el(6)  -> "%:";
get_el(7)  -> "%---";
get_el(8)  -> "%:::";
get_el(9)  -> "%---++";
get_el(10) -> "%:ahoj".
