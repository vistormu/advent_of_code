import gleam/io
import gleamx/iox
import gleamx/resultx.{panic_unwrap}
import gleam/int
import gleam/list
import gleamx/listx
import gleam/iterator as iter
import gleam/dict
import gleam/result


fn prepare_list(adapters: List(String)) -> List(Int) {
    let new_list = adapters
    |> list.map(int.parse)
    |> list.map(panic_unwrap)
    |> list.sort(int.compare)
    |> list.prepend(0)

    new_list |> list.append([panic_unwrap(list.last(new_list)) + 3])
}

fn compute_differences(adapters: List(Int)) -> Int {
    let len = list.length(adapters) - 1
    let differences = iter.range(1, len)
    |> iter.map(fn(i) {
        let first = listx.at_(adapters, i-1)
        let second = listx.at_(adapters, i)

        second - first
    })
    |> iter.to_list
    
    let ones = differences |> listx.count(fn(x) { x == 1 })
    let threes = differences |> listx.count(fn(x) { x == 3 })

    ones * threes
}

fn count_arrangements(adapters: List(Int)) -> Int {
    let count_dict = adapters
    |> list.map(fn (x) { #(x, 1) })
    |> dict.from_list

    count_arrangements_loop(adapters, count_dict, 1)
}

fn count_arrangements_loop(adapters: List(Int), count_dict: dict.Dict(Int, Int), index: Int) -> Int {
    case adapters |> list.at(index) {
        Error(_) -> count_dict |> dict.values |> list.reduce(int.max) |> panic_unwrap
        Ok(adapter) -> {
            let first = count_dict |> dict.get(adapter - 1) |> result.unwrap(0)
            let second = count_dict |> dict.get(adapter - 2) |> result.unwrap(0)
            let third = count_dict |> dict.get(adapter - 3) |> result.unwrap(0)

            let new_count = first + second + third
            let new_count_dict = count_dict |> dict.insert(adapter, new_count)

            count_arrangements_loop(adapters, new_count_dict, index + 1)
        }
    }
}

fn part_1() {
    iox.read_lines_("data/day_10_input.txt")
    |> prepare_list
    |> compute_differences
    |> io.debug
}

fn part_2() {
    iox.read_lines_("data/day_10_input.txt")
    |> prepare_list
    |> count_arrangements
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
