%% Author: Administrator
%% Created: 2012-8-26
%% Description: TODO: Add description to helloworld
-module(helloworld).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([run/1]).

%%
%% API Functions
%%

run(Name)->
	hello:say(),
	io:format("Hello World ~w~n",[Name]).

%%
%% Local Functions
%%

