import gleam/io
import gleamx/iox
import gleam/list
import gleamx/listx
import gleam/int
import gleam/string
import gleamx/stringx


fn traverse_loop(lines: List(String), x: Int, y: Int, slope: #(Int, Int)) -> Int {
    case y >= list.length(lines) {
        True -> 0
        False -> {
            let line = listx.at_(lines, y)
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
    iox.read_lines_("data/day_3_input.txt")
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

    let map = iox.read_lines_("data/day_3_input.txt")

    slopes
    |> list.map(traverse(map, _))
    |> int.product
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
