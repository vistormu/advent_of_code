import gleeunit
import gleeunit/should
import gleamx/array
import gleamx/result
import gleam/int


pub fn main() {
    gleeunit.main()
}

pub fn array_length_test() {
    [1, 2, 3]
    |> array.from_list
    |> array.length
    |> should.equal(3)
}

pub fn array_at_test() {
    [1, 2, 3]
    |> array.from_list
    |> array.at(1)
    |> result.must
    |> should.equal(2)

    ["a", "b", "c"]
    |> array.from_list
    |> array.at(2)
    |> result.must
    |> should.equal("c")
}

pub fn array_replace_test() {
    [1, 2, 3]
    |> array.from_list
    |> array.replace(0, 0)
    |> array.to_list
    |> should.equal([0, 2, 3])
}

pub fn array_new_test() {
    array.new(0, 3)
    |> array.to_list
    |> should.equal([0, 0, 0])
}

pub fn array_count_test() {
    ["a", "a", "c"]
    |> array.from_list
    |> array.count(fn(x) {x=="a"})
    |> should.equal(2)
}

pub fn array_map_test() {
    ["1", "2", "3"]
    |> array.from_list
    |> array.map(int.parse)
    |> array.map(result.must)
    |> array.to_list
    |> should.equal([1, 2, 3])
}
