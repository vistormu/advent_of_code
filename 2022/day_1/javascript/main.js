const fs = require('fs');


function main() {
    console.time('main');
    const data = fs.readFileSync('2022/day_1/input.txt', 'utf8');
    const elves = data.split('\n\n');
    
    const calories = [];
    for (const elf of elves) {
        calories.push(elf.split('\n').reduce((acc, curr) => +acc + +curr, 0));
    }
    
    // Part 1
    console.log(Math.max(...calories));
    
    // Part 2
    sortedCalories = calories.sort((a, b) => b - a);
    console.log(sortedCalories[0] + sortedCalories[1] + sortedCalories[2]);

    console.timeEnd('main');
}

main();
