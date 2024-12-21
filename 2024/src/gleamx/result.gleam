import gleam/io

pub fn must_msg(result: Result(t, _), msg: String) -> t {
    case result {
        Ok(v) -> v
        Error(e) -> {
            io.debug(e)
            panic as msg
        }
    }
}

pub fn must(result: Result(t, _)) -> t {
    case result {
        Ok(v) -> v
        Error(e) -> {
            io.debug(e)
            panic
        }
    }
}
