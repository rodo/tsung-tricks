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
%%%
%%%
%%%
-module(geoserver).
-include_lib("eunit/include/eunit.hrl").
-export([urlwms/1,defaults/0]).
-author({author, "Rodolphe Quiédeville", "<rodolphe@quiedeville.org>"}).

%%%
%%% Define here your defaults values
%%%

-define(STYLES, "").
-define(TILESORIGIN, "").
-define(LAYERS, "").
-define(BBOX, "").
-define(SERVICE, "WMS").
-define(VERSION, "1.1.1").
-define(REQUEST, "GetMap").
-define(FORMAT, "image/png").
-define(TILED, "true").
-define(TRANSPARENT, "true").
-define(WIDTH, "256").
-define(HEIGHT, "256").
-define(SRS, "EPSG:900913").

%%% http://c.tile.cartosm.eu/geoserver/wms?
%%% LAYERS=DataGouv%3Arpg2010
%%% TILESORIGIN=-20037508.34%2C-20037508.34
%%% BBOX=288626.21876465,6525887.7259668,293518.18857422,6530779.6957764
%%% STYLES=
%%% TRANSPARENT=true
%%% FORMAT=image%2Fpng
%%% TILED=true
%%% SERVICE=WMS
%%% VERSION=1.1.1
%%% REQUEST=GetMap
%%% SRS=EPSG%3A900913
%%% WIDTH=256
%%% HEIGHT=256

-define(DEFAULTS, ts_dynvars:new(
		    [styles, service, version, request, format, tiled, height, width, transparent, srs],
		    [?STYLES, ?SERVICE, ?VERSION, ?REQUEST, ?FORMAT, ?TILED, ?HEIGHT, ?WIDTH, ?TRANSPARENT, ?SRS])).

defaults()->
    ?DEFAULTS.

urlwms({_Pid, DynVars})->
    string:strip(buildurl(DynVars, ["FORMAT", "STYLES", "SERVICE", 
		       "VERSION", "REQUEST", "TILED", 
		       "WIDTH", "HEIGHT", "TRANSPARENT",
		       "SRS"]), right, $&).

buildurl(DynVars, [H|T])->
    options(H, DynVars)++"&"++buildurl(DynVars,T);
buildurl(_, []) ->
    "".

options(Option, DynVars)->
    case ts_dynvars:lookup(list_to_atom(string:to_lower(Option)),DynVars) of
	{ok,Rand}->
	    Option ++ "=" ++ http_uri:encode(binary_to_list(Rand));
	false ->
	    options(Option)
    end.

options(Option)->
    case ts_dynvars:lookup(list_to_atom(string:to_lower(Option)),?DEFAULTS) of
	{ok,Value} -> Option ++ "=" ++ http_uri:encode(Value);
	false -> "Error"
    end.


%% Units tests
%% options/1
options_test() ->    
    ?assertEqual("WIDTH=256", options("WIDTH")).

options2_test() ->    
    ?assertEqual("HEIGHT=256", options("HEIGHT")).

options4_test() ->    
    ?assert(is_list(options("HEIGHT")) =:= true).

%% options/2
options3_test() ->    
    ?assertEqual("HEIGHT=44", options("HEIGHT", ts_dynvars:new([height,width], [<<"44">>,<<"42">>]))).

%% buildurl/2
buildurl_test() ->    
    ?assertEqual("HEIGHT=44&WIDTH=42&", buildurl(ts_dynvars:new([height,width], [<<"44">>,<<"42">>]),["HEIGHT","WIDTH"])).

%% urlwms/1
urlwms_test()->
    Assert="FORMAT=image%2Fpng&STYLES=&SERVICE=WMS&VERSION=1.1.1&REQUEST=GetMap&TILED=true&WIDTH=256&HEIGHT=256&TRANSPARENT=true&SRS=EPSG%3A900913",
    ?assertEqual(Assert,urlwms({2,ts_dynvars:new([foo], [<<"42">>])})).
