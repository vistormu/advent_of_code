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

type Line {
    Line(min: Int, max: Int, letter: String, password: String)
}

fn parse_line(line: String) -> Line {
    let parts = line
    |> string.split(on: " ")

    let numbers = parts
    |> list.at(0)
    |> unwrap
    |> string.split(on: "-")

    let min = numbers
    |> list.at(0)
    |> unwrap
    |> int.parse
    |> unwrap

    let max = numbers
    |> list.at(1)
    |> unwrap
    |> int.parse
    |> unwrap

    let letter = parts
    |> list.at(1)
    |> unwrap
    |> string.slice(at_index: 0, length: 1)

    let password = parts
    |> list.at(2)
    |> unwrap

    Line(min: min, max: max, letter: letter, password: password)
}

fn count_ocurrences(letter: String, password: String) -> Int {
    password
    |> string.split(on: letter)
    |> list.length
    |> int.add(-1)
}

fn part_1() {
    let _ = read_lines("src/input.txt")
    |> list.map(parse_line)
    |> list.map(fn (line) {
        case count_ocurrences(line.letter, line.password) {
            n if n >= line.min && n <= line.max -> True
            _ -> False
        }
        })
    |> list.filter(fn (x) { x == True })
    |> list.length
    |> io.debug
}

fn part_2() {
    let _ = read_lines("src/input.txt")
    |> list.map(parse_line)
    |> list.map(fn (line) {
        let first = line.password
        |> string.slice(at_index: line.min - 1, length: 1)
        let second = line.password
        |> string.slice(at_index: line.max - 1, length: 1)
        
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
