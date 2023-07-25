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

    subsetCounter := 0
    overlapCounter := 0
    for _, pair := range strings.Split(string(content), "\n") {
        if pair == "" {
            continue
        }
        elfPair := strings.Split(pair, ",")
        
        assignment1 := strings.Split(elfPair[0], "-")
        assignment2 := strings.Split(elfPair[1], "-")

        a1S, _ := strconv.Atoi(assignment1[0])
        a1E, _ := strconv.Atoi(assignment1[1])
        a2S, _ := strconv.Atoi(assignment2[0])
        a2E, _ := strconv.Atoi(assignment2[1])

        if (a1S <= a2S && a1E >= a2E) || (a1S >= a2S && a1E <= a2E) {
            subsetCounter++
        }
        if (a1S <= a2S && a1E >= a2S) || (a1S >= a2S && a1S <= a2E) {
            overlapCounter++
        }
    }

    fmt.Println("Number of subsets:", subsetCounter)
    fmt.Println("Number of overlaps:", overlapCounter)
}
