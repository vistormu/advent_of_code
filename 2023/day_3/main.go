package main


import (
    "fmt"
    "os"
    "strings"
    "strconv"
)

func isDigit(s string) bool {
    switch s {
    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
        return true
    }
    return false
}

func getEightNeighbors(matrix [][]string, i, j int) []string {
    neighbors := make([]string, 0)
    for k := i-1; k <= i+1; k++ {
        for l := j-1; l <= j+1; l++ {
            if k == i && l == j {
                continue
            }
            if k < 0 || k >= len(matrix) || l < 0 || l >= len(matrix[0]) {
                continue
            }
            neighbors = append(neighbors, matrix[k][l])
        }
    }
    return neighbors
}

func part1() {
    content, err := os.ReadFile("input.txt")
    if err != nil {
        fmt.Println("Error reading file")
        return
    }
    lines := strings.Split(string(content), "\n")
    lines = lines[:len(lines)-1]
    matrix := make([][]string, len(lines))
    for i, line := range lines {
        matrix[i] = strings.Split(line, "")
    }

    listOfNumbers := make([]int, 0)
    number := ""
    symbols := make([]string, 0)
    for i, row := range matrix {
        for j, element := range row {
            if !isDigit(element) {
                if number != "" && len(symbols) > 0 {
                    numberInt, _ := strconv.Atoi(number)
                    listOfNumbers = append(listOfNumbers, numberInt)
                }
                number = ""
                symbols = make([]string, 0)
                continue
            }
            number += element
            neighbors := getEightNeighbors(matrix, i, j)
            symbols = append(symbols, neighbors...)
            for k := 0; k < len(symbols); k++ {
                if symbols[k] == "." || isDigit(symbols[k]) {
                    symbols = append(symbols[:k], symbols[k+1:]...)
                    k--
                }
            }
        }
    }
    if number != "" && len(symbols) > 0 {
        numberInt, _ := strconv.Atoi(number)
        listOfNumbers = append(listOfNumbers, numberInt)
    }
    sum := 0
    for _, number := range listOfNumbers {
        sum += number
    }
    fmt.Println(sum)
}

func getAsteriskNeighbor(matrix [][]string, i, j int) (int, int) {
    for k := i-1; k <= i+1; k++ {
        for l := j-1; l <= j+1; l++ {
            if k == i && l == j {
                continue
            }
            if k < 0 || k >= len(matrix) || l < 0 || l >= len(matrix[0]) {
                continue
            }
            if matrix[k][l] == "*" {
                return k, l
            }
        }
    }
    return -1, -1
}

func part2() {
    content, err := os.ReadFile("input.txt")
    if err != nil {
        fmt.Println("Error reading file")
        return
    }
    lines := strings.Split(string(content), "\n")
    lines = lines[:len(lines)-1]
    matrix := make([][]string, len(lines))
    for i, line := range lines {
        matrix[i] = strings.Split(line, "")
    }

    number := ""
    coordinate := make([]int, 2)
    coordinates := make([][]int, 0)
    numbers := make([]int, 0)
    for i, row := range matrix {
        for j, element := range row {
            if !isDigit(element) {
                if number != "" && coordinate != nil {
                    numberInt, _ := strconv.Atoi(number)
                    numbers = append(numbers, numberInt)
                    coordinates = append(coordinates, coordinate)
                }
                number = ""
                coordinate = make([]int, 2)
                continue
            }
            number += element
            asteriskI, asteriskJ := getAsteriskNeighbor(matrix, i, j)
            if asteriskI != -1 && asteriskJ != -1 {
                coordinate[0] = asteriskI
                coordinate[1] = asteriskJ
            }
        }
    }
    if number != "" && coordinate != nil {
        numberInt, _ := strconv.Atoi(number)
        numbers = append(numbers, numberInt)
        coordinates = append(coordinates, coordinate)
    }
    
    groups := make(map[[2]int][]int)

	// Step 2: Iterate through the lists
	for idx, coord := range coordinates {
		num := numbers[idx]
		groups[[2]int{coord[0], coord[1]}] = append(groups[[2]int{coord[0], coord[1]}], num)
	}

	// Step 3: Extract the lists
	groupedNumbers := make([][]int, 0, len(groups))
	for _, nums := range groups {
		groupedNumbers = append(groupedNumbers, nums)
	}

    sum := 0
    for _, group := range groupedNumbers {
        if len(group) == 2 {
            sum += group[0] * group[1]
        }
    }
    fmt.Println(sum)
}

func main() {
    part1()
    part2()
}
