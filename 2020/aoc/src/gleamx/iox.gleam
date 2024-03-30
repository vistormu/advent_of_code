import simplifile
import gleamx/resultx.{panic_unwrap}
import gleam/string

pub fn read(file_path: String) -> Result(String, simplifile.FileError) {
    file_path
    |> simplifile.read
}

pub fn read_(file_path: String) -> String {
    file_path
    |> simplifile.read
    |> panic_unwrap
    |> string.trim
}

pub fn read_lines_(file_path: String) -> List(String) {
    file_path
    |> simplifile.read
    |> panic_unwrap
    |> string.trim
    |> string.split("\n")
}
