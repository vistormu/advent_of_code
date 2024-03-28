import gleam/list

pub fn replace(in l: List(t), at index: Int, with new: t) -> List(t) {
    case list.at(l, index) {
        Error(_) -> l
        Ok(_) -> {
            l
            |> list.take(index)
            |> list.append([new])
            |> list.append(list.drop(l, index + 1))
        }
    }
}

pub fn find_index(in l: List(t), where f: fn(t) -> Bool) -> Result(Int, String) {
    find_index_loop(l, f, 0)
}

fn find_index_loop(l: List(t), f: fn(t) -> Bool, index: Int) -> Result(Int, String) {
    case l |> list.at(index) {
        Error(_) -> Error("Not found")
        Ok(element) -> {
            case f(element) {
                True -> Ok(index)
                False -> find_index_loop(l, f, index + 1)
            }
        }
    }
}
