import gleam/io
import gleamx/iox
import gleam/string
import gleam/list
import gleam/int
import gleamx/resultx.{panic_unwrap}

fn part_1() {
    "data/day_1_input.txt"
    |> iox.read_file |> panic_unwrap
    |> string.trim
    |> string.split(on: "\n")
    |> list.map(int.parse) |> list.map(panic_unwrap)
    |> list.combinations(by: 2)
    |> list.find(one_that: fn(list) { int.sum(list) == 2020 }) |> panic_unwrap
    |> int.product
    |> io.debug
}

fn part_2() {
    "data/day_1_input.txt"
    |> iox.read_file |> panic_unwrap
    |> string.trim
    |> string.split(on: "\n")
    |> list.map(int.parse) |> list.map(panic_unwrap)
    |> list.combinations(by: 3)
    |> list.find(one_that: fn(list) { int.sum(list) == 2020 }) |> panic_unwrap
    |> int.product
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
