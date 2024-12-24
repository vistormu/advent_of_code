import gleam/result
import gleam/bool
import gleam/string
import gleam/list
import gleam/io
import gleam/int

import utils
import gleamx/io as iox
import gleamx/function as func
import gleamx/matrix.{type Matrix}

pub fn run() {
    "input/day4_test.txt"
    |> iox.read_lines
    |> list.map(string.to_graphemes)
    |> matrix.from_list
    |> part1
    |> utils.assert_(18)

    "input/day4.txt"
    |> iox.read_lines
    |> list.map(string.to_graphemes)
    |> matrix.from_list
    |> part1
    |> func.wrap
    |> utils.run("part1")

    "input/day4_test.txt"
    |> iox.read_lines
    |> list.map(string.to_graphemes)
    |> matrix.from_list
    |> part2
    |> utils.assert_(9)

    "input/day4.txt"
    |> iox.read_lines
    |> list.map(string.to_graphemes)
    |> matrix.from_list
    |> part2
    |> func.wrap
    |> utils.run("part2")
}

fn part1(grid: Matrix(String)) -> Int {
    grid
    |> matrix.map(fn(a, y, x) {
        case a {
            "X" -> find_words(grid, y, x)
            _ -> 0
        }
    })
    |> matrix.sum
}

fn find_words(grid: Matrix(String), y: Int, x: Int) -> Int {
    grid
    |> matrix.neighbours(y, x)
    |> list.filter(fn(nb) {nb.0 == "M"})
    |> list.map(fn(target) {
        read_word(grid, target.1, target.2, target.1-y, target.2-x)
    })
    |> int.sum
}
fn read_word(grid: Matrix(String), y: Int, x: Int, y_offset: Int, x_offset: Int) -> Int {
    read_word_loop(grid, y, x, y_offset, x_offset, "A")
}
fn read_word_loop(grid: Matrix(String), y: Int, x: Int, y_offset: Int, x_offset: Int, target: String) -> Int {
    use <- bool.guard(target == "done", 1)
    
    let next_letter = case matrix.at(grid, y+y_offset, x+x_offset) {
        Ok(v) -> v
        Error(_) -> ""
    }
    let next_target = case target {
        "A" -> "S"
        "S" -> "done"
        _ -> ""
    }
    use <- bool.guard(next_letter == "" || next_target == "" || next_letter != target, 0)

    read_word_loop(grid, y+y_offset, x+x_offset, y_offset, x_offset, next_target)
}

fn part2(grid: Matrix(String)) -> Int {
    grid
    |> matrix.map(fn(a, y, x) {
        use <- bool.guard(when: a != "A", return: 0)

        let neg = case matrix.at(grid, y-1, x-1) {
            Ok(v) if v == "M" -> {
                case matrix.at(grid, y+1, x+1) {
                    Ok(v) if v == "S" -> True
                    _ -> False
                }
            }
            Ok(v) if v == "S" -> {
                case matrix.at(grid, y+1, x+1) {
                    Ok(v) if v == "M" -> True
                    _ -> False
                }
            }
            _ -> False
        }
        let pos = case matrix.at(grid, y-1, x+1) {
            Ok(v) if v == "M" -> {
                case matrix.at(grid, y+1, x-1) {
                    Ok(v) if v == "S" -> True
                    _ -> False
                }
            }
            Ok(v) if v == "S" -> {
                case matrix.at(grid, y+1, x-1) {
                    Ok(v) if v == "M" -> True
                    _ -> False
                }
            }
            _ -> False
        }

        case neg && pos {
            True -> 1
            False -> 0
        }
    })
    |> matrix.sum
}
