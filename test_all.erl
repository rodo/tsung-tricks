%%%-------------------------------------------------------------------
%%%
%%%-------------------------------------------------------------------
-module(test_all).

-compile(export_all).

-include_lib("eunit/include/eunit.hrl").

test() -> ok.

all_test_() -> [geoserver_tests,
		jsonurls_tests,
		percentile_tests,
		randomdate_tests,
		slippymap_tests,
		wmsosm_tests
               ].
