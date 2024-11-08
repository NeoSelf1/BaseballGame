//
//  BaseballGame.swift
//  BaseballGame
//
//  Created by Neoself on 11/8/24.
//

struct BaseballGame {
    private var gameHistory: [Int] = []
    
    mutating func start() {
        var sessionOver = false
        
        print("환영합니다! 원하시는 번호를 입력해주세요")
        
        while !sessionOver {
            print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
            guard let choice = readLine(), let menuNumber = Int(choice) else {
                print("올바른 숫자를 입력해주세요!")
                continue
            }
            
            switch menuNumber {
            case 1:
                playGame()
            case 2:
                showGameHistory()
            case 3:
                print("< 숫자 야구 게임을 종료합니다 >")
                gameHistory = []
                sessionOver = true
            default:
                print("올바른 숫자를 입력해주세요!",terminator: "")
            }
        }
    }
    
    private mutating func playGame() {
        let answer = makeAnswer()
        var attempts = 0
        var gameOver = false
        
        print("< 게임을 시작합니다 >")
        
        while !gameOver {
            print("숫자를 입력하세요: ",terminator: "")
            guard let input = readLine(),
                  isValidInput(input) else {
                print("올바르지 않은 입력값입니다")
                continue
            }
            
            attempts += 1
            let (strike, ball) = checkNumber(input, against: answer)
            
            if strike == 3 {
                print("정답입니다! \(answer)")
                gameHistory.append(attempts)
                gameOver = true
            } else if strike == 0 && ball == 0 {
                print("Nothing")
            } else {
                var result = ""
                if strike > 0 { result += "\(strike)스트라이크 " }
                if ball > 0 { result += "\(ball)볼" }
                print(result.trimmingCharacters(in: .whitespaces))
            }
        }
    }
    
    private func showGameHistory() {
        print("\n< 게임 기록 보기 >")
        if gameHistory.isEmpty {
            print("아직 게임 기록이 없습니다.")
            return
        }
        
        for (index, attempts) in gameHistory.enumerated() {
            print("\(index + 1)번째 게임 : 시도 횟수 - \(attempts)")
        }
    }
    
    // Lv 3
    private func makeAnswer() -> String {
        var nonZeroDigits = Array(1...9).map { String($0) }
        let zeroDigit = ["0"]
        
        nonZeroDigits.shuffle()
        let firstDigit = nonZeroDigits.removeFirst()
        
        var remainingDigits = nonZeroDigits + zeroDigit
        remainingDigits.shuffle()
        let remainingTwoDigits = remainingDigits[0...1]
        
        return firstDigit + remainingTwoDigits.joined()
    }
    
    private func isValidInput(_ input: String) -> Bool {
        guard let number = Int(input), number >= 100 && number <= 999 else { return false }
        let strArr = Array(input)
        let uniqueDigits = Set(strArr)
        
        return uniqueDigits.count == 3 && !strArr.contains("0")
    }
    
    private func checkNumber(_ input: String, against answer: String) -> (strike: Int, ball: Int) {
        let strArr = Array(input)
        let ansArr = Array(answer)
        
        var strikes = 0
        var balls = 0
        
        for i in 0..<3 {
            if strArr[i] == ansArr[i] {
                strikes += 1
            } else if ansArr.contains(strArr[i]) {
                balls += 1
            }
        }
        
        return (strikes, balls)
    }
}
