

def part_1() -> None:
    with open("input.txt") as f:
        lines: list[str] = f.read().splitlines()

    sum: int = 0
    for game, line in enumerate(lines):
        content: str = line.split(":")[1]
        sets: list[str] = content.split(";")
        sets = [set_.strip() for set_ in sets]

        balls: list[str] = []
        for set_ in sets:
            balls += set_.split(",")
        balls = [ball.strip() for ball in balls]

        possible: bool = True
        for ball in balls:
            color: str = ball.split(" ")[1]
            number: int = int(ball.split(" ")[0])

            if color == "red" and number > 12:
                possible = False
                break
            elif color == "green" and number > 13:
                possible = False
                break
            elif color == "blue" and number > 14:
                possible = False
                break

        if possible:
            sum += game + 1

    print(sum)


def part_2() -> None:
    with open("input.txt") as f:
        lines: list[str] = f.read().splitlines()

    sum: int = 0
    for line in lines:
        content: str = line.split(":")[1]
        sets: list[str] = content.split(";")
        sets = [set_.strip() for set_ in sets]

        balls: list[str] = []
        for set_ in sets:
            balls += set_.split(",")
        balls = [ball.strip() for ball in balls]

        max_red: int = 0
        max_green: int = 0
        max_blue: int = 0
        for ball in balls:
            color: str = ball.split(" ")[1]
            number: int = int(ball.split(" ")[0])

            if color == "red" and number > max_red:
                max_red = number
            elif color == "green" and number > max_green:
                max_green = number
            elif color == "blue" and number > max_blue:
                max_blue = number

        sum += max_red*max_green*max_blue

    print(sum)


if __name__ == "__main__":
    part_1()
    part_2()
