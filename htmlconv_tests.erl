%%
%% Unit tests for jsonurls modules
%%
%%
-module(htmlconv_tests).
-include_lib("eunit/include/eunit.hrl").
-author({author, "Rodolphe Quiedeville", "<rodolphe@quiedeville.org>"}).

amp_test()->
    ?assertEqual("foo&bar", htmlconv:decode_entities("foo&amp;bar")).

greater_test()->
    ?assertEqual("a>b", htmlconv:decode_entities("a&gt;b")).

lether_test()->
    ?assertEqual("a<b", htmlconv:decode_entities("a&lt;b")).

apos_test()->
    ?assertEqual("a'b", htmlconv:decode_entities("a&apos;b")).

quote_test()->
    ?assertEqual("a\"b", htmlconv:decode_entities("a&quot;b")).
