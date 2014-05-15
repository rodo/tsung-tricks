%%
%% @doc erlang module to simulate typeahead
%%
%% @author Rodolphe Quiedeville <rodolphe@quiedeville.org>
%%   [http://rodolphe.quiedeville.org]
%%
%% @copyright 2013 Rodolphe Quiedeville
%%

-module(typeahead_tests).
-include_lib("eunit/include/eunit.hrl").

%% tests
typeahead_test() ->
    Result = typeahead:typeahead("belleville", 2, 4),
    Attend = ["be", "bel", "bell"],
    ?assertEqual(Result, Attend).

typeahead_default_test() ->
    Result = typeahead:typeahead("belleville"),
    Attend = ["bel", "bell", "belle", "bellev"],
    ?assertEqual(Result, Attend).

typeahead_default_small_test() ->
    Result = typeahead:typeahead("foo"),
    Attend = ["foo"],
    ?assertEqual(Result, Attend).


splithead_test() ->
    Result = typeahead:splithead("belleville", 2, 6),
    Attend = ["be", "llev"],
    ?assertEqual(Result, Attend).

