-module(wmsosm).
-export([urlzxy/1,fillall/0]).

urlzxy({Pid, Dynvar})->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    %% Zoom level    
    Arr = fillall(),
    Key = random:uniform(171)-1,
    Zoomlevel = array:get(Key, array:from_list(Arr)),
    %% url to include in tsung request like /%%wmsosm:urlzxy%%.png
    string:concat(zoomlevel(Zoomlevel), coord(Zoomlevel)).

zoomlevel(N)->
    string:concat(integer_to_list(N), "/").

coord(N)->
    string:concat(coordx(N), coordy(N)).

coordx(N)->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    X = random:uniform(trunc(math:pow(2, N)))-1,
    string:concat(integer_to_list(X), "/").

coordy(N)->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    Y = random:uniform(trunc(math:pow(2, N)))-1,
    integer_to_list(Y).

fillall()->
    fillall(1, []).

fillall(N, List) when N =< 18->
    lists:merge(fillall(N + 1, List),lists:seq(N, 18));
fillall(_, _)->
    [].
