%% @author Mochi Media <dev@mochimedia.com>
%% @copyright mochiweb_example Mochi Media <dev@mochimedia.com>

%% @doc Callbacks for the mochiweb_example application.

-module(mochiweb_example_app).
-author("Mochi Media <dev@mochimedia.com>").

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for mochiweb_example.
start(_Type, _StartArgs) ->
    mochiweb_example_deps:ensure(),
    mochiweb_example_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for mochiweb_example.
stop(_State) ->
    ok.
