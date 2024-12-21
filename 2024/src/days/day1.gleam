import gleam/list
import gleam/string
import gleam/int

import utils

import gleamx/io as iox
import gleamx/function
import gleamx/result

pub fn run() {
    "input/day1_test.txt"
    |> iox.read_lines
    |> part1
    |> utils.assert_(11)

    "input/day1.txt"
    |> iox.read_lines
    |> part1
    |> function.wrap
    |> utils.run("part1", _)

    "input/day1_test.txt"
    |> iox.read_lines
    |> part2
    |> utils.assert_(31)

    "input/day1.txt"
    |> iox.read_lines
    |> part2
    |> function.wrap
    |> utils.run("part2", _)
}

fn part1(content: List(String)) -> Int {
    let assert [first, second] = content
    |> list.map(string.split(_, "   "))
    |> list.transpose

    let first = first
    |> list.map(int.parse)
    |> list.map(result.must)
    |> list.sort(int.compare)

    let second = second
    |> list.map(int.parse)
    |> list.map(result.must)
    |> list.sort(int.compare)

    list.map2(first, second, fn(a, b) { int.absolute_value(a-b) })
    |> int.sum
}

fn part2(content: List(String)) -> Int {
    let assert [first, second] = content
    |> list.map(string.split(_, "   "))
    |> list.transpose

    let first = first
    |> list.map(int.parse)
    |> list.map(result.must)

    let second = second
    |> list.map(int.parse)
    |> list.map(result.must)
    |> list.sort(int.compare)

    first
    |> list.map(fn(a) {
        list.count(second, fn(b) {a==b}) * a
    })
    |> int.sum
}
