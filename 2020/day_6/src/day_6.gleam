import gleam/io
import gleam/string
import gleam/list
import gleam/set
import gleam/int
import simplifile as file

fn unwrap(result: Result(t, _)) -> t {
    case result {
        Ok(result) -> result
        Error(e) -> {
            io.debug(e)
            panic
        }
    }
}

fn read_lines(path: String) -> List(String) {
    path
    |> file.read
    |> unwrap
    |> string.trim
    |> string.split("\n\n")
}

fn part_1() {
    read_lines("src/input.txt")
    |> list.map(string.replace(_,"\n", ""))
    |> list.map(fn (line) {
        line
        |> string.to_graphemes
        |> set.from_list
        |> set.size
    })
    |> int.sum
    |> io.debug
}

fn get_intersection(group: String, initial: set.Set(String)) -> Int {
    group
    |> string.split("\n")
    |> list.map( fn(person) {
        person
        |> string.to_graphemes
        |> set.from_list
    })
    |> list.fold(initial, set.intersection)
    |> set.size
}

fn part_2() {
    let alphabet = "abcdefghijklmnopqrstuvwxyz"
    |> string.to_graphemes
    |> set.from_list

    read_lines("src/input.txt")
    |> list.map(get_intersection(_, alphabet))
    |> int.sum
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}