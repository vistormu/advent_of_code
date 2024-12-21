import gleam/io
import gleam/int

import sprinkle.{format}
import gleam_community/ansi
import birl
import birl/duration.{type Duration}


pub fn assert_(result: Int, true: Int) {
    case result == true {
        True -> {
            "\n-> test passed successfully!\n"
            |> ansi.green
            |> io.println
        }

        False -> {
            let title = "\n-> test failed!\n"
            |> ansi.red

            let content = "   |> expected: {true}\n   |> got: {result}\n"
            |> format([
                #("true", int.to_string(true)),
                #("result", int.to_string(result)),
            ])

            io.println_error(title <> content)
            panic
        }
    }
}

pub fn format_duration(d: Duration) -> String {
  case d {
    duration.Duration(micros) if micros < 10_000 ->
      int.to_string(micros) <> " μs"
    duration.Duration(micros) if micros < 10_000_000 ->
      int.to_string(micros / 1000) <> " ms"
    duration.Duration(micros) -> int.to_string(micros / 1_000_000) <> " s"
  }
}

pub fn run(label: String, function) {
    let start = birl.now()
    let result = function()
    let diff = birl.now()
    |> birl.difference(start)
    |> format_duration

    io.println(
        {"-> \"" <> label <> "\" executed\n"}
        |> ansi.cyan
        <> "   |> result: {result}\n   |> elapsed time: {elapsed}\n"
        |> format([
            #("result", int.to_string(result)),
            #("elapsed", diff),
        ])
    )
}
