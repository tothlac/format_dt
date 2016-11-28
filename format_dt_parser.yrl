Nonterminals list elems elem.
Terminals string function.
Rootsymbol list.

list -> elems         : '$1'.

elems -> elem         : ['$1'].
elems -> elem elems   : ['$1'|'$2'].

elem -> function      : call_function('$1').
elem -> string        : '$1'.

Erlang code.

-include("format_dt.hrl").

call_function({_Token, _Line, Function}) ->
    io:format("Function : ~p~n", [Function]),
    #date_info{} = DateInfo = erlang:get(date_info),
    io:format("DateInfo : ~p~n", [DateInfo]),
    Result = ?MOD:Function(DateInfo),
    io:format("Result : ~p~n", [Result]),
    Result.
    
