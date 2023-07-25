def main() -> None:
    with open('input.txt') as f:
        content: str = f.read()

    crate_rows: list[str] = content.split('\n\n')[0].splitlines()[:-1]
    moves: str = content.split('\n\n')[1]

    print('\n'.join(crate_rows))
    print('\n')

    stacks: list[list[str]] = []
    for row in crate_rows:
        crates: list[str] = row.split(' ')
        for j, crate in enumerate(crates):
            if not crate:
                crates[j] = 'XXX'
                for _ in range(3):
                    crates.pop(j+1)

        stacks.append(crates)

    stacks = [list(reversed(x)) for x in zip(*stacks)]
    stacks_9000: list[list[str]] = [list(filter(lambda x: x != 'XXX', stack)) for stack in stacks]
    stacks_9001: list[list[str]] = [list(filter(lambda x: x != 'XXX', stack)) for stack in stacks]

    print('\n'.join([' '.join(stack) for stack in stacks_9000]))
    print('\n')

    for move in moves.splitlines():
        number_of_crates: int = int(move.split(' ')[1])
        from_stack: int = int(move.split(' ')[3]) - 1
        to_stack: int = int(move.split(' ')[5]) - 1

        stacks_9000[to_stack].extend(list(reversed(stacks_9000[from_stack][-number_of_crates:])))
        stacks_9001[to_stack].extend(list(stacks_9001[from_stack][-number_of_crates:]))

        for _ in range(number_of_crates):
            stacks_9000[from_stack].pop(-1)
            stacks_9001[from_stack].pop(-1)

    print(' '.join([stack[-1] for stack in stacks_9000]))
    print(' '.join([stack[-1] for stack in stacks_9001]))


if __name__ == "__main__":
    main()
