%% Author: Administrator
%% Created: 2012-8-31
%% Description: TODO: Add description to fn
-module(fn).

%%-export([]).
-compile(export_all).

doubleAll([]) ->
	[];
doubleAll([X|Y]) ->
	[X*2|doubleAll(Y)].

foreach(F, []) ->
	ok;
foreach(F, [X|Y]) ->
	F(X),
	foreach(F, Y).

checkNum(X) ->
	if X < 0 -> false;
	   X >= 0 -> true
	end.


reducelist(X) ->
	if X < 0 ->
		   0;
	   X >= 0 -> fun(X) -> [X | reducelist(X - 1)] end
	end.


			
		   