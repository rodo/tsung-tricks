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
-module(wmsosm_tests).
-include_lib("eunit/include/eunit.hrl").
-author({author, "Rodolphe Quiédeville", "<rodolphe@quiedeville.org>"}).


zoomlevel_test()->
    ?assertEqual("3/",wmsosm:zoomlevel(3)).

elmts_test() ->    
    ?assertEqual(171, wmsosm:elmts(18)).

fillall_test()->
    ?assertEqual([16,17,17,18,18,18],wmsosm:fillall(16,[])).

get_square_size_test()->   
    ?assertEqual(4, wmsosm:get_square_size(ts_dynvars:new([square_size], [<<"4">>]) )).

get_square_size_min_test()->   
    ?assertEqual(1, wmsosm:get_square_size(ts_dynvars:new([square_size], [<<"0">>]) )).

get_square_size_max_test()->   
    ?assertEqual(8, wmsosm:get_square_size(ts_dynvars:new([square_size], [<<"42">>]) )).

get_square_size_list_test()->   
    ?assertEqual(8, wmsosm:get_square_size(ts_dynvars:new([square_size], ["8"]) )).

get_square_size_int_test()->   
    ?assertEqual(8, wmsosm:get_square_size(ts_dynvars:new([square_size], [8]) )).

read_ssize_exists_test()->
    %% The size is defined
    ?assertEqual(8, wmsosm:read_ssize(ts_dynvars:new([square_size], [<<"8">>]))).

read_ssize_notexists_test()->
    %% The size is defined
    ?assertEqual(3, wmsosm:read_ssize(ts_dynvars:new([foobar], [<<"8">>]))).

get_urlblock_test()->
    %% The size is defined
    Urls = wmsosm:get_urlblock({42,ts_dynvars:new([square_size], [<<"4">>])}),
    ?assertEqual(16, length(Urls)).

get_urlblock_empty_test()->
    %% The size is not defined
    Urls = wmsosm:get_urlblock({42,ts_dynvars:new()}),
    ?assertEqual(9, length(Urls)).

zxy_test()->
    ?assertEqual(3, length(wmsosm:zxy())).

url_split_test()->
    ?assertEqual([12, 1242, 3345], wmsosm:url_split("12/1242/3345")).

move_next_test()->
    ?assertEqual(4, 
		 length(wmsosm:move_next({4,ts_dynvars:new([square_size,list_url],
								  [2,["14/9/7"]
								  ])
					 }))
		).

random_action1_test()->
    ?assertEqual(move,  wmsosm:random_action(3)).

random_action2_test()->
    ?assertEqual(zoom,  wmsosm:random_action(53)).

random_move1_test()->
    Actions = [{top, 1}, {bottom,2}, {left,3}, {right,4}],
    ?assertNot(false =:= lists:keyfind(wmsosm:random_move(), 1, Actions )).

binary_to_number_test()->    
    ?assertEqual(5.6, wmsosm:binary_to_number(<<"5.6">>)).

list_to_number_test()->    
    ?assertEqual(5.6, wmsosm:list_to_number("5.6")).

list_to_number_int_test()->    
    ?assertEqual(5, wmsosm:list_to_number("5")).

list_to_number_int2_test()->    
    ?assertEqual(-15, wmsosm:list_to_number("-15")).

%% up to one zoom level
zoom_move_more_test()->
    ?assertEqual(["13/144/81"], wmsosm:zoom_move("12/12/9", 1, more)).

%% stay on the same zoom level, limit max reached

zoom_move_less_test()->
    ?assertEqual(["11/1242/3345"], wmsosm:zoom_move("12/1242/3345", 1, less)).

new_zoom_more_test()->
    ?assertEqual(4, wmsosm:new_zoom(3, more)).

new_zoom_less_test()->
    ?assertEqual(4, wmsosm:new_zoom(5, less)).

new_zoom_more_limit_test()->
    ?assert(18 > wmsosm:new_zoom(18, more) ).
%%
%%
%%
last_block_defined_test()->   
    ?assertEqual(["8/9/10"], wmsosm:last_block(ts_dynvars:new([list_url], [["8/9/10"]]) )).

last_block_undefined_test()->
    ?assertEqual(9, length(wmsosm:last_block(ts_dynvars:new() ))).
%%
%%
%%
move_first_test()->
    ?assertEqual(9, length(wmsosm:move_first({4, ts_dynvars:new()} ) )).

move_first_defined_test()->
    Assert = ["2/1/1","2/1/2","2/1/3","2/2/1","2/2/2","2/2/3","2/3/1", "2/3/2","2/3/3"],
    ?assertEqual(Assert, wmsosm:move_first({4, ts_dynvars:new([first_url],["2/1/1"])} )).
%%
%%
%%
coord_zoom_up_test()->
    ?assertEqual(16, wmsosm:coord_zoom(4, 10, 11 )).

coord_zoom_2up_test()->
    ?assertEqual(64, wmsosm:coord_zoom(4, 10, 12 )).
