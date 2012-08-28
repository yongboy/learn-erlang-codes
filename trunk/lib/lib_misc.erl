%% Author: Administrator
%% Created: 2012-8-28
%% Description: TODO: Add description to lib_misc
-module(lib_misc).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([]).

%%
%% API Functions
%%



%%
%% Local Functions
%%
%% 存活进程，若消失，自动重启
keep_alive(Name, Fun)->
	register(Name, Pid = spawn(Fun)),
	on_exit(Pid, fun(_Why) -> keep_alive(Name, Fun) end).

