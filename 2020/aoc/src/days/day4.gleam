import gleam/io
import gleamx/iox
import gleam/list
import gleamx/listx
import gleam/string
import gleamx/intx
import gleam/dict.{type Dict}
import gleam/regex
import gleamx/resultx.{panic_unwrap}


fn read_lines(file_path: String) -> List(String) {
    file_path
    |> iox.read_
    |> string.trim
    |> string.split(on: "\n\n")
    |> list.map(string.replace(_, "\n", " "))
}

fn parse_passport(passport: String) -> Dict(String, String) {
    passport
    |> string.split(on: " ")
    |> list.map(fn (field) {
        let field = field |> string.split(on: ":")
        let key = field |> listx.first_
        let value = field |> listx.last_
        #(key, value)
    })
    |> dict.from_list
}

const allowed_fields = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

fn validate_n_fields(passport: Dict(String, String)) -> Bool {
    passport
    |> dict.keys
    |> list.filter(list.contains(allowed_fields, _))
    |> list.length
    |> intx.is(7)
}

fn parse_between(value: String, min: Int, max: Int) -> Bool {
    value
    |> intx.parse_
    |> intx.between(min, max)
}

fn validate_byr(passport: Dict(String, String)) -> Bool {
    passport
    |> dict.get("byr") |> panic_unwrap
    |> parse_between(1920, 2002)
}

fn validate_iyr(passport: Dict(String, String)) -> Bool {
    passport
    |> dict.get("iyr") |> panic_unwrap
    |> parse_between(2010, 2020)
}

fn validate_eyr(passport: Dict(String, String)) -> Bool {
    passport
    |> dict.get("eyr") |> panic_unwrap
    |> parse_between(2020, 2030)
}

fn validate_hgt(passport: Dict(String, String)) -> Bool {
    passport
    |> dict.get("hgt") |> panic_unwrap
    |> fn (hgt) {
        let unit = hgt
        |> string.slice(at_index: -2, length: 2)
        let hgt = hgt
        |> string.drop_right(2)

        case unit {
            "cm" -> parse_between(hgt, 150, 193)
            "in" -> parse_between(hgt, 59, 76)
            _ -> False
        }
    }
}

fn validate_hcl(passport: Dict(String, String)) -> Bool {
    passport
    |> dict.get("hcl") |> panic_unwrap
    |> fn (hcl) {
        regex.from_string("^#[0-9a-f]{6}$")
        |> panic_unwrap
        |> regex.check(hcl)
    }
}

const valid_ecl = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

fn validate_ecl(passport: Dict(String, String)) -> Bool {
    passport
    |> dict.get("ecl") |> panic_unwrap
    |> list.contains(valid_ecl, _)
}

fn validate_pid(passport: Dict(String, String)) -> Bool {
    passport
    |> dict.get("pid") |> panic_unwrap
    |> string.length
    |> intx.is(9)
}

fn part_1() {
    read_lines("data/day_4_input.txt")
    |> list.map(parse_passport)
    |> list.filter(validate_n_fields)
    |> list.length
    |> io.debug
}

fn part_2() {
    read_lines("data/day_4_input.txt")
    |> list.map(parse_passport)
    |> list.filter(validate_n_fields)
    |> list.filter(validate_byr)
    |> list.filter(validate_iyr)
    |> list.filter(validate_eyr)
    |> list.filter(validate_hgt)
    |> list.filter(validate_hcl)
    |> list.filter(validate_ecl)
    |> list.filter(validate_pid)
    |> list.length
    |> io.debug
}

pub fn main() {
    part_1()
    part_2()
}
