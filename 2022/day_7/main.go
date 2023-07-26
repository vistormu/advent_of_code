package main

import (
    "io/ioutil"
    "fmt"
    "strings"
)

func isNumber(c byte) bool {
    return c >= '0' && c <= '9'
}

func main() {
    content, _ := ioutil.ReadFile("input.txt")
    lines := strings.Split(string(content), "\n")

    dir := ""
    for _, line := range lines {
        if strings.Contains(line, "cd") {
            dir = strings.Split(line, "$ cd ")[1]
        }
        fmt.Println(dir)
    }
}
