import gleam/io
import gleamx/iox
import gleam/string
import gleam/list
import gleamx/listx
import gleam/int
import gleam/result
import gleamx/resultx.{panic_unwrap}


fn read_lines(path: String) -> List(String) {
    path
    |> iox.read_file
    |> panic_unwrap
    |> string.trim
    |> string.split("\n")
}

fn parse_instruction(line: String) -> #(String, Int) {
    let instruction = line
    |> string.split(" ")
    |> list.first
    |> panic_unwrap

    let number = line
    |> string.split(" ")
    |> list.last
    |> panic_unwrap
    |> fn (x) {
        case x |> string.slice(0, 1) {
            "+" -> x |> string.slice(1, x |> string.length)
            _ -> x
        }
    }
    |> int.parse
    |> panic_unwrap

    #(instruction, number)
}

fn read_program(program: List(String)) -> #(Int, Bool) {
    read_program_loop(program, 0, 0)
}

fn read_program_loop(program: List(String), acc: Int, index: Int) -> #(Int, Bool) {
    let instruction = program
    |> list.at(index)
    |> result.unwrap("end +0")
    |> parse_instruction

    let program = program
    |> listx.replace(at: index, with: "end +1")
    
    case instruction {
        #("nop", _) -> read_program_loop(program, acc, index + 1)
        #("acc", number) -> read_program_loop(program, acc + number, index + 1)
        #("jmp", number) -> read_program_loop(program, acc, index + number)
        #("end", 0) -> #(acc, True)
        #("end", 1) -> #(acc, False)
        _ -> panic as instruction.0
    }
}

fn eval_program(program: List(String)) -> Int {
    eval_program_loop(program, 0)
}

fn eval_program_loop(program: List(String), index: Int) -> Int {
    let condition = fn (x: String) -> String {
        case x |> string.split(" ") {
            ["nop", number] -> "jmp " <> number
            ["jmp", number] -> "nop " <> number
            _ -> ""
        }
    }

    case program |> list.at(index) {
        Error(_) -> panic as "end of program"
        Ok(instruction) -> case condition(instruction) {
            "" -> eval_program_loop(program, index + 1)
            new_instruction -> {
                let new_program = program
                |> listx.replace(at: index, with: new_instruction)

                case read_program(new_program) {
                    #(acc, True) -> acc
                    #(_, False) -> eval_program_loop(program, index + 1)
                }
            }
        }
    }
}

fn part_1() {
    read_lines("data/day_8_input.txt")
    |> read_program
    |> fn (x: #(Int, Bool)) { x.0 }
    |> io.debug
}

fn part_2() {
    read_lines("data/day_8_input.txt")
    |> eval_program
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
