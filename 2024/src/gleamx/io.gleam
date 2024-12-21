import simplifile
import gleam/string

import gleamx/result

pub fn read(path: String) -> String {
    // let assert Ok(content) = simplifile.read(path)
    // content
    path
    |> simplifile.read
    |> result.must_msg("error reading file")
}

pub fn read_lines(path: String) -> List(String) {
    path
    |> read
    |> string.trim_end
    |> string.split("\n")
}
