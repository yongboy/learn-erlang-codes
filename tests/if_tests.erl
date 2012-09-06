-module(if_tests).
-include_lib("eunit/include/eunit.hrl").

if_test() ->
	[
		?assertEqual(true, check_if(20)),
		?assertEqual(false, check_if(3)),
		?assertEqual(false, check_if(10))
	].

check_if(N) ->
	if
		N > 10 ->
			true;
		true ->
			false
	end.

