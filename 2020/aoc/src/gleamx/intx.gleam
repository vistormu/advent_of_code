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
