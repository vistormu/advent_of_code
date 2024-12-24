import gleam/string


pub fn replace_at(from str: String, at index: Int, with substring: String) -> String {
    let head = string.slice(str, 0, index)
    let tail = string.slice(str, index, string.length(str))

    case index > string.length(str) {
        True -> str
        False -> head <> substring <> tail
    }
}
