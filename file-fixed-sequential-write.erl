#!/usr/bin/env escript

-module('file-fixed-sequential-write').
-compile([export_all]).

filesize(F) -> {ok,{file_info,S,_,_,_,_,_,_,_,_,_,_,_,_}}
               =file:read_file_info(lists:concat(F)), S.

total() -> 30*1024*1024*1024.
chunk() -> 8*1024*1024.

main([]) -> main(["bench.bin"]);
main(Any) ->
    io:format("~p~n",[total()]),
    Binary = binary:copy(<<"Q">>,chunk()),
    {ok, Server} = file:open(lists:concat(Any),[raw,binary,append]),
    {Time,_} = timer:tc(fun() -> [file:write(Server,Binary)
                                 ||_<-lists:seq(1,total() div chunk())],ok end),
    io:format("Performance: ~p MB/s~n", [trunc(filesize(Any)/Time)]).
