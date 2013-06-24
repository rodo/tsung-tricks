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
%%% Decode html entities
%%%
%%%
-module(htmlconv).
-export([html_to_uri/1,decode_entities/1]).

html_to_uri(Text)->
        http_uri:encode(repl(Text, [])).

decode_entities(Text)->
    repl(Text, []).

repl([],Acc) -> lists:reverse(Acc);
repl([$&,$a,$m,$p,$;|T],Acc) -> repl(T,[$&|Acc]);
repl([$&,$l,$t,$;|T],Acc) -> repl(T,[$<|Acc]);
repl([$&,$g,$t,$;|T],Acc) -> repl(T,[$>|Acc]);
repl([$&,$q,$u,$o,$t,$;|T],Acc) -> repl(T,[$"|Acc]);
repl([$&,$a,$p,$o,$s,$;|T],Acc) -> repl(T,[$'|Acc]);
repl([H|T],Acc) -> repl(T,[H|Acc]).
