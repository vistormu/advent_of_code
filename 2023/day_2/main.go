package main

import (
    "fmt"
    "os"
    "strings"
    "strconv"
)

func part_1() {
    content, err := os.ReadFile("input.txt")
    if err != nil {
        panic(err)
    }
    lines := strings.Split(string(content), "\n")
    lines = lines[:len(lines)-1]

    sum := 0
    for game, line := range lines {
        content := strings.Split(line, ":")[1]
        sets := strings.Split(content, ";")
        
        var balls []string
        for _, set := range sets {
            balls = append(balls, strings.Split(set, ",")...)
        }
        for i, ball := range balls {
            balls[i] = strings.TrimSpace(ball)
        }
        
        possible := true
        for _, ball := range balls {
            number, err := strconv.Atoi(strings.Split(ball, " ")[0])
            if err != nil {
                panic(err)
            }
            color := strings.Split(ball, " ")[1]
            
            if color == "red" && number > 12 {
                possible = false
                break
            } else if color == "green" && number > 13 {
                possible = false
                break
            } else if color == "blue" && number > 14 {
                possible = false
                break
            }
        }

        if possible {
            sum += game + 1
        }
    }
    fmt.Println(sum)
}

func part_2() {
    content, err := os.ReadFile("input.txt")
    if err != nil {
        panic(err)
    }
    lines := strings.Split(string(content), "\n")
    lines = lines[:len(lines)-1]

    sum := 0
    for _, line := range lines {
        content := strings.Split(line, ":")[1]
        sets := strings.Split(content, ";")
        
        var balls []string
        for _, set := range sets {
            balls = append(balls, strings.Split(set, ",")...)
        }
        for i, ball := range balls {
            balls[i] = strings.TrimSpace(ball)
        }
        
        maxRed := 0
        maxGreen := 0
        maxBlue := 0
        for _, ball := range balls {
            number, err := strconv.Atoi(strings.Split(ball, " ")[0])
            if err != nil {
                panic(err)
            }
            color := strings.Split(ball, " ")[1]

            if color == "red" && number > maxRed {
                maxRed = number
            } else if color == "green" && number > maxGreen {
                maxGreen = number
            } else if color == "blue" && number > maxBlue {
                maxBlue = number
            }
        }
        sum += maxRed * maxGreen * maxBlue
    }
    fmt.Println(sum)
}

func main() {
    part_1()
    part_2()
}
