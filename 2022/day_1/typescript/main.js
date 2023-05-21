"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var fs = require("fs");
function main() {
    console.time('main');
    var data = fs.readFileSync('2022/day_1/input.txt', 'utf8');
    var elves = data.split('\n\n');
    var calories = [];
    for (var _i = 0, elves_1 = elves; _i < elves_1.length; _i++) {
        var elf = elves_1[_i];
        calories.push(elf.split('\n').reduce(function (acc, curr) { return +acc + +curr; }, 0));
    }
    // Part 1
    console.log(Math.max.apply(Math, calories));
    // Part 2
    sortedCalories = calories.sort(function (a, b) { return b - a; });
    console.log(sortedCalories[0] + sortedCalories[1] + sortedCalories[2]);
    console.timeEnd('main');
}
main();
