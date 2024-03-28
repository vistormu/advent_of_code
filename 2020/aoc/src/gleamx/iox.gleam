import simplifile

pub fn read_file(file_path: String) -> Result(String, simplifile.FileError) {
    file_path
    |> simplifile.read
}
