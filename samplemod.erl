%%
%% Sample module to show how using dynvars in module
%%
%%
%% You have defined the following lines in your scenario
%% and want to use the var named bar1 in your module
%%
%%  <setdynvars sourcetype="random_string" length="13">
%%    <var name="bar1" />
%%  </setdynvars>
%%
%%  <setdynvars sourcetype="erlang" callback="samplemod:foo">
%%    <var name="id1" />
%%  </setdynvars>
%%
%%  <request subst="true">
%%    <http url="/?%%_id1%%" method="GET" version="1.1" ></http>
%%  </request>

-module('samplemod').
-export([foo/1]).

foo({_Pid, DynVars})->
    {ok, Rand}=ts_dynvars:lookup(bar1,DynVars),
    "random=" ++ binary_to_list(Rand).
