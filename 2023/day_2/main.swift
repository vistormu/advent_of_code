import Foundation

func part1() {
    let content = try! String(contentsOfFile: "input.txt")
    var lines = content.components(separatedBy: "\n")
    lines.removeLast()
    
    var sum = 0
    for (game, line) in lines.enumerated() {
        let content = line.components(separatedBy: ":")[1]
        var sets = content.components(separatedBy: ";")
        sets = sets.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        var balls = [String]()
        for set in sets {
            balls.append(contentsOf: set.components(separatedBy: ","))
        }
        balls = balls.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        var possible = true
        for ball in balls {
            let color = ball.components(separatedBy: " ")[1]
            let number = Int(ball.components(separatedBy: " ")[0])!

            if color == "red" && number > 12 {
                possible = false
                break
            } else if color == "green" && number > 13 {
                possible = false
                break
            } else if color == "blue" && number > 14 {
                possible = false
                break
            }
        }

        if possible {
            sum += 1 + game
        }
    }
    print(sum)
}

func part2() {
    let content = try! String(contentsOfFile: "input.txt")
    var lines = content.components(separatedBy: "\n")
    lines.removeLast()
    
    var sum = 0
    for line in lines {
        let content = line.components(separatedBy: ":")[1]
        var sets = content.components(separatedBy: ";")
        sets = sets.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }

        var balls = [String]()
        for set in sets {
            balls.append(contentsOf: set.components(separatedBy: ","))
        }
        balls = balls.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        var maxRed = 0
        var maxGreen = 0
        var maxBlue = 0
        for ball in balls {
            let color = ball.components(separatedBy: " ")[1]
            let number = Int(ball.components(separatedBy: " ")[0])!

            if color == "red" && number > maxRed {
                maxRed = number
            } else if color == "green" && number > maxGreen {
                maxGreen = number
            } else if color == "blue" && number > maxBlue {
                maxBlue = number
            }
        }

        sum += maxRed * maxGreen * maxBlue
    }
    print(sum)
}

part1()
part2()
