%% Author: Administrator
%% Created: 2012-8-28
%% Description: TODO: Add description to fibo
-module(fibo).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([fibo/1]).

%%
%% API Functions
%%

fibo(N) when N > 1 ->
	fibo(N-1) + fibo(N-2);
fibo(1) ->
	1;
fibo(0) ->
	0.

%%
%% Local Functions
%%

