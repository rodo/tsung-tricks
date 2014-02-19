%%
%%
%%
-module(test_all).
-include_lib("eunit/include/eunit.hrl").

all_test_() -> [jsonurls_tests,
                htmlconv_tests,
                percentile_tests,
                randomdate_tests].
