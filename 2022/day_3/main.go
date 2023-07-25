package main

import (
    "fmt"
    "io/ioutil"
    "strings"
)

func Tokenize(input string) []int {
    tokenizer := make(map[rune]int)

    for i, char := range "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" {
        tokenizer[char] = i+1
    }
    
    tokens := make([]int, 0)
    for _, char := range input {
        tokens = append(tokens, tokenizer[char])
    }
    
    return tokens
}

func IsInSlice(item int, slice []int) bool {
    for _, slice_item := range slice {
        if item == slice_item {
            return true
        }
    }
    return false
}

func GetIntersection(first []int, second []int) []int {
    intersection := make([]int, 0)
    for _, first_item := range first {
        for _, second_item := range second {
            if first_item == second_item && !IsInSlice(first_item, intersection) {
                intersection = append(intersection, first_item)
            }
        }
    }
    return intersection
}

func part_1() {
    content, error := ioutil.ReadFile("input.txt")
    if error != nil {
        fmt.Println("file not found")
        panic(error)
    }

    supplies := strings.Split(strings.TrimSpace(string(content)), "\n")

    intersection := make([]int, 0)
    for _, rucksack := range supplies {
        tokens := Tokenize(rucksack)

        first_compartment := tokens[:len(tokens)/2]
        second_compartment := tokens[len(tokens)/2:]

        repeated := GetIntersection(first_compartment, second_compartment)

        intersection = append(intersection, repeated...)
    }
    
    sum := 0
    for _, item := range intersection {
        sum += item
    }
    fmt.Println(sum)
}

func part_2() {
    content, error := ioutil.ReadFile("input.txt")
    if error != nil {
        fmt.Println("file not found")
        panic(error)
    }

    supplies := strings.Split(strings.TrimSpace(string(content)), "\n")

    intersection := make([]int, 0)
    group := make([][]int, 0)
    for _, rucksack := range supplies {
        group = append(group, Tokenize(rucksack))

        if len(group) != 3 {
            continue
        }

        first_intersection := GetIntersection(group[0], group[1])
        second_intersection := GetIntersection(first_intersection, group[2])

        intersection = append(intersection, second_intersection...)
        group = make([][]int, 0)
    }
    
    sum := 0
    for _, item := range intersection {
        sum += item
    }
    fmt.Println(sum)
}

func main() {
    part_1()
    part_2()
}
