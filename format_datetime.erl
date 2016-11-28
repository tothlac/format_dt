-module(format_datetime).

-include("format_dt.hrl").

-export([format/2]).

-export([local_abbreviated_weekday_name/1,
         local_abbreviated_month_name/1,
         local_full_weekday_name/1,
         local_full_month_name/1,
         universal_abbreviated_weekday_name/1,
         universal_abbreviated_month_name/1,
         universal_full_weekday_name/1,
         universal_full_month_name/1]).

format(Fmt, Message) ->
    Now = erlang:now(),
    erlang:put(date_info,
               #date_info{local_time = calendar:now_to_local_time(Now),
                          universal_time = calendar:now_to_universal_time(Now),
                          log_entry = Message}),
    {ok, E, _} = format_dt:string(Fmt),
    io:format("E = ~p~n", [E]),
    format_dt_parser:parse(E).

-spec local_abbreviated_weekday_name(DateInfo :: #date_info{}) ->
    string().
local_abbreviated_weekday_name(_DateInfo) ->
    "MON".

-spec local_abbreviated_month_name(DateInfo :: #date_info{}) ->
    string().
local_abbreviated_month_name(_DateInfo) ->
    "JAN".

-spec local_full_weekday_name(DateInfo :: #date_info{}) ->
    string().
local_full_weekday_name(_DateInfo) ->
    "MONDAY".

-spec local_full_month_name(DateInfo :: #date_info{}) ->
    string().
local_full_month_name(_DateInfo) ->
    "JANUARY".

-spec universal_abbreviated_weekday_name(DateInfo :: #date_info{}) ->
    string().
universal_abbreviated_weekday_name(_DateInfo) ->
    "MON".

-spec universal_abbreviated_month_name(DateInfo :: #date_info{}) ->
    string().
universal_abbreviated_month_name(_DateInfo) ->
    "JAN".

-spec universal_full_weekday_name(DateInfo :: #date_info{}) ->
    string().
universal_full_weekday_name(_DateInfo) ->
    "MONDAY".

-spec universal_full_month_name(DateInfo :: #date_info{}) ->
    string().
universal_full_month_name(_DateInfo) ->
    "JANUARY".

