import gleam/int
import gleam/list

import gleamx/array.{type Array}
import gleamx/result as resx

pub type Matrix(a) {
    Matrix(
        n_cols: Int,
        n_rows: Int,
        elements: Array(Array(a))
    )
}

pub fn from_list(list: List(List(a))) -> Matrix(a) {
    let elements = list
    |> list.map(array.from_list)
    |> array.from_list

    let n_rows = array.length(elements)
    let n_cols = array.at(elements, 0) |> resx.must |> array.length

    Matrix(n_cols, n_rows, elements)
}

pub fn to_list(mat: Matrix(a)) -> List(List(a)) {
    mat.elements
    |> array.map(array.to_list)
    |> array.to_list
}

pub fn shape(mat: Matrix(a)) -> #(Int, Int) {
    #(mat.n_rows, mat.n_cols)
}

pub fn at(mat: Matrix(a), y: Int, x: Int) -> Result(a, Nil) {
    case array.at(mat.elements, y) {
        Ok(row) -> array.at(row, x)
        Error(Nil) -> Error(Nil)
    }
}

pub fn neighbours(mat: Matrix(a), y: Int, x: Int) -> List(#(a, Int, Int)) {

    let append = fn(list: List(#(a, Int, Int)), result: Result(a, Nil), y: Int, x: Int) -> List(#(a, Int, Int)) {
        case result {
            Ok(v) -> list.append(list, [#(v, y, x)])
            Error(Nil) -> list
        }
    }
    
    []
    |> append(at(mat, y-1, x-1), y-1, x-1)
    |> append(at(mat, y-1, x), y-1, x)
    |> append(at(mat, y-1, x+1), y-1, x+1)
    |> append(at(mat, y,   x-1), y, x-1)
    |> append(at(mat, y,   x+1), y, x+1)
    |> append(at(mat, y+1, x-1), y+1, x-1)
    |> append(at(mat, y+1, x), y+1, x)
    |> append(at(mat, y+1, x+1), y+1, x+1)
}

pub fn parse_int(mat: List(List(String))) -> List(List(Int)) {
    mat
    |> list.map(list.map(_, {int.parse}))
    |> list.map(list.map(_, {resx.must}))
}

pub fn map(mat: Matrix(a), func: fn(a, Int, Int) -> b) -> Matrix(b) {
    let #(n_rows, n_cols) = shape(mat)
    let iter_x = list.range(0, n_cols-1)
    let iter_y = list.range(0, n_rows-1)

    list.map(iter_y, fn(y) { list.map(iter_x, fn(x) {
        mat
        |> at(y, x)
        |> resx.must
        |> func(y, x)
    })})
    |> from_list
}

pub fn count(mat: Matrix(a), condition: fn(a) -> Bool) -> Int {
    mat.elements
    |> array.map(array.count(_, condition))
    |> array.to_list
    |> int.sum
}

pub fn sum(mat: Matrix(Int)) -> Int {
    mat.elements
    |> array.map(array.sum)
    |> array.sum
}
