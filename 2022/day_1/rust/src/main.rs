fn main() {
    let contents: &str = include_str!("../../input.txt");
    let elves: Result<Vec<Vec<u64>>,_>  = contents
        .trim()
        .split("\n\n")
        .map(|lines| lines.lines().map(|s| s.parse()).collect())
        .collect();
    let elves = elves.unwrap();
    let mut calories: Vec<u64> = elves.iter().map(|nums| nums.iter().sum()).collect();

    calories.sort();
    
    // Part 1
    println!("Calories: {:?}", calories.last().unwrap());

    // Part 2
    println!("Part 2: {:?}", calories.iter().rev().take(3).sum::<u64>());
}
