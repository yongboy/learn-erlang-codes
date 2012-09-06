%% Author: Administrator
%% Created: 2012-9-6
%% Description: TODO: Add description to udp_test
-module(udp_test).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([client/1, start_server/0]).

%%
%% API Functions
%%
start_server() ->
	spawn(fun() -> server(4000) end).

client(N) ->
	{ok, Socket} = gen_udp:open(0, [binary]),
	io:format("client opened socket=~p~n", [Socket]),
	ok = gen_udp:send(Socket, "localhost", 4000, term_to_binary(N)),
	
	Value = receive
				{udp, Socket, _, _, Bin} = Msg ->
					io:format("client received:~p~n", [Msg]),
					binary_to_term(Bin)
			after 2000 ->
					0
			end,
	gen_udp:close(Socket),
	Value.

server(Port) ->
	{ok, Socket} = gen_udp:open(Port, [binary]),
	io:format("server opened socket:~p~n", [Socket]),
	loop(Socket).

loop(Socket) ->
	receive
		{udp, Socket, Host, Port, Bin} = Msg ->
			io:format("server received:~p~n", [Msg]),
			N = binary_to_term(Bin),
			io:format("binary to term : ~p~n", [N]),
			Fac = fac(N),
			io:format("compute result ~p~n", [Fac]),
			gen_udp:send(Socket, Host, Port, term_to_binary(Fac)),
			loop(Socket)
	end.

fac(N) 
  when N > 1 ->
	N * fac(N - 1);
fac(1) ->
	1;
fac(0) ->
	1.
%%
%% Local Functions
%%

