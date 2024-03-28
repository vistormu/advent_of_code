import gleam/io
import gleamx/iox
import gleam/string
import gleam/list
import gleam/int
import gleam/iterator as iter
import gleamx/resultx.{panic_unwrap}


fn read_lines(path: String) -> List(String) {
    path
    |> iox.read_file
    |> panic_unwrap
    |> string.trim
    |> string.split("\n")
}

fn calculate_id(boarding_pass: String) -> Int {
    boarding_pass
    |> string.replace("F", "0")
    |> string.replace("B", "1")
    |> string.replace("L", "0")
    |> string.replace("R", "1")
    |> int.base_parse(2)
    |> panic_unwrap
}

fn part_1() {
    read_lines("data/day_5_input.txt") 
    |> list.map(calculate_id)
    |> list.reduce(int.max)
    |> panic_unwrap
    |> io.debug
}

fn find_seat(ids: List(Int)) -> Int {
    let occupied = list.contains(ids, _)

    iter.range(1, 1023)
    |> iter.find( fn(id) {
       occupied(id-1) && !occupied(id) && occupied(id+1) 
    })
    |> panic_unwrap
}

fn part_2() {
    read_lines("data/day_5_input.txt") 
    |> list.map(calculate_id)
    |> list.sort(int.compare)
    |> find_seat
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
