%% Author: Administrator
%% Created: 2012-9-3
%% Description: 原始服务器程序,虽小，但准确的体现了一个服务器程序的精髓
%% 服务器的基本模式
-module(server1).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([start/2, rpc/2]).

%%
%% API Functions
%%
start(Name, Mod) ->
	register(Name, spawn(fun() -> loop(Name, Mod, Mod:init()) end)).

rpc(Name, Request) ->
	Name ! {self(), Request},
	receive
		{Name, Response} ->
			Response
	end.

loop(Name, Mod, State) ->
	receive
		{From, Request} ->
			{Response, State1} = Mod:handle(Request, State),
			From ! {Name, Response},
			loop(Name, Mod, State1)
	end.

		

%%
%% Local Functions
%%

