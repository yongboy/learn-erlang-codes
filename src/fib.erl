%% Author: Administrator
%% Created: 2012-8-26
%% Description: TODO: Add description to fib
-module(fib).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([fibo/1, compute/1]).

%%
%% API Functions
%%

compute(N) ->
	Num = fibo(N),
	io:format("Compute Result(~w): ~w!", [N, Num]).

fibo(0) ->
	0;	
fibo(1) ->
	1;
fibo(N)	when N>0 -> fibo(N-1) + fibo(N-2).


%%
%% Local Functions
%%

