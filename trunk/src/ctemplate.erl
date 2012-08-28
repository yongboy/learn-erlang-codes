%% Author: Administrator
%% Created: 2012-8-28
%% Description: 并发编程
-module(ctemplate).

%%
%% Include files
%%

%%
%% Exported Functions
%%
%%-export([]).
-compile(export_all).

%%
%% API Functions
%%
start() ->
	spawn(fun() -> loop([]) end).

rpc(Pid, Request) ->
	Pid ! {self(), Request},
	receive
		{Pid, Response} ->
			Response
	end.

loop(X) ->
	receive
		Any ->
			io:format("Received: ~p~n", [Any]),
			loop(X)
	end.


%%
%% Local Functions
%%

