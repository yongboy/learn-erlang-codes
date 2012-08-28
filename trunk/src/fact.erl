%% Author: Administrator
%% Created: 2012-8-27
-module(fact).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([fact/1]).

%%
%% API Functions
%%

fact(N) when N > 1 ->	
	N * fact(N-1);
fact(1) ->
	1.


%%
%% Local Functions
%%

