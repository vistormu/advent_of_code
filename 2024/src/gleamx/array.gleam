import gleam/int
import gleam/list
import gleam/dict.{type Dict}

import gleamx/result

pub type Array(a) {
    Array(
        size: Int,
        elements: Dict(Int, a),
    )
}

pub fn from_list(l: List(a)) -> Array(a) {
    let size = list.length(l)
    let elements = populate(l, dict.new(), 0)

    Array(size, elements)
}
fn populate(list: List(a), elements: Dict(Int, a), index: Int) -> Dict(Int, a) {
    case list {
        [] -> elements
        [first, ..tail] -> {
            let elements = dict.insert(elements, index, first)
            populate(tail, elements, index+1)
        }
    }
}

pub fn new(value: a, size: Int) -> Array(a) {
    from_list(list.repeat(value, size))
}

pub fn to_list(array: Array(a)) -> List(a) {
    to_list_loop(array, [], 0) 
}
fn to_list_loop(array: Array(a), list: List(a), index: Int) -> List(a) {
    case index == array.size {
        True -> list
        False -> {
            let assert Ok(element) = dict.get(array.elements, index)
            to_list_loop(array, list.append(list, [element]), index+1)
        }
    }
}

pub fn at(from array: Array(a), at index: Int) -> Result(a, Nil) {
    dict.get(array.elements, index)
}

pub fn replace(from array: Array(a), at index: Int, with element: a) -> Array(a) {
    let elements = dict.insert(array.elements, index, element)
    Array(array.size, elements)
}

pub fn length(from array: Array(a)) -> Int {
    array.size
}

pub fn count(array: Array(a), condition: fn(a) -> Bool) -> Int {
    array
    |> to_list
    |> list.count(condition)
}

pub fn map(array: Array(a), func: fn(a) -> b) -> Array(b) {
    map_loop(array, [], func, 0) 
}
fn map_loop(array: Array(a), mapped: List(b), func: fn(a) -> b, index: Int) -> Array(b) {
    case index == array.size {
        True -> mapped |> from_list
        False -> {
            let result = array
            |> at(index)
            |> result.must
            |> func
            |> list.wrap
            |> list.append(mapped, _)

            map_loop(array, result, func, index+1)
        }
    }
}

pub fn sum(array: Array(Int)) -> Int {
    array
    |> to_list
    |> int.sum
}
