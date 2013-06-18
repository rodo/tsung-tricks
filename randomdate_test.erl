%%
%% @doc erlang module return a random date beetween limits
%% date will be beetween today - LIMIT and today + LIMIT
%% @author Rodolphe Quiedeville <rodolphe@quiedeville.org>
%%   [http://rodolphe.quiedeville.org]
%%
%% @copyright 2013 Rodolphe Quiedeville
%%

-module(randomdate_test).
-include_lib("eunit/include/eunit.hrl").

%% Tests
delta_test() ->
    ?assert(delta() < ?LIMIT).
