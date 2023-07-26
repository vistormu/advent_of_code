def main() -> None:
    with open("input.txt") as file:
        message: str = file.read()

    detected: bool = False
    packet: str = ""
    index: int = -1
    while not detected and index < len(message) - 3:
        index += 1
        packet: str = message[index:index + 4]
        if len(packet) == len(set(packet)):
            detected = True

    print(f"First packet with all unique characters: {packet} with index {index + 4}")

    detected: bool = False
    packet: str = ""
    index: int = -1
    while not detected and index < len(message) - 13:
        index += 1
        packet: str = message[index:index + 14]
        if len(packet) == len(set(packet)):
            detected = True

    print(f"First packet with all unique characters: {packet} with index {index + 14}")


if __name__ == '__main__':
    main()
