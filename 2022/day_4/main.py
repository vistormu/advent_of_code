def main() -> None:
    with open('input.txt') as f:
        pairs: list[str] = f.read().splitlines()
    
    subset_counter: int = 0
    overlap_counter: int = 0
    for pair in pairs:
        elf_1, elf_2 = pair.split(',')
        elf_1_set: set[int] = set([int(x) for x in range(int(elf_1.split('-')[0]), int(elf_1.split('-')[1]) + 1)])
        elf_2_set: set[int] = set([int(x) for x in range(int(elf_2.split('-')[0]), int(elf_2.split('-')[1]) + 1)])

        if elf_1_set.issubset(elf_2_set) or elf_2_set.issubset(elf_1_set):
            subset_counter += 1

        if elf_1_set.intersection(elf_2_set):
            overlap_counter += 1
            

    print(f'Part 1. Number of subsets: {subset_counter}')
    print(f'Part 2. Number of overlaps: {overlap_counter}')



if __name__ == "__main__":
    main()
