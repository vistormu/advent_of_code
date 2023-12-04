package main

import (
    "fmt"
    "os"
    "strings"
    "strconv"
)

func part1() {
    content, err := os.ReadFile("input.txt")
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
    lines := strings.Split(string(content), "\n")
    lines = lines[:len(lines)-1]

    sum := 0
    for _, line := range lines {
        firstDigit := ""
        lastDigit := ""
        firstDigitFound := false
        for _, char := range line {
            if isDigit(char) && !firstDigitFound {
                firstDigit = string(char)
                firstDigitFound = true
            } else if isDigit(char) {
                lastDigit = string(char)
            }
        }
        if lastDigit == "" {
            lastDigit = firstDigit
        }

        conbinedDigits, _ := strconv.Atoi(firstDigit + lastDigit)
        sum += conbinedDigits
    }

    fmt.Println(sum)
}

func part2() {
    content, err := os.ReadFile("input.txt")
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
    lines := strings.Split(string(content), "\n")
    lines = lines[:len(lines)-1]

    textToDigit := map[string]string{
        "one": "one1one",
        "two": "two2two",
        "three": "three3three",
        "four": "four4four",
        "five": "five5five",
        "six": "six6six",
        "seven": "seven7seven",
        "eight": "eight8eight",
        "nine": "nine9nine",
    }

    sum := 0
    for _, line := range lines {
        for word, digit := range textToDigit {
            line = strings.ReplaceAll(line, word, digit)
        }

        line = strings.Map(func(r rune) rune {
            if isDigit(r) {
                return r
            }
            return -1
        }, line)

        combinedDigits, _ := strconv.Atoi(string(line[0]) + string(line[len(line)-1]))
        sum += combinedDigits
    }

    fmt.Println(sum)
}

func isDigit(char rune) bool {
    return char >= '0' && char <= '9'
}

func main() {
    part1()
    part2()
}
