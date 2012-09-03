%% Author: Administrator
%% Created: 2012-9-3
%% Description: 用于热替换的测试代码
%% server3:swap_code(name_server, new_name_server).
%% 使用新的替换函数 :
%% new_name_server:all_names().
-module(new_name_server).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([init/0, add/2, all_names/0, delete/1, whereis/1, handle/2]).
-import(server3, [rpc/2]).
%%
%% API Functions
%%
%% 
%% 接口
all_names() ->
	rpc(name_server, allNames).
add(Name, Place) ->
	rpc(name_server, {add, Name, Place}).
delete(Name) ->
	rpc(name_server, {delete, Name}).
whereis(Name) ->
	rpc(name_server, {whereis, Name}).

%% 回调函数
init() ->
	dict:new().

handle({add, Name, Place}, Dict) ->
	{ok, dict:store(Name, Place, Dict)};
handle(allNames, Dict) ->
	{dict:fetch_keys(Dict), Dict};
handle({delete, Name}, Dict) ->
	{ok, dict:erase(Name, Dict)};
handle({whereis, Name}, Dict) ->
	{dict:find(Name, Dict), Dict}.


%% 
%%
%% Local Functions
%%

