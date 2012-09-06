%% Author: Administrator
%% Created: 2012-8-27
%% Descption: 费波纳数列求值 
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

%%-spec(fact(integer) -> integer()).
-spec(fact(N::integer) -> integer()).
fact(N) when N > 1 ->
	N * fact(N-1);
fact(1) ->
	1.


%%
%% Local Functions
%%

