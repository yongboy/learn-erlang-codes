-module(unicode_test).
-compile([export_all]).

%% 
%% the test.txt content:
%% [
%% {desc, "这是一个测试文件"},
%% {author, "litaocheng"}
%% ].
%%

test() ->
    test2(),
    test1().

%% read content from the file
test1() ->
    {ok, [Term]} = file:consult("test_out.txt"),
    Desc = proplists:get_value(desc, Term),
    _Author = proplists:get_value(author, Term),
    
    % out put the Desc and Author
    DescUniBin = iolist_to_binary(Desc),
    DescUniList = unicode:characters_to_list(DescUniBin),
    io:format("desc bin : ~ts~ndesc bin : ~p~n",[DescUniBin, DescUniBin]),
    io:format("desc list: ~ts~ndesc list: ~p~n", [DescUniList, DescUniList]).


%% save the binary in utf8 format
test2() ->
    [DescList] = io_lib:format("~ts", ["这是一个测试文件"]),
    DescBin = erlang:iolist_to_binary(DescList),
    DescList2 = unicode:characters_to_list(DescBin),
    List = lists:concat(["[{desc,\"", DescList2, "\"}, {author, \"litaocheng\"}]."]),
    Bin = unicode:characters_to_binary(List),
    io:format("bin is:~ts~n", [Bin]), 
    file:write_file("test_out.txt", Bin).