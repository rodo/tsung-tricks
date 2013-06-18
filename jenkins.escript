#!/usr/bin/escript
%% -*- erlang -*-
%%! -pa ebin/
main(_Args) ->
  eunit:test([geoserver,wmsosm], [{report,{eunit_surefire,[{dir,"."}]}}]).
