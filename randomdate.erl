%%
%% @doc erlang module return a random date beetween limits
%% date will be beetween today - LIMIT and today + LIMIT
%% @author Rodolphe Quiedeville <rodolphe@quiedeville.org>
%%   [http://rodolphe.quiedeville.org]
%%
%% @copyright 2013 Rodolphe Quiedeville
%%

-module(randomdate).
-export([get_date/1]).

-define(LIMIT, 10).

get_date({_Pid,_Dynvars})->
    fdate(rdate()).

fdate({Year,Month,Day})->
    list_to_binary(io_lib:format("~w%2F~w%2F~w", [Month,Day,Year])).

rdate()->
    calendar:gregorian_days_to_date(calendar:date_to_gregorian_days(date()) + delta()).

delta()->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    ?LIMIT-random:uniform(?LIMIT * 2).
