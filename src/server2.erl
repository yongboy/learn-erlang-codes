%% Author: Administrator
%% Created: 2012-9-3
%% Description: 支持事务的服务器程序,在请求出现异常时，会让客户端代码异常退出
%% 
-module(server2).

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
		{From, Request} ->
			try Mod:handle(Request, OldState) of
				{Response, NewState} ->
					From ! {Name, ok, Response},
					loop(Name, Mod, NewState)
			catch
				_:Why ->
					log_the_error(Name, Request, Why),
					%%
					From ! {Name, crash},
					loop(Name, Mod, OldState)
			end
	end.

log_the_error(Name, Request, Why) ->
	io:format("Server ~p request ~p ~n"
			 "caused exception ~p~n",
			 [Name, Request, Why]).