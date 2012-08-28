%% Author: Administrator
%% Created: 2012-8-28
%% Description: TODO: Add description to area_server_final
-module(area_server_final).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([area/2, start/0]).

%%
%% API Functions
%%
start() ->
	spawn(fun loop/0).

area(Pid, What) ->
	rpc(Pid, What).

%%
%% Local Functions
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
			From ! {self(),Width * Height},
			loop();
		{From, {circle, R}} ->
			From ! {self(), 3.14159 * R * R},
			loop();
		{From, Other} ->
			From ! {self(), {error, Other}},
			loop()
	end.