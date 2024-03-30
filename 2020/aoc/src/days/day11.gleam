import gleam/io
import gleamx/iox

fn part_1() {
    iox.read_lines_("data/day_11_test.txt")
    |> io.debug
}

pub fn main() {
    part_1()
}
