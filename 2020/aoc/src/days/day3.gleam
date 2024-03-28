import gleam/io
import gleamx/iox
import gleam/list
import gleam/int
import gleam/string
import gleamx/stringx
import gleamx/resultx


fn read_lines(file_path: String) -> List(String) {
    file_path
    |> iox.read_file 
    |> resultx.panic_unwrap
    |> string.trim
    |> string.split(on: "\n")
}

fn traverse_loop(lines: List(String), x: Int, y: Int, slope: #(Int, Int)) -> Int {
    case y >= list.length(lines) {
        True -> 0
        False -> {
            let line = list.at(lines, y)
            |> resultx.panic_unwrap

            let spot = line
            |> stringx.at(x % string.length(line))
            
            case spot == "#" {
                True -> 1 + traverse_loop(lines, x + slope.0, y + slope.1, slope)
                False -> traverse_loop(lines, x + slope.0, y + slope.1, slope)
            }
        }
    }
}

fn traverse(lines: List(String), slope: #(Int, Int)) -> Int {
    traverse_loop(lines, 0, 0, slope)
}

fn part_1() {
    read_lines("data/day_3_input.txt")
    |> traverse(#(3, 1))
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

    let map = read_lines("data/day_3_input.txt")

    slopes
    |> list.map(traverse(map, _))
    |> int.product
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
