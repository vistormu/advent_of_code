-module(day_1).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch]).

-export([main/0]).

-spec unwrap({ok, AAO} | {error, any()}) -> AAO.
unwrap(Result) ->
    case Result of
        {ok, Result@1} ->
            Result@1;

        _ ->
            erlang:error(#{gleam_error => panic,
                    message => <<"panic expression evaluated"/utf8>>,
                    module => <<"day_1"/utf8>>,
                    function => <<"unwrap"/utf8>>,
                    line => 10})
    end.

-spec read_lines(binary()) -> list(binary()).
read_lines(File_path) ->
    _pipe = File_path,
    _pipe@1 = simplifile:read(_pipe),
    _pipe@2 = unwrap(_pipe@1),
    _pipe@3 = gleam@string:trim(_pipe@2),
    gleam@string:split(_pipe@3, <<"\n"/utf8>>).

-spec parse_list_to_ints(list(binary())) -> list(integer()).
parse_list_to_ints(List) ->
    _pipe = List,
    _pipe@1 = gleam@list:map(_pipe, fun gleam@int:parse/1),
    gleam@list:map(_pipe@1, fun unwrap/1).

-spec part_1() -> integer().
part_1() ->
    _ = begin
        _pipe = read_lines(<<"src/input.txt"/utf8>>),
        _pipe@1 = parse_list_to_ints(_pipe),
        _pipe@2 = gleam@list:combinations(_pipe@1, 2),
        _pipe@3 = gleam@list:find(
            _pipe@2,
            fun(List) -> gleam@int:sum(List) =:= 2020 end
        ),
        _pipe@4 = unwrap(_pipe@3),
        _pipe@5 = gleam@int:product(_pipe@4),
        gleam@io:debug(_pipe@5)
    end.

-spec part_2() -> integer().
part_2() ->
    _ = begin
        _pipe = read_lines(<<"src/input.txt"/utf8>>),
        _pipe@1 = parse_list_to_ints(_pipe),
        _pipe@2 = gleam@list:combinations(_pipe@1, 3),
        _pipe@3 = gleam@list:find(
            _pipe@2,
            fun(List) -> gleam@int:sum(List) =:= 2020 end
        ),
        _pipe@4 = unwrap(_pipe@3),
        _pipe@5 = gleam@int:product(_pipe@4),
        gleam@io:debug(_pipe@5)
    end.

-spec main() -> integer().
main() ->
    part_1(),
    part_2().
