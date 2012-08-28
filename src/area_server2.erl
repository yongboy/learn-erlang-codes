%% Author: Administrator
%% Created: 2012-8-28
%% Description: TODO: Add description to area_server1
-module(area_server2).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([loop/0, rpc/2]).

%%
%% API Functions
%%
rpc(Pid, Request) ->
	Pid ! {self(), Request},
	receive
		{Pid, Response} ->
			Response
	end.

loop() ->
	receive
		{From, {rectangle, Width, Height}} ->
			From ! {self(), Width * Height},
			loop();
		{From, {circle, R}} ->
			From ! {self(), 3.14159 * R * R},
			loop();
		{From, Other} ->
			From ! {self(), {error, Other}},
			loop()
	end.

%%
%% Local Functions
%%

