import Foundation

func readFile(atPath path: String) -> String? {
    do {
        let contents = try String(contentsOfFile: path)
        return contents
    } catch {
        print("Unable to read file: \(error)")
        return nil
    }
}

func isDigit(_ char: Character) -> Bool {
    return char >= "0" && char <= "9"
}

func part1() {
    let contents = readFile(atPath: "input.txt")!
        let lines = contents.split(separator: "\n")

        var sum = 0
        for line in lines {
            var firstDigit = ""
                var lastDigit = ""
                var foundFirstDigit = false

                for char in line {
                    let isCharDigit = isDigit(char)
                        if isCharDigit && !foundFirstDigit {
                            firstDigit = String(char)
                                foundFirstDigit = true
                        } else if isCharDigit {
                            lastDigit = String(char)
                        }
                }

            if lastDigit == "" {
                lastDigit = firstDigit
            }

            sum += Int(firstDigit + lastDigit)!
        }

    print(sum)
}

func part2() {
    let contents = readFile(atPath: "input.txt")!
    let lines = contents.split(separator: "\n")
    
    let map = [
        "one": "one1one",
        "two": "two2two",
        "three": "three3three",
        "four": "four4four",
        "five": "five5five",
        "six": "six6six",
        "seven": "seven7seven",
        "eight": "eight8eight",
        "nine": "nine9nine",
    ]

    var sum = 0
    for line in lines {
        var newLine = String(line)
        for (key, value) in map {
            newLine = newLine.replacingOccurrences(of: key, with: value)
        }
        newLine = newLine.replacingOccurrences(of: "[^1-9]", with: "", options: .regularExpression)
        sum += Int(newLine.prefix(1) + newLine.suffix(1))!
    }
    print(sum)
}

part1()
part2()
