LOSS: int = 0
DRAW: int = 3
WIN: int = 6
ROCK: int = 1
PAPER: int = 2
SCISSORS: int = 3


def rock_paper_scissors(shape_1: int, shape_2: int) -> int:
    result: int = 0
    if shape_1 == shape_2:
        result = DRAW
    elif shape_1 - 1 == shape_2 or shape_1 == ROCK and shape_2 == SCISSORS:
        result = WIN

    return result

def inverse_rock_paper_scissors(result: int, oponent: int) -> int:
    shape: int = oponent
    if result == WIN:
        shape = oponent + 1
        if oponent == SCISSORS:
            shape = ROCK
    elif result == LOSS:
        shape = oponent - 1
        if oponent == ROCK:
            shape = SCISSORS

    return shape


def part_1() -> None:
    with open('2022/day_2/input.txt', 'r') as f:
        rounds: list[str] = f.readlines()

    letter_to_score: dict[str, int] = {
            "A": ROCK,
            "B": PAPER,
            "C": SCISSORS,
            "X": ROCK,
            "Y": PAPER,
            "Z": SCISSORS,
            }

    score: int = 0
    for round in rounds:
        oponent, me = map(letter_to_score.get, round.split())

        score += me + rock_paper_scissors(me, oponent) # type: ignore

    print(score)


def part_2() -> None:
    with open('2022/day_2/input.txt', 'r') as f:
        rounds: list[str] = f.readlines()

    letter_to_score: dict[str, int] = {
            "A": ROCK,
            "B": PAPER,
            "C": SCISSORS,
            }

    letter_to_result: dict[str, int] = {
            "X": LOSS,
            "Y": DRAW,
            "Z": WIN,
            }
    
    score: int = 0
    for round in rounds:
        oponent, me = round.split()

        oponent = letter_to_score[oponent]
        me = letter_to_result[me]

        score += me + inverse_rock_paper_scissors(me, oponent)

    print(score)


if __name__ == "__main__":
    part_1()
    part_2()
