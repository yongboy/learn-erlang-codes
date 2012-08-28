%% Author: Administrator
%% Created: 2012-8-28
%% Description: 创建进程 Pid = spawn(fun area_server0:loop/0)\n然后发送数据Pid ! {rectangle, 30, 33}.
-module(area_server0).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([loop/0]).

%%
%% API Functions
%%
loop() ->
	receive
		{rectangle, Width, Height} ->
			io:format("Area Of rectangle is ~p~n", [Width * Height]),
			loop();
		{circle, R} ->
			io:format("Area of circle is ~p~n", [3.14159 * R * R]),
			loop();
		Other ->
			io:format("I don't know what the area of a ~p is ~n", [Other]),
			loop()
	end.

%%
%% Local Functions
%%

