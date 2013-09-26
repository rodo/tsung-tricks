%%% -*- coding: utf-8 -*-
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
-export([get_urlfrom/2]).
-export([move_next/1]).
-export([move/4]).
-author({author, "Rodolphe Quiédeville", "<rodolphe@quiedeville.org>"}).

-define(MAX_ZOOM_LEVEL, 18).
-define(SQUARE_SIZE, 3).

urlzxy({_Pid, _DynVars})->
    {N1,N2,N3} = now(),
    random:seed(N1,N2,N3),
    %% Zoom level    
    Arr = fillall(),
    Key = random:uniform(elmts(?MAX_ZOOM_LEVEL))-1,
    Zoomlevel = array:get(Key, array:from_list(Arr)),
    string:concat(zoomlevel(Zoomlevel), coord(Zoomlevel)).

%%% The square size is defined in dynvars or retrun default value
read_ssize(DynVars)->
    case ts_dynvars:lookup(square_size,DynVars) of
	{ok,Size} -> binary_to_number(Size);
	false -> ?SQUARE_SIZE
    end.
    
get_square_size(DynVars)->
    Min = 1,
    Max = 8,
    max(Min,min(read_ssize(DynVars), Max)).
	    

get_urlblock({_Pid, DynVars})->
    [Z,X,Y] = zxy(),
    Sq=get_square_size(DynVars),
    fillurls(0,[],Z,X,Y,Sq).

move_next({_, DynVars})->
    Sq=get_square_size(DynVars),
    {ok, [TopLeft|_]} = ts_dynvars:lookup(list_url, DynVars),
    random_move(TopLeft, Sq).

get_urlfrom(Size, [Z,X,Y])->
    fillurls(0,[],Z,X,Y,Size).

fillurls(N,List,Z,X,Y, Sq) when N < Sq->
    lists:merge(fillurls(N+1,List,Z,X,Y,Sq),arr_urlzxy(0,N,Sq,Z,X,Y));
fillurls(_,_,_,_,_,_)->
    [].

arr_urlzxy(L,N,B,Z,X,Y) when L < B->
    A=[integer_to_list(Z),integer_to_list(X+L),integer_to_list(Y+N)],
    lists:merge(arr_urlzxy(L+1,N,B,Z,X,Y),[string:join(A,"/")]);
arr_urlzxy(_,_,_,_,_,_)->
    [].

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

random_move(Urls, Sq)->
    case random:uniform(4) of
	1 -> move(Urls, Sq, 1, left);
	2 -> move(Urls, Sq, 1, bottom);
	3 -> move(Urls, Sq, 1, right);
	4 -> move(Urls, Sq, 1, top)
    end.

%% Move action are one of 4 :
%%
move(Url, Size, Value, left)->
    [Z, X, Y] = url_split(Url),
    get_urlfrom(Size, [Z, X - Value, Y]);
move(Url, Size, Value, bottom)->
    [Z, X, Y] = url_split(Url),
    get_urlfrom(Size, [Z, X, Y + Value]);
move(Url, Size, Value, right)->
    [Z, X, Y] = url_split(Url),
    get_urlfrom(Size, [Z, X + Value, Y]);
move(Url, Size, Value, top)->
    [Z, X, Y] = url_split(Url),
    get_urlfrom(Size, [Z, X, max(0, Y - Value)]).


%% BBOX is a binary
url_split(Url)->
    lists:map(fun(X) -> {Int, _} = string:to_integer(X),
			Int end,
	      string:tokens(Url, "/")).

%%----------------------------------------------------------------------
%% Function: fillall/0
%% Purpose: return an array filled with N element at index N
%% Returns: []
%%----------------------------------------------------------------------

fillall()->
    fillall(1, []).
fillall(N, List) when N =< ?MAX_ZOOM_LEVEL->
    lists:merge(fillall(N + 1, List),lists:seq(N, ?MAX_ZOOM_LEVEL));
fillall(_, _)->
    [].

elmts(N) when N >=1->
    elmts(N-1)+N;
elmts(_)->   
    0.

%% utilities
binary_to_number(B) when is_binary(B)->
    list_to_number(binary_to_list(B));
binary_to_number(B) when is_list(B)->
    list_to_number(B);
binary_to_number(B) ->
    B.

list_to_number(L) ->
    try list_to_float(L)
    catch
        error:badarg ->
	    list_to_integer(L)
    end.
