import gleam/io
import gleamx/iox
import gleamx/resultx.{panic_unwrap}
import gleam/string
import gleamx/stringx
import gleam/list
import gleam/int
import gleamx/intx

fn read_lines(file_path: String) -> List(String) {
    file_path
    |> iox.read_file |> panic_unwrap
    |> string.trim
    |> string.split(on: "\n")
}

type Line {
    Line(min: Int, max: Int, letter: String, password: String)
}

fn parse_line(line: String) -> Line {
    let parts = line
    |> string.split(on: " ")

    let numbers = parts
    |> list.at(0) |> panic_unwrap
    |> string.split(on: "-")

    let min = numbers
    |> list.at(0) |> panic_unwrap
    |> int.parse |> panic_unwrap

    let max = numbers
    |> list.at(1) |> panic_unwrap
    |> int.parse |> panic_unwrap

    let letter = parts
    |> list.at(1) |> panic_unwrap
    |> string.slice(at_index: 0, length: 1)

    let password = parts
    |> list.at(2) |> panic_unwrap

    Line(min: min, max: max, letter: letter, password: password)
}

fn part_1() {
    read_lines("data/day_2_input.txt")
    |> list.map(parse_line)
    |> list.map(fn (line) {
        stringx.count(line.password, line.letter)
        |> intx.between(line.min, line.max)
    })
    |> list.filter(fn (x) { x == True })
    |> list.length
    |> io.debug
}

fn part_2() {
    read_lines("data/day_2_input.txt")
    |> list.map(parse_line)
    |> list.map(fn (line) {
        let first = line.password
        |> stringx.at(line.min - 1)
        let second = line.password
        |> stringx.at(line.max - 1)
        
        case first == line.letter && second != line.letter || first != line.letter && second == line.letter {
            True -> True
            False -> False
        }
    })
    |> list.filter(fn (x) { x == True })
    |> list.length
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
