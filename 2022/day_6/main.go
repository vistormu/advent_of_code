package main

import (
    "io/ioutil"
    "fmt"
    "strings"
)

func hasUniqueChars(input string) bool {
    for _, c := range input {
        if strings.Count(input, string(c)) > 1 {
            return false
        }
    }
    return true
}

func getUniquePacketIndex(input string, length int) int {
    packet := input[:length]
    detected := false
    index := -1
    for !detected {
        index++
        packet = input[index:index+length]
        if hasUniqueChars(string(packet)) {
            detected = true
        }
    }
    return index + length
}

func main() {
    content, _ := ioutil.ReadFile("input.txt")

    fmt.Println(getUniquePacketIndex(string(content), 4))
    fmt.Println(getUniquePacketIndex(string(content), 14))
}
