import gleam/string
import gleam/int
import gleam/regexp
import gleam/list
import gleam/option.{Some}

import utils
import gleamx/io as iox
import gleamx/result
import gleamx/function as func


pub fn run() {
    "input/day3_test.txt"
    |> iox.read
    |> part1
    |> utils.assert_(161)

    "input/day3.txt"
    |> iox.read
    |> part1
    |> func.wrap
    |> utils.run("part1")

    "input/day3_test_2.txt"
    |> iox.read
    |> part2
    |> utils.assert_(48)

    "input/day3.txt"
    |> iox.read
    |> part2
    |> func.wrap
    |> utils.run("part2")
}

fn part1(content: String) -> Int {
    "mul\\((\\d+),(\\d+)\\)"
    |> regexp.from_string
    |> result.must
    |> regexp.scan(content)
    |> list.map(fn(match) {
        list.map(match.submatches, fn(x) {
            let assert Some(v) = x
            v |> int.parse |> result.must
        })
    })
    |> list.map(fn(x) {
        let assert [a, b] = x
        a*b
    })
    |> int.sum
}

fn part2(content: String) -> Int {
    let assert Ok(do_re) = regexp.from_string("do\\(\\)")
    let assert Ok(dont_re) = regexp.from_string("don't\\(\\)")
    let assert Ok(mul_re) = regexp.from_string("mul\\((\\d+),(\\d+)\\)")

    let assert [first, ..rest] = regexp.split(dont_re, content)
    
    rest
    |> list.map(fn(x){
        case regexp.split(do_re, x) {
            [_, ..rest] -> string.join(rest, "")
            _ -> ""
        }
    })
    |> list.prepend(first)
    |> string.join("")
    |> regexp.scan(mul_re, _)
    |> list.map(fn(match) {
        list.map(match.submatches, fn(x) {
            let assert Some(v) = x
            v |> int.parse |> result.must
        })
    })
    |> list.map(fn(x) {
        let assert [a, b] = x
        a*b
    })
    |> int.sum
}
