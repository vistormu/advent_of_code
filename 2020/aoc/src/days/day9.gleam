import gleam/io
import gleamx/iox
import gleam/string
import gleamx/resultx.{panic_unwrap}
import gleam/list
import gleam/int

fn read_lines(file_path: String) -> List(String) {
    file_path
    |> iox.read_file
    |> panic_unwrap
    |> string.trim
    |> string.split("\n")
}

fn find_number(lines: List(Int)) -> Int {
    let number = lines
    |> list.at(25)
    |> panic_unwrap

    let pair = lines
    |> list.take(25)
    |> list.combination_pairs
    |> list.find( fn(pair) { number == pair.0 + pair.1 })

    case pair {
        Ok(_) -> find_number(list.drop(lines, 1))
        Error(_) -> number
    }
}

fn sum_numbers(lines: List(Int)) -> Int {
    let target = find_number(lines)

    sum_numbers_loop(lines, 1, target)
}

fn sum_numbers_loop(lines: List(Int), up_to: Int, target: Int) -> Int {
    let subset = lines
    |> list.take(up_to)

    case int.sum(subset) {
        sum if sum == target -> {
            let min = subset |> list.reduce(int.min) |> panic_unwrap
            let max = subset |> list.reduce(int.max) |> panic_unwrap

            min + max
        }
        sum if sum < target -> sum_numbers_loop(lines, up_to + 1, target)
        _ -> sum_numbers_loop(list.drop(lines, 1), 1, target)
    } 
}

fn part_1() {
    read_lines("data/day_9_input.txt")
    |> list.map(int.parse)
    |> list.map(panic_unwrap)
    |> find_number
    |> io.debug
}

fn part_2() {
    read_lines("data/day_9_input.txt")
    |> list.map(int.parse)
    |> list.map(panic_unwrap)
    |> sum_numbers
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
