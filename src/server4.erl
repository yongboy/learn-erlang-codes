%% Author: Administrator
%% Created: 2012-9-3
%% Description: 合并热代码升级和事务机制的两个分离的特性
-module(server4).

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
		{Name, crash} ->
			exit(rpc);
		{Name, ok, Response} ->
			Response
	end.

%%
%% Local Functions
%%
loop(Name, Mod, OldState) ->
	receive
		{From, {swap_code, NewCallbackMod}} ->
			From ! {Name, ok, ack},
			loop(Name, NewCallbackMod, OldState);
		{From, Request} ->
			try Mod:handle(Request, OldState) of
				{Response, NewState} ->
					From ! {Name, ok, Response},
					loop(Name, Mod, NewState)
			catch
				_:Why ->
					log_the_error(Name, Request, Why),
					From ! {Name, crash},
					loop(Name, Mod, OldState)
			end
	end.

log_the_error(Name, Request, Why) ->
	io:format("Server ~p request ~p ~n"
			 "caused exception ~p~n",
			 [Name, Request, Why]).