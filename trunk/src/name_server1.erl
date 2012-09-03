%% Author: Administrator
%% Created: 2012-9-3
%% Description: server3的回调程序,做了两件事:
%% 定义了负责处理框架发过来的调用请求；其次定义了客户端调用的常规接口
%% 此处理方式，在OTP中是一种极为常见的做法
%% 测试程序：
%% server3:start(name_server, name_server).
%% name_server:add(joe, "at home").
%% name_server:whereis(joe).
-module(name_server1).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([init/0, add/2, whereis/1, handle/2]).
-import(server1, [rpc/2]).

%%
%% API Functions
%% 客户端接口
add(Name, Place) ->
	rpc(name_server, {add, Name, Place}).
whereis(Name) ->
	rpc(name_server, {whereis, Name}).

%% 回调函数
init() ->
	dict:new().

handle({add, Name, Place}, Dict) ->
	{ok, dict:store(Name, Place, Dict)};

handle({whereis, Name}, Dict) ->
	{dict:find(Name, Dict), Dict}.

%%
%% Local Functions
%%