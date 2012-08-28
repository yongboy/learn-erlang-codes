%% Author: Administrator
%% Created: 2012-8-28
%% Description: TODO: Add description to clock
-module(clock).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([stop/0, start/2]).

%%
%% API Functions
%%
start(Time, Fun) ->
	register(clock, spawn(fun() -> tick(Time, Fun) end)).

stop() ->
	clock ! stop.

tick(Time, Fun) ->
	receive
		stop -> void
	after Time ->
			Fun(),
			tick(Time, Fun)
	end.


%%
%% Local Functions
%%

