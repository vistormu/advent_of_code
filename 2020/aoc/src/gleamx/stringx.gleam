import gleam/int
import gleam/list
import gleam/string

pub fn count(in str: String, of substr: String) -> Int {
    str
    |> string.split(substr)
    |> list.length
    |> int.subtract(1)
}

pub fn at(in str: String, get index: Int) -> String {
    str
    |> string.slice(at_index: index, length: 1)
}
