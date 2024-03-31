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

pub fn take(from str: String, up_to n: Int) -> String {
    str |> string.slice(0, n)
}

pub fn split_at(from str: String, at index: Int) -> #(String, String) {
    str
    |> string.to_graphemes
    |> list.split(index)
    |> fn (pair: #(List(String), List(String))) {
        #(string.join(pair.0, ""), string.join(pair.1, ""))
    }
}

pub fn replace_at(from str: String, at index: Int, with substring: String) -> String {
    let #(head, tail) = split_at(str, index)
    let tail = string.drop_left(tail, 1)

    head <> substring <> tail
}
