import gleam/io
import gleam/string
import gleam/list
import gleam/int
import gleam/dict.{type Dict}
import simplifile as file

fn unwrap(result: Result(t, _)) -> t {
    case result {
        Ok(result) -> result
        Error(e) -> {
            io.debug(e)
            panic
        }
    }
}

fn read_lines(path: String) -> List(String) {
    path
    |> file.read
    |> unwrap
    |> string.trim
    |> string.split("\n")
}

fn parse_bag(line: String) -> #(String, List(#(String, Int))) {
    let primary_bag = line
    |> string.split(" bags contain ")
    |> list.first |> unwrap

    let secondary_bags = line
    |> string.split(" bags contain ")
    |> list.last |> unwrap
    |> string.split(", ")
    |> list.map(fn (elements) {
        case elements |> string.split(" ") {
            ["no", ..] -> #("", 0)
            [number, adjective, color, ..] -> {
                let count = number |> int.parse |> unwrap
                let bag = adjective <> " " <> color
                #(bag, count)
            }
            _ -> panic
        }
    })
    
    #(primary_bag, secondary_bags)
}


fn find_bag_recursively(
    bags: Dict(String, List(#(String, Int))), 
    bag: String, 
    seen: List(String)
) -> List(String) {
    let directly_containing = bags
    |> dict.filter(fn (_k, v) { 
        v 
        |> list.map(fn (x) { x.0 })
        |> list.contains(bag) 
    })
    |> dict.keys

    case directly_containing {
        [] -> seen
        _ -> {
            let new_seen = list.append(seen, directly_containing)
            directly_containing
            |> list.fold(new_seen, fn (acc, next_bag) {
                find_bag_recursively(bags, next_bag, acc)
            })
        }
    }
}

fn find_bag(bags: Dict(String, List(#(String, Int))), bag: String) -> List(String) {
    find_bag_recursively(bags, bag, [])
}

fn count_bags_recursively(
    bags: Dict(String, List(#(String, Int))), 
    bag: String
) -> Int {
    let directly_containing = bags
    |> dict.get(bag)
    |> unwrap

    case directly_containing {
        [#("", 0)] -> 0
        _ -> {
            directly_containing
            |> list.map(fn (x) {
                let #(contained_bag, count) = x
                count + count * count_bags_recursively(bags, contained_bag)
            })
            |> int.sum
        }
    }
}

fn count_bags(bags: Dict(String, List(#(String, Int))), bag: String) -> Int {
    count_bags_recursively(bags, bag)
}

fn part_1() {
    read_lines("src/input.txt")
    |> list.map(parse_bag)
    |> dict.from_list
    |> find_bag("shiny gold")
    |> list.unique
    |> list.length
    |> io.debug
}

fn part_2() {
    read_lines("src/input.txt")
    |> list.map(parse_bag)
    |> dict.from_list
    |> count_bags("shiny gold")
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
