%% Author: Administrator
%% Created: 2012-8-28
%% Description: TODO: Add description to area_server1
-module(area_server1).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([rpc/2, loop/0]).

%%
%% API Functions
%%
rpc(Pid, Request) ->
	Pid ! {self(), Request},
	receive
		Response ->
			Response
	end.

loop() ->
	receive
		{From, {rectangle, Width, Height}} ->
			From ! Width * Height,
			loop();
		{From, {circle, R}} ->
			From ! 3.14159 * R * R,
			loop();
		{From, Other} ->
			From ! {error, Other},
			loop()
	end.

%%
%% Local Functions
%%

