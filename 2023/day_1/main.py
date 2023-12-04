def part_1() -> None:
    with open("input.txt") as f:
        lines: list[str] = f.read().splitlines()

    sum: int = 0
    for line in lines:
        first: bool = False
        first_digit: str = ""
        last_digit: str = ""

        for char in line:
            if char.isdigit() and not first:
                first_digit = char
                first = True
            elif char.isdigit():
                last_digit = char

        if last_digit == "":
            last_digit = first_digit

        combined: str = first_digit + last_digit

        sum += int(combined)

    print(sum)


def part_2() -> None:
    with open("input.txt") as f:
        lines: list[str] = f.read().splitlines()

    map: dict[str, str] = {
        "one": "one1one",
        "two": "two2two",
        "three": "three3three",
        "four": "four4four",
        "five": "five5five",
        "six": "six6six",
        "seven": "seven7seven",
        "eight": "eight8eight",
        "nine": "nine9nine",
    }

    sum: int = 0
    for line in lines:
        print(line)
        for key, value in map.items():
            line = line.replace(key, value)

        line = "".join(filter(str.isdigit, line))
        sum += int(line[0]+line[-1])

    print(sum)


if __name__ == "__main__":
    part_1()
    part_2()
