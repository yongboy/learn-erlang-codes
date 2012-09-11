%% Author: Administrator
%% Created: 2012-9-10
%% Description: TODO: Add description to comp_tests
-module(comp_tests).
-include_lib("eunit/include/eunit.hrl").

list_plus_test() ->
	Array = [1, 2, 3, 4, 5],
	?assertEqual(15, list_add(Array)).

list_plus_2_test() ->
	Array = [1, 2, 3, 4, 5],
	?assertEqual(15, list_add(Array)).

list_plus_3_test() ->
	Array = [1, 2, 3, 4, 5],
	?assertEqual(15, lists:foldl(fun(X, Sum) -> X + Sum end, 0, Array)).

list_add([H|T]) ->
	H + list_add(T);
list_add([]) ->
	0.


