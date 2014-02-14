%%
%% Unit tests for jsonurls modules
%%
%%
-module(jsonurls_tests).
-include_lib("eunit/include/eunit.hrl").
-author({author, "Rodolphe Quiedeville", "<rodolphe@quiedeville.org>"}).

%% Tests
url_test()->
    Data = {struct, [{<<"url">>, "foo1"}]},
    ?assertEqual("foo1", jsonurls:url(Data)).

url_binary_test()->
    Data = {struct, [{<<"url">>, <<"foo1">>}]},
    ?assertEqual("foo1", jsonurls:url(Data)).

fillurls_test()->
    Data = [{struct, [{<<"url">>, "foo1"}]}, {struct, [{<<"url">>, "foo2"}]}],
    Assert = ["foo1", "foo2"],
    ?assertEqual(Assert, jsonurls:fillurls(Data)).

decode_test()->
    Data = ts_dynvars:new(jsonurls, "[{\"url\":\"/foobar/index?page=0\"},{\"url\":\"/foo?p=1\"}]"),
    Assert = [{struct, [{<<"url">>, <<"/foobar/index?page=0">>}]},
              {struct, [{<<"url">>, <<"/foo?p=1">>}]}],
    ?assertEqual(Assert, jsonurls:decode(Data)).

get_url_test()->
    Data = ts_dynvars:new(jsonurls, "[{\"url\":\"/foobar?page=0\"},{\"url\":\"/foo/i?p=1\"}]"),
    Assert = ["/foo/i?p=1","/foobar?page=0"],
    ?assertEqual(Assert, jsonurls:get_urls({1, Data})).
