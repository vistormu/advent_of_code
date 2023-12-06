def get_eight_neighbors(x: int, y: int, matrix: list[list[str]]) -> list[str]:
    neighbors: list[str] = []
    for i in range(x - 1, x + 2):
        for j in range(y - 1, y + 2):
            try:
                neighbors.append(matrix[i][j])
            except IndexError:
                neighbors.append("")
    return neighbors


def part_1() -> None:
    with open('input.txt', 'r') as f:
        lines: list[str] = f.read().splitlines()

    matrix: list[list[str]] = []
    for line in lines:
        matrix.append(list(line))

    list_of_numbers: list[int] = []
    number: str = ""
    symbols: set[str] = set()
    for i, row in enumerate(matrix):
        for j, element in enumerate(row):
            if not element.isdigit():
                if number and len(symbols):
                    list_of_numbers.append(int(number))
                number = ""
                symbols = set()
                continue

            number += element
            neighbors: list[str] = get_eight_neighbors(i, j, matrix)
            symbols.update(neighbors)
            symbols.difference_update(set([str(i) for i in range(10)] + ['.'] + ['']))

    if number and len(symbols):
        list_of_numbers.append(int(number))

    print(sum(list_of_numbers))


def get_asterisk_neighbor(x: int, y: int, matrix: list[list[str]]) -> tuple[int, int] | None:
    for i in range(x - 1, x + 2):
        for j in range(y - 1, y + 2):
            try:
                if matrix[i][j] == '*':
                    return i, j
            except IndexError:
                pass
    return None


def part_2() -> None:
    with open('input.txt', 'r') as f:
        lines: list[str] = f.read().splitlines()

    matrix: list[list[str]] = []
    for line in lines:
        matrix.append(list(line))

    number: str | None = None
    coordinate: tuple[int, int] | None = None
    coordinates: list[tuple[int, int]] = []
    numbers: list[int] = []
    for i, row in enumerate(matrix):
        for j, element in enumerate(row):
            if not element.isdigit():
                if number is not None and coordinate is not None:
                    coordinates.append(coordinate)
                    numbers.append(int(number))
                number = None
                coordinate = None
                continue

            if number is None:
                number = ""
            number += element
            asterisk_neighbor: tuple[int, int] | None = get_asterisk_neighbor(i, j, matrix)
            if asterisk_neighbor is not None:
                coordinate = asterisk_neighbor

    if number is not None and coordinate is not None:
        numbers.append(int(number))

    groups = {}
    for num, coord in zip(numbers, coordinates):
        if coord not in groups:
            groups[coord] = []
        groups[coord].append(num)

    grouped_numbers = list(groups.values())

    sum: int = 0
    for group in grouped_numbers:
        if len(group) == 2:
            sum += group[0] * group[1]

    print(sum)


if __name__ == '__main__':
    part_1()
    part_2()
