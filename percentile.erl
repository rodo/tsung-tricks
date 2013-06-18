%%
%% @doc erlang module to calculate percentile
%%
%% @author Rodolphe Quiedeville <rodolphe@quiedeville.org>
%%   [http://rodolphe.quiedeville.org]
%%
%% @copyright 2013 Rodolphe Quiedeville
%%

-module('percentile').
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
