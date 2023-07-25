use std::collections::HashSet;
use itertools::Itertools;

fn tokenize(input: &str) -> Vec<u32> {
    input.chars()
        .map(|c| match c {
            'a'..='z' => c as u32 - 'a' as u32 + 1,
            'A'..='Z' => c as u32 - 'A' as u32 + 27,
            _ => panic!("Invalid input"),
        })
    .collect()
}


fn part1() {
    let supplies: Vec<&str> = include_str!("../../input.txt")
        .trim()
        .lines()
        .collect();

    let result: u32 = supplies
        .iter()
        .map(|rucksack| {
            let tokens: Vec<u32> = tokenize(rucksack);
            let first_compartment: HashSet<&u32> = tokens[0..tokens.len()/2].iter().collect();
            let second_compartment: HashSet<&u32> = tokens[tokens.len()/2..tokens.len()].iter().collect();
            let intersection: u32 = **first_compartment.intersection(&second_compartment).next().unwrap();
            intersection
        }).sum();

    println!("{:?}", result);
}

fn part2() {
    let supplies: Vec<&str> = include_str!("../../input.txt")
        .trim()
        .lines()
        .collect();

    let result: HashSet<u32> = supplies
        .iter()
        .map(|rucksack| {
            let tokens: Vec<u32> = tokenize(rucksack);
            let hash_rucksack: HashSet<&u32> = tokens.iter().collect();
            hash_rucksack
        }).collect();

}

fn main() {
    part1();
    part2();
}
