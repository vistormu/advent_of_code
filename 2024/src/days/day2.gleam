import gleamx/result
import gleam/string
import gleam/list
import gleam/pair

import utils

import gleamx/io as iox
import gleamx/list as listx
import gleamx/function
import gleamx/matrix

pub fn run() {
    "input/day2_test.txt"
    |> iox.read_lines
    |> part1
    |> utils.assert_(2)

    "input/day2.txt"
    |> iox.read_lines
    |> part1
    |> function.wrap
    |> utils.run("part1")

    "input/day2_test.txt"
    |> iox.read_lines
    |> part2
    |> utils.assert_(4)

    "input/day2.txt"
    |> iox.read_lines
    |> part2
    |> function.wrap
    |> utils.run("part2")
}

fn part1(content: List(String)) -> Int {
    content
    |> list.map(string.split(_, " "))
    |> matrix.parse_int
    |> list.map(check_report)
    |> list.count(fn(x) {x==True})
}

fn part2(content: List(String)) -> Int {
    content
    |> list.map(string.split(_, " "))
    |> matrix.parse_int
    |> list.map(fn(report) {
        case check_report(report) {
            True -> True
            False -> recheck_report(report)
        }
    })
    |> list.count(fn(x) {x==True})
}

fn check_report(report: List(Int)) -> Bool {
    report
    |> list.window_by_2
    |> list.map(fn(tuple) {
        case tuple.1 - tuple.0 {
            1 | 2 | 3 -> 1
            -1 | -2 | -3 -> -1
            _ -> 0
        }
    })
    |> list.unique
    |> fn (x) {
        list.length(x) == 1 && {list.first(x) |> result.must != 0}
    }
}

fn recheck_report(report: List(Int)) -> Bool {
    recheck_report_loop(report, 0)
}
fn recheck_report_loop(report: List(Int), i: Int) -> Bool {
    let valid = report
    |> listx.pop(i)
    |> pair.second
    |> check_report

    case !valid && i < {list.length(report) - 1} {
        True -> recheck_report_loop(report, i+1)
        False -> valid
    }
}
