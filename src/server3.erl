%% Author: Administrator
%% Created: 2012-9-3
%% Description: 支持热代码替换的服务器程序
-module(server3).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([start/2, rpc/2, swap_code/2]).

%%
%% API Functions
%%
start(Name, Mod) ->
	register(Name, spawn(fun() ->
								 loop(Name, Mod, Mod:init()) end)).

swap_code(Name, Mod) ->
	rpc(Name, {swap_code, Mod}).

rpc(Name, Request) ->
	Name ! {self(), Request},
	receive
		{Name, Response} ->
			Response
	end.

%%
%% Local Functions
%%
loop(Name, Mod, OldState) ->
	receive
		{From, {swap_code, NewCallBackMod}} ->
			From ! {Name, ack},
			loop(Name, NewCallBackMod, OldState);
		{From, Request} ->
			{Response, NewState} = Mod:handle(Request, OldState),
			From ! {Name, Response},
			loop(Name, Mod, NewState)
	end.

			


