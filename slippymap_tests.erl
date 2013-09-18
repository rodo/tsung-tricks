%
% @doc OpenStreetMap slippy map tile numbers
%
% @author Rodolphe Quiedeville <rodolphe@quiedeville.org>
%   [http://rodolphe.quiedeville.org]
%
% @copyright 2013 Rodolphe Quiedeville
%
% @reference <a href="http://wiki.openstreetmap.org/wiki/Slippy_map_tilenames">http://wiki.openstreetmap.org/wiki/Slippy_map_tilenames</a>

-module(slippymap_tests).
-include_lib("eunit/include/eunit.hrl").

-compile(export_all).

test()-> ok.


num2deg_test()->
    ?assertEqual({-135.0,79.17133464081945}, slippymap:num2deg(4,4,5)).

num2deg2_test()->
    ?assertEqual({-180.0, 85.05112877980659}, slippymap:num2deg(0,0,5)).

