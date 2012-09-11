%% Author: Administrator
%% Created: 2012-9-11
%% Description: TODO: Add description to some_tests
-module(some_tests).
-compile(export_all).

s_test() ->
	"/" ++ Path = "hello/boy",
	%% ?
	io:format("Path : ~p~n", [Path]).
