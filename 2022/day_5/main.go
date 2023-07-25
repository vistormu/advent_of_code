package main

import (
    "fmt"
    "io/ioutil"
    "strings"
    "strconv"
)

func main() {
    content, error := ioutil.ReadFile("input.txt")
    if error != nil {
        fmt.Println("file not found")
        panic(error)
    }

    var stackRows []string = strings.Split(strings.Split(string(content), "\n\n")[0], "\n")
    stackRows = stackRows[:len(stackRows)-1]
    moves := strings.Split(strings.Split(string(content), "\n\n")[1], "\n")
    moves = moves[:len(moves)-1]

    for _, row := range stackRows {
        fmt.Println(row)
    }
    fmt.Println()

    var stack [][]string
    for _, row := range stackRows {
        var crates []string = strings.Split(row, " ")
        for j, crate := range crates {
            if crate == "" {
                crates = append(crates[:j], crates[j+3:]...)
                crates[j] = "XXX"
            }
            if j == len(crates)-1 {
                break
            }
        }
        stack = append(stack, crates)
    }

    for _, row := range stack {
        fmt.Println(row)
    }
    fmt.Println()

    rows := len(stack)
    cols := len(stack[0])
    transposedStack := make([][]string, cols)
    for i := range transposedStack {
        transposedStack[i] = make([]string, rows)
    }

    for i := 0; i < rows; i++ { 
        for j := 0; j < cols; j++ {
            transposedStack[j][i] = stack[i][j]
        }
    }
    
    for i, row := range transposedStack {
        for i, j := 0, len(row)-1; i < j; i, j = i+1, j-1 {
            row[i], row[j] = row[j], row[i]
        }
        for j, crate := range row {
            if crate == "XXX" {
                transposedStack[i] = row[:j]
                break
            }
        }
    }

    for _, row := range transposedStack {
        fmt.Println(row)
    }
    fmt.Println()

    stacks9000 := make([][]string, len(transposedStack))
    for i, row := range transposedStack {
        stacks9000[i] = make([]string, len(row))
        copy(stacks9000[i], row)
    }
    stacks9001 := transposedStack

    for _, move := range moves {
        instructions := strings.Split(move, " ")
        nCrates, _ := strconv.Atoi(instructions[1])
        fromStack, _ := strconv.Atoi(instructions[3])
        fromStack--
        toStack, _ := strconv.Atoi(instructions[5])
        toStack--

        stackToTakeFrom := stacks9000[fromStack]
        takenCrates := stackToTakeFrom[len(stackToTakeFrom)-nCrates:]
        reversedTakenCrates := make([]string, len(takenCrates))
        for i := 0; i < len(reversedTakenCrates); i++ {
            reversedTakenCrates[i] = takenCrates[len(takenCrates)-i-1]
        }
        stacks9000[fromStack] = stackToTakeFrom[:len(stackToTakeFrom)-nCrates]
        stackToPutOn := stacks9000[toStack]
        stacks9000[toStack] = append(stackToPutOn, reversedTakenCrates...)
    }

    for _, row := range stacks9000 {
        fmt.Printf(row[len(row)-1])
    }
    fmt.Println()

    for _, move := range moves {
        instructions := strings.Split(move, " ")
        nCrates, _ := strconv.Atoi(instructions[1])
        fromStack, _ := strconv.Atoi(instructions[3])
        fromStack--
        toStack, _ := strconv.Atoi(instructions[5])
        toStack--

        stackToTakeFrom := stacks9001[fromStack]
        takenCrates := stackToTakeFrom[len(stackToTakeFrom)-nCrates:]
        stacks9001[fromStack] = stackToTakeFrom[:len(stackToTakeFrom)-nCrates]
        stackToPutOn := stacks9001[toStack]
        stacks9001[toStack] = append(stackToPutOn, takenCrates...)
    }

    for _, row := range stacks9001 {
        fmt.Printf(row[len(row)-1])
    }
    fmt.Println()

}
