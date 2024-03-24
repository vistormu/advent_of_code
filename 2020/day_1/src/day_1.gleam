import gleam/io
import gleam/string
import gleam/list
import gleam/int
import simplifile as file

fn unwrap(result: Result(t, _)) -> t {
    case result {
        Ok(result) -> result
        _ -> panic
    }
}

fn read_lines(file_path: String) -> List(String) {
    file_path
    |> file.read 
    |> unwrap
    |> string.trim
    |> string.split(on: "\n")
}

fn parse_list_to_ints(list: List(String)) -> List(Int) {
    list
    |> list.map(int.parse)
    |> list.map(unwrap)
}

fn part_1() {
    let _ = read_lines("src/input.txt")
    |> parse_list_to_ints
    |> list.combinations(by: 2)
    |> list.find(one_that: fn(list) { int.sum(list) == 2020 })
    |> unwrap
    |> int.product
    |> io.debug
}

fn part_2() {
    let _ = read_lines("src/input.txt")
    |> parse_list_to_ints
    |> list.combinations(by: 3)
    |> list.find(one_that: fn(list) { int.sum(list) == 2020 })
    |> unwrap
    |> int.product
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
