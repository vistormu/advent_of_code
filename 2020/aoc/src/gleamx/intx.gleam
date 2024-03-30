import gleam/int
import gleamx/resultx.{panic_unwrap}

pub fn between(number: Int, min: Int, max: Int) -> Bool {
    case number >= min && number <= max {
        True -> True
        False -> False
    }
}

pub fn is(number: int, other: int) -> Bool {
    case number == other {
        True -> True
        False -> False
    }
}

pub fn parse_(string: String) -> Int {
    string
    |> int.parse
    |> panic_unwrap
}
