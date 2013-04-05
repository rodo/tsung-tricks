%%% -*- coding: utf-8 -*-  pylint: disable-msg=R0801
%%%
%%% Copyright (c) 2013 Rodolphe Quiédeville <rodolphe@quiedeville.org>
%%%
%%%     This program is free software: you can redistribute it and/or modify
%%%     it under the terms of the GNU General Public License as published by
%%%     the Free Software Foundation, either version 3 of the License, or
%%%     (at your option) any later version.
%%%
%%%     This program is distributed in the hope that it will be useful,
%%%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%%%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%%     GNU General Public License for more details.
%%%
%%%     You should have received a copy of the GNU General Public License
%%%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%%%
%%%  url to include in tsung config file
%%%
%%%  Randomize url in tile server form used by openstreetmap project
%%%
%%%   - urlzxy : return a single url
%%%
%%%  <request subst="true">
%%%    <http url='/%%wmsosm:urlzxy%%.png' version='1.1' method='GET'></http>
%%%  </request>
%%%
%%%
%%%
-module(wmsosm).
-export([urlzxy/1,get_urlblock/1]).


get_urlblock({Pid, DynVars})->
    [Z,X,Y] = zxy(),
    fillurls(0,[],Z,X,Y).
    
fillurls(N,List,Z,X,Y) when N =< 2->
    lists:merge(fillurls(N+1,List,Z,X,Y),arr_urlzxy(0,N,2,Z,X,Y));
fillurls(_,_,_,_,_)->
    [].

arr_urlzxy(L,N,B,Z,X,Y) when L =< B->
    A=[integer_to_list(Z),integer_to_list(X+L),integer_to_list(Y+N)],
    lists:merge(arr_urlzxy(L+1,N,B,Z,X,Y),[string:join(A,"/")]);
arr_urlzxy(_,_,_,_,_,_)->
    [].

urlzxy({Pid, DynVars})->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    %% Zoom level    
    Arr = fillall(),
    Key = random:uniform(171)-1,
    Zoomlevel = array:get(Key, array:from_list(Arr)),
    string:concat(zoomlevel(Zoomlevel), coord(Zoomlevel)).

zxy()->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    %% Zoom level    
    Arr = fillall(),
    Key = random:uniform(171)-1,
    Zoomlevel = array:get(Key, array:from_list(Arr)),
    [Zoomlevel,randxy(Zoomlevel),randxy(Zoomlevel)].

zoomlevel(N)->
    string:concat(integer_to_list(N), "/").

coord(N)->
    string:concat(coordx(N), coordy(N)).

coordx(N)->
    X = randxy(N),
    string:concat(integer_to_list(X), "/").

coordy(N)->
    Y = randxy(N),
    integer_to_list(Y).

randxy(N)->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    random:uniform(trunc(math:pow(2, N)))-1.

fillall()->
    fillall(1, []).

fillall(N, List) when N =< 18->
    lists:merge(fillall(N + 1, List),lists:seq(N, 18));
fillall(_, _)->
    [].
