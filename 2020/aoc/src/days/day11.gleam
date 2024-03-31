import gleam/io
import gleamx/iox
import gleam/list
import gleamx/listx
import gleam/result
import gleamx/stringx
import gleam/string
import gleam/iterator as iter
import gleam/int


fn get_neighbors(grid: List(String), x: Int, y: Int) -> List(String) {
    let l1 = grid |> list.at(y-1) |> result.unwrap("")
    let l2 = grid |> listx.at_(y)
    let l3 = grid |> list.at(y+1) |> result.unwrap("")

    let n1 = l1 |> stringx.at(x-1)
    let n2 = l1 |> stringx.at(x)
    let n3 = l1 |> stringx.at(x+1)
    let n4 = l2 |> stringx.at(x-1)
    let n5 = l2 |> stringx.at(x+1)
    let n6 = l3 |> stringx.at(x-1)
    let n7 = l3 |> stringx.at(x)
    let n8 = l3 |> stringx.at(x+1)

    let n_cols = string.length(l2)
    case x {
        0 -> ["", n2, n3, "", n5, "", n7, n8]
        x if x == n_cols -> [n1, n2, "", n4, "", n6, n7, ""]
        _ -> [n1, n2, n3, n4, n5, n6, n7, n8]
    }
}

fn get_neighbors_2(grid: List(String), x: Int, y: Int, n_rows: Int, n_cols: Int) -> List(String) {
    let grid = grid |> list.map(string.to_graphemes)

    let hor = grid |> listx.at_(y) |> list.split(x)
    let left = hor.0 |> list.reverse
    let right = hor.1 |> list.drop(1)

    let ver = grid |> list.map(fn(row) { row |> listx.at_(x) }) |> list.split(y)
    let up = ver.0 |> list.reverse
    let down = ver.1 |> list.drop(1)

    let assert Ok(min) = list.reduce([x, y, n_cols-x-1, n_rows-y-1], int.min)
    let diag = iter.range(0, min)
    |> iter.map(fn(n) {
        let up_left = grid |> listx.at_(y-n) |> listx.at_(x-n)
        let up_right = grid |> listx.at_(y-n) |> listx.at_(x+n)
        let down_left = grid |> listx.at_(y+n) |> listx.at_(x-n)
        let down_right = grid |> listx.at_(y+n) |> listx.at_(x+n)

        #(up_left, up_right, down_left, down_right)
    })
    |> iter.to_list

    let up_left = diag |> list.map(fn(x) {x.0}) |> list.drop(1)
    let up_right = diag |> list.map(fn(x) {x.1}) |> list.drop(1)
    let down_left = diag |> list.map(fn(x) {x.2})
    let down_right = diag |> list.map(fn(x) {x.3})


    [left, right, up, down, up_left, up_right, down_left, down_right]
    |> list.map(fn (n) {
        n
        |> list.find(fn(x) { x != "." })
        |> result.unwrap("")
    })
}

fn play(grid: List(String), part: Int) -> Int {
    let n_rows = list.length(grid)
    let n_cols = grid |> listx.first_ |> string.length

    step(grid, n_rows, n_cols, part)
}

fn step(grid: List(String), n_rows: Int, n_cols: Int, part: Int) -> Int {
    case step_loop(grid, n_rows, n_cols, part) {
        new_grid if grid == new_grid -> {
            new_grid 
            |> list.map(fn(row) {stringx.count(row, "#")})
            |> int.sum
        }
        new_grid -> step(new_grid, n_rows, n_cols, part)
    }
}

fn step_loop(grid: List(String), n_rows: Int, n_cols: Int, part: Int) -> List(String) {
    let iter_x = iter.range(0, n_cols-1)
    let iter_y = iter.range(0, n_rows-1)

    iter_y
    |> iter.map(fn(y) {
        iter_x
        |> iter.map(fn(x) {
            let seat = grid |> listx.at_(y) |> stringx.at(x)

            let neighbors = case #(seat, part) {
                #("L", 1) | #("#", 1) -> get_neighbors(grid, x, y) |> listx.count(fn(x) {x == "#"})
                #("L", 2) | #("#", 2) -> get_neighbors_2(grid, x, y, n_rows, n_cols) |> listx.count(fn(x) {x == "#"})
                _ -> 0
            }

            case #(seat, neighbors) {
                #("L", 0) -> "#"
                #("#", n) -> {
                    case n >= 4 && part == 1 || n >= 5 && part == 2 {
                        True -> "L"
                        False -> "#"
                    }
                }
                _ -> seat
            }
        })
        |> iter.to_list
        |> string.join("")
    })
    |> iter.to_list
    |> list.map(io.debug)
}

fn part_1() {
    iox.read_lines_("data/day_11_input.txt")
    |> play(1)
    |> io.debug
}

fn part_2() {
    iox.read_lines_("data/day_11_input.txt")
    |> play(2)
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
