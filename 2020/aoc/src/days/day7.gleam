import gleam/io
import gleamx/iox
import gleam/string
import gleam/list
import gleamx/listx
import gleam/int
import gleamx/intx
import gleam/dict.{type Dict}
import gleamx/resultx.{panic_unwrap}


fn parse_bag(line: String) -> #(String, List(#(String, Int))) {
    let primary_bag = line
    |> string.split(" bags contain ")
    |> listx.first_

    let secondary_bags = line
    |> string.split(" bags contain ")
    |> listx.last_
    |> string.split(", ")
    |> list.map(fn (elements) {
        case elements |> string.split(" ") {
            ["no", ..] -> #("", 0)
            [number, adjective, color, ..] -> {
                let count = number |> intx.parse_
                let bag = adjective <> " " <> color
                #(bag, count)
            }
            _ -> panic
        }
    })
    
    #(primary_bag, secondary_bags)
}


fn find_bag_recursively(bags: Dict(String, List(#(String, Int))), bag: String, seen: List(String)) -> List(String) {
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

fn count_bags_recursively(bags: Dict(String, List(#(String, Int))), bag: String) -> Int { 
    let directly_containing = bags
    |> dict.get(bag)
    |> panic_unwrap

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
    iox.read_lines_("data/day_7_input.txt")
    |> list.map(parse_bag)
    |> dict.from_list
    |> find_bag("shiny gold")
    |> list.unique
    |> list.length
    |> io.debug
}

fn part_2() {
    iox.read_lines_("data/day_7_input.txt")
    |> list.map(parse_bag)
    |> dict.from_list
    |> count_bags("shiny gold")
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
