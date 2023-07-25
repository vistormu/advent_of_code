package main

import(
    "fmt"
    "io/ioutil"
    "strings"
    "strconv"
    "sort"
)


func main() {
    // Open file
    content, error := ioutil.ReadFile("input.txt")
    if error != nil {
        panic(error)    
    }

    elves := strings.Split(string(content), "\n\n")
    var calories []int
    for _, elf := range elves { 
        caloriesInElf := strings.Split(elf, "\n")
        totalCalories := 0
        for _, calorieString := range caloriesInElf {
            calorieInt, _ := strconv.Atoi(calorieString)
            totalCalories += calorieInt
        }
        calories = append(calories, totalCalories)
    }
    sort.Ints(calories)
    
    // Part 1
    fmt.Println(calories[len(calories) - 1])

    // Part 2
    fmt.Println(calories[len(calories) - 1] + calories[len(calories) - 2] + calories[len(calories) - 3])
}
