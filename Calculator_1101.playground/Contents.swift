// MARK: - 프로토콜
protocol AbstractOperation {
    func calculate(_ a: Double, _ b: Double) throws -> Double
}


// MARK: - 에러 관련 Enum
enum CalculatorError: Error {
    case divisionByZero
    case invalidInput
    case overflow
}

// MARK: - Operation 프로토콜을 채택한 연산 클래스들

class AddOperation: AbstractOperation {
    func calculate(_ a: Double, _ b: Double) throws -> Double {
        let result = a + b
        if result.isInfinite { throw CalculatorError.overflow }
        return result
    }
}

class SubtractOperation: AbstractOperation {
    func calculate(_ a: Double, _ b: Double) throws -> Double {
        let result = a - b
        if result.isInfinite { throw CalculatorError.overflow }
        return result
    }
}

class MultiplyOperation: AbstractOperation {
    func calculate(_ a: Double, _ b: Double) throws -> Double {
        let result = a * b
        if result.isInfinite { throw CalculatorError.overflow }
        return result
    }
}

class DivideOperation: AbstractOperation {
    func calculate(_ a: Double, _ b: Double) throws -> Double {
        guard b != 0 else { throw CalculatorError.divisionByZero }
        let result = a / b
        if result.isInfinite { throw CalculatorError.overflow }
        return result
    }
}

class RemainderOperation: AbstractOperation {
    func calculate(_ a: Double, _ b: Double) throws -> Double {
        guard b != 0 else { throw CalculatorError.divisionByZero }
        return a.truncatingRemainder(dividingBy: b)
    }
}

// MARK: - Calculator Class

class Calculator {
    // 연산자 저장 프로퍼티
    private let operations: [String: AbstractOperation]
    
    // 초기화
    init() {
        operations = [
            "+": AddOperation(),
            "-": SubtractOperation(),
            "*": MultiplyOperation(),
            "/": DivideOperation(),
            "%": RemainderOperation()
        ]
    }
    
    func calculate(_ a: Double, _ b: Double, operation: String) throws -> Double {
        guard let operation = operations[operation] else {
            throw CalculatorError.invalidInput
        }
        return try operation.calculate(a, b)
    }
}

// 테스트 함수
func testCalculator() {
    let calculator = Calculator()
    do {
        // 기본 연산 테스트
        try print("10 + 5 =", calculator.calculate(10, 5, operation: "+"))
        try print("10 - 5 =", calculator.calculate(10, 5, operation: "-"))
        try print("10 * 5 =", calculator.calculate(10, 5, operation: "*"))
        try print("10 / 5 =", calculator.calculate(10, 5, operation: "/"))
        
        // 나머지 연산 테스트
        try print("10 % 3 =", calculator.calculate(10, 3, operation: "%"))
        
        // 예외 상황
//        try print(calculator.calculate(10, 0, operation: "/"))  // 0으로 나누기
//        try print(calculator.calculate(10, 0, operation: "bibim-myun"))  // 비빔면 연산하기
//        try print(calculator.calculate(10, .infinity, operation: "*"))  // .infinity 곱하기
        
    } catch CalculatorError.divisionByZero {
        print("오류: 0으로 나눌 수 없습니다.")
    } catch CalculatorError.invalidInput {
        print("오류: 잘못된 입력값입니다.")
    } catch CalculatorError.overflow {
        print("오류: 계산 결과가 너무 큽니다.")
    } catch {
        print("알 수 없는 오류가 발생했습니다.")
    }
}

// 테스트 실행
testCalculator()
