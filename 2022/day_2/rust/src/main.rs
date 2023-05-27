static ROCK: u8 = 1;
static PAPER: u8 = 2;
static SCISSORS: u8 = 3;
static LOSS: u8 = 0;
static DRAW: u8 = 3;
static WIN: u8 = 6;


fn rock_paper_scissors(me: u8, oponent: u8) -> u8 {
    let mut result: u8 = LOSS;
    if me == oponent {
        result = DRAW;
    } else if (me-1 == oponent) || (me == ROCK && oponent == SCISSORS) {
        result = WIN;
    } else {}

    return result;
}

fn inverse_rock_paper_scissors(oponent: u8, result: u8) -> u8 {
    let mut shape: u8 = oponent;
    if result == WIN {
        shape = oponent + 1;
        if oponent == SCISSORS {
            shape = ROCK;
        }
    } else if result == LOSS {
        shape = oponent - 1;
        if oponent == ROCK {
            shape = SCISSORS;
        }
    }
    return shape;
}


fn part_1() {
    let content: &str = include_str!("../../input.txt");

    let rounds: Vec<&str> = content
        .trim()
        .split("\n")
        .collect();

    let letter_to_score = |letter: &str| -> u8 {
        let mut score: u8 = 0;
        match letter {
            "A" => score = ROCK,
            "B" => score = PAPER,
            "C" => score = SCISSORS,
            "X" => score = ROCK,
            "Y" => score = PAPER,
            "Z" => score = SCISSORS,
            _ => println!("Error: {} is not a valid letter", letter),
        }
        return score;
    };
    
    let mut score: i32 = 0;
    for round in rounds {
        let oponent_and_me: Vec<u8> = round
            .split(" ")
            .map(|x| letter_to_score(x))
            .collect();

        let oponent: u8 = oponent_and_me[0];
        let me: u8 = oponent_and_me[1];

        score += rock_paper_scissors(me, oponent) as i32 + me as i32;
    }

    println!("Score: {}", score);
}

fn part_2() {
    let content: &str = include_str!("../../input.txt");

    let rounds: Vec<&str> = content
        .trim()
        .split("\n")
        .collect();

    let letter_to_score = |letter: &str| -> u8 {
        let mut score: u8 = 0;
        match letter {
            "A" => score = ROCK,
            "B" => score = PAPER,
            "C" => score = SCISSORS,
            _ => println!("Error: {} is not a valid letter", letter),
        }
        return score;
    };

    let letter_to_result = |letter: &str| -> u8 {
        let mut result: u8 = LOSS;
        match letter {
            "X" => result = LOSS,
            "Y" => result = DRAW,
            "Z" => result = WIN,
            _ => println!("Error: {} is not a valid letter", letter),
        }
        return result;
    };
    
    let mut score: i32 = 0;
    for round in rounds {
        let oponent_and_result: Vec<&str> = round.split(" ").collect();

        let oponent: u8 = letter_to_score(oponent_and_result[0]);
        let result: u8 = letter_to_result(oponent_and_result[1]);

        score += inverse_rock_paper_scissors(oponent, result) as i32 + result as i32;
    }

    println!("Score: {}", score);
}

fn main(){
    part_1();
    part_2();
}
