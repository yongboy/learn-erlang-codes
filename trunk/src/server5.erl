%% Author: Administrator
%% Created: 2012-9-3
%% Description: TODO: Add description to server5
-module(server5).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([start/0, rpc/2]).

%%
%% API Functions
%%
start() ->
	spawn(fun() ->
				  wait() end).

rpc(Pid, Q) ->
	Pid ! {self(), Q},
	receive
		{Pid, Reply} ->
			Reply
	end.

%%
%% Local Functions
%%
wait() ->
	receive
		{become, F} ->
			F()
	end.