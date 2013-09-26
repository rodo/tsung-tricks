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
    ?assertEqual(4, wmsosm:get_square_size(ts_dynvars:new([square_size], [<<"4">>]), 1, 8)).

get_square_size_min_test()->   
    ?assertEqual(4, wmsosm:get_square_size(ts_dynvars:new([square_size], [<<"0">>]), 4, 8)).

get_square_size_max_test()->   
    ?assertEqual(8, wmsosm:get_square_size(ts_dynvars:new([square_size], [<<"42">>]), 1, 8)).
