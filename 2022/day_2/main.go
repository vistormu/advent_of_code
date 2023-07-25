package main

import (
    "fmt"
    "io/ioutil"
    "strings"
)

var LOSS = 0
var DRAW = 3
var WIN = 6
var ROCK = 1
var PAPER = 2
var SCISSORS = 3

func rockPaperScissors(oponent int, me int) int {
    result := 0
    if oponent == me {
        result = DRAW
    } else if (me - 1 == oponent) || (me == ROCK && oponent == SCISSORS) {
        result = WIN
    }
    return result
}

func inverseRockPaperScissors(oponent int, result int) int {
    shape := oponent
    if result == WIN {
        shape = oponent + 1
        if oponent == SCISSORS {
            shape = ROCK
        }
    } else if result == LOSS {
        shape = oponent - 1
        if oponent == ROCK {
            shape = SCISSORS
        }
    }
    return shape
}

func part1() {
    content, error := ioutil.ReadFile("input.txt")
    if error != nil {
        fmt.Println("file not found")
        panic(error)
    }

    letterToScore := map[string]int{
        "A": ROCK,
        "B": PAPER,
        "C": SCISSORS,
        "X": ROCK,
        "Y": PAPER,
        "Z": SCISSORS,
    }
    rounds := strings.Split(strings.TrimSpace(string(content)), "\n")

    score := 0
    for _, round := range rounds {
        round := strings.Split(round, " ")
        oponent, me := letterToScore[round[0]], letterToScore[round[1]]

        score += rockPaperScissors(oponent, me) + me
    }
    fmt.Println(score)
}

func part2() {
    content, error := ioutil.ReadFile("input.txt")
    if error != nil {
        fmt.Println("file not found")
        panic(error)
    }

    letterToScore := map[string]int{
        "A": ROCK,
        "B": PAPER,
        "C": SCISSORS,
    }
    letterToResult := map[string]int{
        "X": LOSS,
        "Y": DRAW,
        "Z": WIN,
    }
    rounds := strings.Split(strings.TrimSpace(string(content)), "\n")

    score := 0
    for _, round := range rounds {
        round := strings.Split(round, " ")
        oponent := letterToScore[round[0]]
        result := letterToResult[round[1]]

        score += inverseRockPaperScissors(oponent, result) + result

    }
    fmt.Println(score)
}

func main() {
    part1()
    part2()
}
