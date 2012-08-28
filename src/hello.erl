%% Author: Administrator
%% Created: 2012-8-27
%% Description: TODO: Add description to hello
-module(hello).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([say/0,say/1]).

%%
%% API Functions
%%
say() ->
	io:format("Hello World !~n", []).

say(Name) ->
	io:format("Hello ~w~n",[Name]).


%%
%% Local Functions
%%

