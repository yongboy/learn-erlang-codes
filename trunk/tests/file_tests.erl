-module(file_tests).
-compile(export_all).

wf() ->
	File = "d:/test/hello.txt",
	filelib:ensure_dir(File),	
	{ok, IoDevice} = file:open(File, [append]),
	file:write(IoDevice, "This is the new line!\n"),
	file:close(IoDevice),
	io:format("write file done !~n",[]).
wf2() ->
	File = "d:/test/hello2.txt",
	{ok, IoDevice} = file:open(File, [append]),
	file:write(IoDevice, "This is the new line!\n"),
	file:close(IoDevice),
	io:format("write file done !~n",[]).
wf3() ->
	File = "d:/test/hello3.txt",
	{ok, IoDevice} = file:open(File, [append]),
	file:write(IoDevice, "这里是中文哈!\n"),
	file:close(IoDevice),
	io:format("write file done !~n",[]).

rf() ->
	File = "d:/test/hello.txt",
	{ok, IoDevice} = file:open(File, [read]),
	{ok, Data} = file:read(IoDevice, 100),
	io:format("file content : ~p~n", [Data]).

rf3() ->
	io:format("test1 : 中文~n"),
	io:format("test2 : ~ts~n", [xmerl_ucs:from_utf8("您好")]),
	File = "d:/test/hello3.txt",
	{ok, IoDevice} = file:open(File, [read]),
	{ok, Data} = file:read(IoDevice, 100),
	io:format("file content : ~ts~n", [xmerl_ucs:from_utf8(Data)]).
