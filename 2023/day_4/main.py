def main() -> None:
    with open("input.txt") as f:
        lines: list[str] = f.read().splitlines()

    matches: int = 0
    for line in lines:
        winners: list[str] = line.split("|")[0].strip().split(" ")
        winners = [x for x in winners if x][2:]

        hand: list[str] = line.split("|")[1].strip().split(" ")
        hand = [x for x in hand if x]

        card_matches: int = 0
        for winner in winners:
            if winner in hand:
                card_matches += 1

        if card_matches:
            matches += 2 ** (card_matches - 1)

    print(matches)


if __name__ == "__main__":
    main()
