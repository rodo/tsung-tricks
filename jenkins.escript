#!/usr/bin/escript
%% -*- erlang -*-
%%! -pa ebin-test/ /home/jenkins/proj4erl
main(_Args) ->
    eunit:test([test_all], [{report,{eunit_surefire,[{dir,"."}]}}]).
