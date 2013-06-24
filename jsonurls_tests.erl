%%
%% Unit tests for jsonurls modules
%%
%% 
-module(jsonurls_tests).
-include_lib("eunit/include/eunit.hrl").
-author({author, "Rodolphe Quiedeville", "<rodolphe@quiedeville.org>"}).


%% Tests
url_test()->
    Data = {struct,[{<<"url">>, "foo1"}]},
    Assert = "foo1",
    ?assertEqual(Assert, jsonurls:url(Data)).

url_binary_test()->
    Data = {struct,[{<<"url">>, <<"foo1">>}]},
    Assert = "foo1",
    ?assertEqual(Assert, jsonurls:url(Data)).


fillurls_test()->
    Data = [{struct,[{<<"url">>, "foo1"}]}, {struct,[{<<"url">>, "foo2"}]}],
    Assert = ["foo1", "foo2"],
    ?assertEqual(Assert, jsonurls:fillurls(Data)).


decode_test()->
    Data = ts_dynvars:new(jsonurls, "[{\"url\":\"/foobar/index?page=0\"},{\"url\":\"/foobar/index?page=1\"}]"),
    Assert = [{struct,[{<<"url">>, <<"/foobar/index?page=0">>}]},
              {struct,[{<<"url">>, <<"/foobar/index?page=1">>}]}],
    ?assertEqual(Assert, jsonurls:decode(Data)).

get_url_test()->
    Data = ts_dynvars:new(jsonurls, "[{\"url\":\"/foobar/index?page=0\"},{\"url\":\"/foobar/index?page=1\"}]"),
    Assert = ["/foobar/index?page=0", "/foobar/index?page=1"],
    ?assertEqual(Assert, jsonurls:get_urls({1,Data})).
