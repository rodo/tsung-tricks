%%
%% @doc erlang module to calculate percentile
%%
%% @author Rodolphe Quiedeville <rodolphe@quiedeville.org>
%%   [http://rodolphe.quiedeville.org]
%%
%% @copyright 2013 Rodolphe Quiedeville
%%

-module('percentile').
-include_lib("eunit/include/eunit.hrl").
-export([percentile/2]).
-export([percentile95/1,percentile98/1]).

percentile95(L)-> percentile(L,0.95).
percentile98(L)-> percentile(L,0.98).

percentile(L, P)->
    K=(length(L) - 1) * P,
    F=floor(K),
    C=ceiling(K),
    final(lists:sort(L),F,C,K).

final(L,F,C,K) when (F == C)->
    lists:nth(trunc(K)+1,L);
final(L,F,C,K) ->
    pos(L,F,C,K) + pos(L,C,K,F).

pos(L,A,B,C)->
    lists:nth(trunc(A)+1,L) * (B-C).

%% @doc http://schemecookbook.org/Erlang/NumberRounding
floor(X) ->
    T = erlang:trunc(X),
        case (X - T) of
        Neg when Neg < 0 ->
		T - 1;
	            Pos when Pos > 0 -> T;
        _ -> T
	end.

%% @doc http://schemecookbook.org/Erlang/NumberRounding
ceiling(X) ->
    
    T = erlang:trunc(X),
        case (X - T) of
        Neg when Neg < 0 ->
		T;
	            Pos when Pos > 0 -> T + 1;
        _ -> T
    end.

%% tests
percentile95_test() ->
    ?assertEqual(25.80902099609375, percentile95([19.656982421875,196.5009765625,12.508056640625,15.0078125,20.738037109375,12.696044921875,17.593017578125,12.496826171875,12.367919921875,13.0419921875,20.9521484375,27.427978515625,12.858154296875,18.35302734375,20.18798828125,16.416015625,20.251953125,12.640869140625,11.968017578125,10.56396484375,14.764892578125,10.26611328125,14.7451171875,12.552001953125,9.23583984375,14.7080078125])).

percentile98_test() ->
    ?assertEqual(111.9644775390625, percentile98([19.656982421875,196.5009765625,12.508056640625,15.0078125,20.738037109375,12.696044921875,17.593017578125,12.496826171875,12.367919921875,13.0419921875,20.9521484375,27.427978515625,12.858154296875,18.35302734375,20.18798828125,16.416015625,20.251953125,12.640869140625,11.968017578125,10.56396484375,14.764892578125,10.26611328125,14.7451171875,12.552001953125,9.23583984375,14.7080078125])).
