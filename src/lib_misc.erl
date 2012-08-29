%% Author: Administrator
%% Created: 2012-8-29
%% Description: TODO: Add description to lib_misc
-module(lib_misc).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([consult/1, unconsult/2]).

%%
%% API Functions
%%
consult(File) ->
	case file:open(File, read) of
		{ok, S} ->
			Val = consult1(S),
			file:close(S),
			{ok, Val};
		{error, Why} ->
			{error, Why}
	end.

consult1(S) ->
	case io:read(S, '') of
		{ok, Term} -> [Term|consult1(S)];
		eof 	   -> [];
		Error      -> Error
	end.

%% 写入文件
unconsult(File, L) ->
	{ok, S} = file:open(File, write),
	lists:foreach(fun(X) -> io:format(S, "~p.~n", [X]) end, L),
	file:close(S).

unconsult2(File, L) ->
	{ok, S} = file:open(File, write),
	lists:foreach(fun(X) -> io:format(S, "~p.~n", [X]) end, L),
	file:close(S).



%%
%% Local Functions
%%

