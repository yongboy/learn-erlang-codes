-module(fac_tests).
%-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-compile(export_all).

i_0_test() ->
	[
	 ?assertEqual(fac(3), 6),
	 ?assertEqual(fac(1), 1),
	 ?assertEqual(fac(2), 2)
	 ].


fac(N)
	when N > 1 -> 
			N * fac(N-1);
fac(1) ->
	1.