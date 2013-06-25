%%
%% Read json data, extract urls from it and return a List
%%
%% DynVars used :
%%  - jsonurls
%%
%% [ {"url": "/foobar/index?page=0"},
%%   {"url": "/foobar/index?page=1"} ]
%% will return an erlang List as :
%% ["/foobar/index?page=0","/foobar/index?page=1"]
%%
-module(jsonurls).
-include_lib("eunit/include/eunit.hrl").
-export([get_urls/1]).
-author({author, "Rodolphe Quiedeville", "<rodolphe@quiedeville.org>"}).

get_urls({_Pid, DynVars})->
    fillurls(decode(DynVars)).

decode(DynVars)->
    case ts_dynvars:lookup(jsonurls, DynVars) of
        {ok, Val} -> mochijson2:decode(Val);
        false -> []
    end.

fillurls(List) ->
    fillurls([],List).

fillurls(Urls,[])->
    Urls;
fillurls(Urls,List)->
    [H|T]=List,
    lists:merge([url(H)], fillurls(Urls,T)).

url(Elmt) ->
    {struct, JsonData} = Elmt,
    Value = proplists:get_value(<<"url">>, JsonData),
    case is_binary(Value) of
        true -> binary_to_list(Value);
        false -> Value
    end.


