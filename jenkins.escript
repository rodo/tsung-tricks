#!/usr/bin/escript
%% -*- erlang -*-
%%! -pa ebin-test/
main(_Args) ->
    eunit:test([geoserver,wmsosm,randomdate,slippymap], [{report,{eunit_surefire,[{dir,"."}]}}]).

