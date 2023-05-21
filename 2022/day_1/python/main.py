import time


def main() -> None:
    with open('2022/day_1/input.txt') as file:
        data: str = file.read().strip()

    elves: list[str] = data.split('\n\n')
    calories: list[int] = [sum(map(int, elf.split('\n'))) for elf in elves]

    print(f'Part 1: {max(calories)}')
    print(f'Part 2: {sum(sorted(calories)[-3:])}')


if __name__ == "__main__":
    start: float = time.time()
    main()
    end: float = time.time()

    print(f'Elapsed time: {(end - start) * 1000: .2f} ms')
