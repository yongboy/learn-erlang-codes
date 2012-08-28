%% Author: Administrator
%% Created: 2012-8-28
%% Description: TODO: Add description to kvs
-module(kvs).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([lookup/1, store/2, start/0]).

%%
%% API Functions
%%
start() ->
	register(kvs, spawn(fun() -> loop() end)).

store(Key, Value) ->
	rpc({store, Key, Value}).

lookup(Key) ->
	rpc({lookup, Key}).

%%
%% Local Functions
%%
rpc(Q) ->
	kvs ! {self(), Q},
	receive
		{kvs, Reply} ->
			Reply
	end.

loop() ->
	receive
		{From, {store, Key, Value}} ->
			put(Key, Value),
			From ! {kvs, true},
			loop();
		{From, {lookup, Key}} ->
			From ! {kvs, get(Key)},
			loop()
	end.
