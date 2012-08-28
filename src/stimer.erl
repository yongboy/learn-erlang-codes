%% Author: Administrator
%% Created: 2012-8-28
%% Description: TODO: Add description to stimer
-module(stimer).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([cancel/1, start/2]).

%%
%% API Functions
%%
start(Time, Fun) ->
	spawn(fun() ->timer(Time, Fun) end).

cancel(Pid) ->
	Pid ! cancel.

%%
%% Local Functions
%%
timer(Time, Fun) ->
	receive
		cancel ->
			void
	after Time ->
			Fun()
	end.
