%% Author: Administrator
%% Created: 2012-8-28
%% Description: 函数式程序设计难免以递归计算，而消耗了大量递归堆栈空间。为了克服这个问题，一般使用累积参数与尾部递归等技巧节省递归数目,<br/>ErLang用下划线“_”表示任意变量。
-module(fiboplus).

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
fibo(N) ->
    fibo(N, 0, 1).
fibo(N, C1, C2) when N > 2 ->
    fibo(N-1, C2, C1+C2);
fibo(0, _, _) ->
    0;
fibo(1, _, _) ->
    1;
fibo(_, C1, C2) ->
    C1+C2.


%%
%% Local Functions
%%

