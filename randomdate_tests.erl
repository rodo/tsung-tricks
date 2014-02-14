%%
%% @doc erlang module return a random date beetween limits
%% date will be beetween today - LIMIT and today + LIMIT
%% @author Rodolphe Quiedeville <rodolphe@quiedeville.org>
%%   [http://rodolphe.quiedeville.org]
%%
%% @copyright 2013 Rodolphe Quiedeville
%%

-module(randomdate_tests).
-include_lib("eunit/include/eunit.hrl").

%% Tests
get_date_format_test() ->
    ?assert(is_binary(randomdate:get_date({0,0}))).

delta_test() ->
    ?assert(randomdate:delta() < 10).


