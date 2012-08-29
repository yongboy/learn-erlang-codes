%% Author: Administrator
%% Created: 2012-8-29
%% Description: erl示范代码：
%% B = socket_examples:nano_get_url("www.erlang.org"),
%% L = scavenge_urls:bin2urls(B),
%% scavenge_urls:urls2htmlFile(L, "gathered.html").

-module(scavenge_urls).

%%
%% Include files
%%

%%
%% Exported Functions
%%
-export([bin2urls/1, urls2htmlFile/2]).
-import(lists, [reverse/1, reverse/2, map/2]).

%%
%% API Functions
%%
urls2htmlFile(Urls, File) ->
	file:write_file(File, urls2html(Urls)).

bin2urls(Bin) ->
	gather_urls(binary_to_list(Bin), []).

%%
%% Local Functions
%%
urls2html(Urls) ->
	[h1("Urls"), make_list(Urls)].

h1(Title) ->
	["<h1>", Title, "</h1>\n"].

make_list(L) ->
	["<ul>\n",
	 map(fun(I) ->
				 ["<li>", I, "</li>\n"] end, L),
	 "</ul>\n"].

gather_urls("<a href" ++ T, L)  ->
	{Url, T1} = collect_url_body(T, reverse("<a href")),
	gather_urls(T1, [Url|L]);
gather_urls([_|T], L) 			-> gather_urls(T, L);
gather_urls([], L) 				-> L.

collect_url_body("</a>" ++ T, L) -> {reverse(L, "</a>"), T};
collect_url_body([H|T], L) 		 -> collect_url_body(T, [H|L]);
collect_url_body([], _) 		 -> {[], []}.