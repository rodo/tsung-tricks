#!/usr/bin/escript
%% -*- erlang -*-
%%! -pa ebin/
main(_Args) ->
  eunit:test([geoserver,wmsosm,randomdate,slippymap], [{report,{eunit_surefire,[{dir,"."}]}}]).
