import gleam/list

pub fn pop(from l: List(t), at index: Int) -> #(t, List(t)) {
    let #(head, tail) = list.split(l, index)
    let assert [element, ..tail] = tail
    #(element, list.flatten([head, tail]))
}
