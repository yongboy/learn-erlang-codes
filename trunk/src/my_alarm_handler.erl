%%% -------------------------------------------------------------------
%%% Author  : Administrator
%%% Description : 1. 
%%%	1. alarm_handler : set_alarm(tooHot).
%%% 2. gen_event : swap_handler(alarm_handler, {alarm_handler, swap}, {my_alarm_handler, xyz}). %% 自定义警报处理
%%% 3. alarm_handler : set_alarm(tooHot).
%%% 4. alarm_handler : clear_alarm(tooHot).
%%% Created : 2012-9-4
%%% -------------------------------------------------------------------
-module(my_alarm_handler).

-behaviour(gen_event).
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% External exports
-export([]).

%% gen_event callbacks
-export([init/1, handle_event/2, handle_call/2, handle_info/2, terminate/2, code_change/3]).

%% -record(state, {}).

%% ====================================================================
%% External functions
%% ====================================================================

%% ====================================================================
%% Server functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Func: init/1
%% Returns: {ok, State}          |
%%          Other
%% --------------------------------------------------------------------
init(Args) ->
    io:format("*** my_alarm_handler init:~p~n", [Args]),
	{ok, 0}.

%% --------------------------------------------------------------------
%% Func: handle_event/2
%% Returns: {ok, State}                                |
%%          {swap_handler, Args1, State1, Mod2, Args2} |
%%          remove_handler
%% --------------------------------------------------------------------
handle_event({set_alarm, tooHot}, N) ->
	error_logger:error_msg("*** Tell the Engineer to turn on the fan~n"),	
    {ok, N + 1};
handle_event({clear_alarm, tooHot}, N) ->
	error_logger:error_msg("*** Danger over. Turn off the fan~n"),	
    {ok, N};
handle_event(Event, N) ->
	io:format("*** unmatched event:~p~n", [Event]),
	{ok, N}.

%% --------------------------------------------------------------------
%% Func: handle_call/2
%% Returns: {ok, Reply, State}                                |
%%          {swap_handler, Reply, Args1, State1, Mod2, Args2} |
%%          {remove_handler, Reply}
%% --------------------------------------------------------------------
handle_call(Request, N) ->
    {ok, N, N}.

%% --------------------------------------------------------------------
%% Func: handle_info/2
%% Returns: {ok, State}                                |
%%          {swap_handler, Args1, State1, Mod2, Args2} |
%%          remove_handler
%% --------------------------------------------------------------------
handle_info(Info, N) ->
    {ok, N}.

%% --------------------------------------------------------------------
%% Func: terminate/2
%% Purpose: Shutdown the server
%% Returns: any
%% --------------------------------------------------------------------
terminate(Reason, State) ->
    ok.

%% --------------------------------------------------------------------
%% Func: code_change/3
%% Purpose: Convert process state when code is changed
%% Returns: {ok, NewState}
%% --------------------------------------------------------------------
code_change(OldVsn, State, Extra) ->
    {ok, State}.

%% --------------------------------------------------------------------
%%% Internal functions
%% --------------------------------------------------------------------

