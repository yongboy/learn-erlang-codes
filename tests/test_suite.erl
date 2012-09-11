%% Author: Administrator
%% Created: 2012-9-10
%% Description: TODO: Add description to test_suite
-module(test_suite).
-include_lib("eunit/include/eunit.hrl").

all_test_() ->
	[{module, if_tests},
	 {module, comp_tests}].



%%
%% Local Functions
%%

