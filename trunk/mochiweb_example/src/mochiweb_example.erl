%% @author Mochi Media <dev@mochimedia.com>
%% @copyright 2010 Mochi Media <dev@mochimedia.com>

%% @doc mochiweb_example.

-module(mochiweb_example).
-author("Mochi Media <dev@mochimedia.com>").
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.


%% @spec start() -> ok
%% @doc Start the mochiweb_example server.
start() ->
    mochiweb_example_deps:ensure(),
    ensure_started(crypto),
    application:start(mochiweb_example).


%% @spec stop() -> ok
%% @doc Stop the mochiweb_example server.
stop() ->
    application:stop(mochiweb_example).
