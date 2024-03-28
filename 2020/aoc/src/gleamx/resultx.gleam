import gleam/io

pub fn panic_unwrap(result: Result(t, _)) -> t {
    case result {
        Ok(value) -> value
        Error(e) -> {
            io.debug(e)
            panic
        }
    }
}

pub fn panic_unwrap_msg(result: Result(t, _), msg: String) -> t {
    case result {
        Ok(value) -> value
        Error(e) -> {
            io.debug(e)
            panic as msg
        }
    }
}
