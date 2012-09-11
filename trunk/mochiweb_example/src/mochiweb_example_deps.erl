%% @author Mochi Media <dev@mochimedia.com>
%% @copyright 2010 Mochi Media <dev@mochimedia.com>

%% @doc Ensure that the relatively-installed dependencies are on the code
%%      loading path, and locate resources relative
%%      to this application's path.

-module(mochiweb_example_deps).
-author("Mochi Media <dev@mochimedia.com>").

-export([ensure/0, ensure/1]).
-export([get_base_dir/0, get_base_dir/1]).
-export([local_path/1, local_path/2]).
-export([deps_on_path/0, new_siblings/1]).

%% @spec deps_on_path() -> [ProjNameAndVers]
%% @doc List of project dependencies on the path.
deps_on_path() ->
    F = fun (X, Acc) ->
				%% filename:dirname 返回当前文件的上一级路径
				%% 返回文件X所在的目录，比如d:/mochiweb_example/ebin，注意最后面不带/
                ProjDir = filename:dirname(X),
				%% basename 返回文件名和后缀名，filename:basename("d:/mochiweb_example/ebin/mochiweb_example_deps.beam"). 则返回：
				%% mochiweb_example_deps.beam
				%% 若目录路径，则返回最后一个路径的名称,filename:basename("d:/mochiweb_example/ebin/").返回 ebin
                case {filename:basename(X),
                      filename:basename(filename:dirname(ProjDir))} of
                    {"ebin", "deps"} ->
                        [filename:basename(ProjDir) | Acc];
                    _ ->
                        Acc
                end
        end,
    ordsets:from_list(lists:foldl(F, [], code:get_path())).

%% @spec new_siblings(Module) -> [Dir]
%% @doc Find new siblings paths relative to Module that aren't already on the
%%      code path.
new_siblings(Module) ->
    Existing = deps_on_path(),
    SiblingEbin = filelib:wildcard(local_path(["deps", "*", "ebin"], Module)),
	io:format("SiblingEbin = ~p~n", [SiblingEbin]),
    Siblings = [filename:dirname(X) || X <- SiblingEbin,
                           ordsets:is_element(
                             filename:basename(filename:dirname(X)),
                             Existing) =:= false],
	%% filelib:is_dir 若目录不存在返回false, 若是文件，则返回false，真正存在的目录则返回true
	%% 经 lists:filter(fun filelib:is_dir/， *） 过滤之后，则返回符合要求的
	%% */deps/mochiweb/ebin
	%% */deps/mochiweb/include
	%% 目录
    lists:filter(fun filelib:is_dir/1,
                 lists:append([[filename:join([X, "ebin"]),
                                filename:join([X, "include"])] ||
                                  X <- Siblings])).

%% @spec ensure(Module) -> ok
%% @doc Ensure that all ebin and include paths for dependencies
%%      of the application for Module are on the code path.
ensure(Module) ->
    code:add_paths(new_siblings(Module)),
	%% Searches the entire code space for module names with identical names and writes a report to stdout.
    code:clash(),
    ok.

%% @spec ensure() -> ok
%% @doc Ensure that the ebin and include paths for dependencies of
%%      this application are on the code path. Equivalent to
%%      ensure(?Module).
ensure() ->
    ensure(?MODULE).

%% @spec get_base_dir(Module) -> string()
%% @doc Return the application directory for Module. It assumes Module is in
%%      a standard OTP layout application in the ebin or src directory.
get_base_dir(Module) ->
	%% Here 返回带有绝对路径的地址，比如 d:/mochiweb_example/ebin/mochiweb_example_deps.beam
    {file, Here} = code:is_loaded(Module),
	%% 直接定位到程序所在位置
	%% filename:dirname(filename:dirname("d:/mochiweb_example/ebin/mochiweb_example_deps.beam")). 
	%% 返回 d:/mochiweb_example
	%% filename:dirname("d:/mochiweb_example/ebin/mochiweb_example_deps.beam") 则返回
	%% d:/mochiweb_example/ebin
    filename:dirname(filename:dirname(Here)).

%% @spec get_base_dir() -> string()
%% @doc Return the application directory for this application. Equivalent to
%%      get_base_dir(?MODULE).
get_base_dir() ->
    get_base_dir(?MODULE).

%% @spec local_path([string()], Module) -> string()
%% @doc Return an application-relative directory from Module's application.
%% Components = ["deps","*","ebin"]
local_path(Components, Module) ->
    filename:join([get_base_dir(Module) | Components]).

%% @spec local_path(Components) -> string()
%% @doc Return an application-relative directory for this application.
%%      Equivalent to local_path(Components, ?MODULE).
local_path(Components) ->
    local_path(Components, ?MODULE).
