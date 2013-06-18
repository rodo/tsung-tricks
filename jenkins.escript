#!/usr/bin/escript

main(_Args) ->
  eunit:test([geoserver,wmsosm], [{report,{eunit_surefire,[{dir,"."}]}}]).
