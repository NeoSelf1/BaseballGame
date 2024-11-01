Swift로 구현한 계산기 프로젝트입니다. 객체지향 프로그래밍 원칙을 따르며, 프로토콜을 활용한 확장 가능한 구조를 가지고 있습니다.

주요 기능
- 기본 사칙연산 (덧셈, 뺄셈, 곱셈, 나눗셈)
- 나머지 연산
- 예외 처리 (0으로 나누기, 오버플로우, 잘못된 입력)

프로젝트 구조
- AbstractOperation: 모든 연산의 기본 프로토콜
- calculate(_ a: Double, _ b: Double) throws -> Double

에러 처리
```
swiftCopyenum CalculatorError: Error {
    case divisionByZero    // 0으로 나누기 시도
    case invalidInput      // 잘못된 입력
    case overflow         // 결과값 오버플로우
}
```

연산 클래스들
- AddOperation: 덧셈
- SubtractOperation: 뺄셈
- MultiplyOperation: 곱셈
- DivideOperation: 나눗셈
- RemainderOperation: 나머지

사용 예시
```
let calculator = Calculator()

do {
    try print("10 + 5 =", calculator.calculate(10, 5, operation: "+"))
    try print("10 - 5 =", calculator.calculate(10, 5, operation: "-"))
    try print("10 * 5 =", calculator.calculate(10, 5, operation: "*"))
    try print("10 / 5 =", calculator.calculate(10, 5, operation: "/"))
    try print("10 % 3 =", calculator.calculate(10, 3, operation: "%"))
} catch {
    // 에러 처리
}
```

에러 처리 예시
```
do {
    try calculator.calculate(10, 0, operation: "/")  // 0으로 나누기 시도
} catch CalculatorError.divisionByZero {
    print("오류: 0으로 나눌 수 없습니다.")
}
```
특징
- 프로토콜 기반 설계로 새로운 연산 추가가 용이
- 각 연산이 독립적인 클래스로 구현되어 유지보수가 쉬움
- Double 타입 사용으로 소수점을 포함한 결과값을 출력할 수 있음
