%% Author: Administrator
%% Created: 2012-9-5
%% Description: TODO: Add description to fact_test
-module(fact_test).
%% 判断系统是否支持EUNIT

%-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").

setup() ->
	io:format("Prepare before test ~p~n", [?MODULE]).


fact_test() ->
	?assertEqual(fact:fact(1), 1).


fact_2_test() ->
	?assertEqual(fact:fact(2), 2).

fact_3_test() ->
	?assertEqual(fact:fact(3), 6).

fact_4_test() ->
	?assertEqual(fact:fact(4), 24).

fact_5_test() ->
	?assert(fact:fact(1) == 1).


fact_6_test() ->
	?assertNot(fact:fact(2) == 1).

%%fact_7_test() ->
%%	?assertMatch(fact:fact(3), any()).

fact_8_test() ->
	[?assertEqual(fact:fact(1), 1), ?assertEqual(fact:fact(2), 2), ?assertEqual(fact:fact(3), 6)].

fact_9_test() ->
	?assertNot(fact:fact(2) == 1).

fact_10_test() ->
	io:format("fact_10_test() for test now~n"),
	{setup, fun setup/0,	 
	?assertEqual(fact:fact(2), 2)
	 }.
	
%-endif.