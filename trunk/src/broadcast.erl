-module(broadcast).

-export([listen/0, send/0]).

send() ->
	%% windows 下使用IP地址即可
	case inet:ifget("localhost", [broadaddr]) of
		{ok, [{broadaddr, Ip}]} ->
			{ok, Socket} = gen_udp:open(5010, [{broadcast, true}]),
			Time = time(),			
			gen_udp:send(Socket, Ip, 6000, atom_to_binary(Time, "UTF-8")),
			gen_udp:close(Socket);
		_ ->
			io:format("Bad interface name, or\n"
					 "broadcasting not support\n")
	end.

listen() ->
	{ok, Socket} = gen_udp:open(6000),
	loop(Socket).

loop(Socket) ->
	receive
		Any ->
			io:format("received: ~p~n", [Any]),
			loop(Socket)
	end.