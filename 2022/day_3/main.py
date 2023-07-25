import string


def tokenize(letter: str) -> list[int]:
    mapping: dict[str, int] = {letter: i+1 for i, letter in enumerate(string.ascii_lowercase)}
    mapping.update({letter: len(mapping)+i+1 for i, letter in enumerate(string.ascii_uppercase)})

    return [mapping[letter] for letter in letter]


def part_1() -> None:
    with open('input.txt', 'r') as f:
        supplies: list[list[int]] = [tokenize(rucksack) for rucksack in f.read().splitlines()]

    intersection: list[int] = []
    for rucksack in supplies:
        intersection += list(set(rucksack[:len(rucksack)//2]) & set(rucksack[len(rucksack)//2:]))

    print(sum(intersection))


def part_2() -> None:
    with open('input.txt', 'r') as f:
        supplies: list[list[int]] = [tokenize(rucksack) for rucksack in f.read().splitlines()]

    intersection: list[int] = []
    group: list[list[int]] = []
    for rucksack in supplies:
        group.append(rucksack)

        if len(group) < 3:
            continue

        intersection += list(set(group[0]) & set(group[1]) & set(group[2]))
        group = []

    print(sum(intersection))


if __name__ == "__main__":
    part_1()
    part_2()
