import gleam/io
import gleam/list
import gleam/int
import gleam/string
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

fn traverse(lines: List(String), x: Int, y: Int, slope: #(Int, Int)) -> Int {
    case y >= list.length(lines) {
        True -> 0
        False -> {
            let line = list.at(lines, y)
            |> unwrap

            let spot = line
            |> string.slice(at_index: x % string.length(line), length: 1)
            
            case spot == "#" {
                True -> 1 + traverse(lines, x + slope.0, y + slope.1, slope)
                False -> traverse(lines, x + slope.0, y + slope.1, slope)
            }
        }
    }
}

fn part_1() {
    let _ = read_lines("src/input.txt")
    |> traverse(0, 0, #(3, 1))
    |> io.debug
}

fn part_2() {
    let slopes = [
        #(1, 1),
        #(3, 1),
        #(5, 1),
        #(7, 1),
        #(1, 2),
    ]

    let map = read_lines("src/input.txt")

    slopes
    |> list.map(traverse(map, 0, 0, _))
    |> int.product
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
