import gleam/io
import gleamx/iox
import gleam/string
import gleamx/stringx
import gleam/list
import gleamx/listx
import gleamx/intx

type Line {
    Line(min: Int, max: Int, letter: String, password: String)
}

fn parse_line(line: String) -> Line {
    let parts = line
    |> string.split(on: " ")

    let numbers = parts
    |> listx.at_(0)
    |> string.split(on: "-")

    let min = numbers
    |> listx.at_(0)
    |> intx.parse_

    let max = numbers
    |> listx.at_(1)
    |> intx.parse_

    let letter = parts
    |> listx.at_(1)
    |> string.slice(at_index: 0, length: 1)

    let password = parts
    |> listx.at_(2)

    Line(min: min, max: max, letter: letter, password: password)
}

fn part_1() {
    iox.read_lines_("data/day_2_input.txt")
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
    iox.read_lines_("data/day_2_input.txt")
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
