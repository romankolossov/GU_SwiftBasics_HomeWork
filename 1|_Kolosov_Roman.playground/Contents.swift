// Роман Колосов
// rkolossov@mail.ru
// Задания к уроку №1 Основы язык Swift
//

import UIKit

// MARK: Задание 1. Сданное решение.
// Решение квадратного уравнения.
//
/*
func squareEquationSolver(coefficientA a : Double, coefficientB b: Double, coefficientC c : Double) -> (x1: Double?, x2: Double?) {
    
    var x1, x2 : Double?
    
    let discriminant = pow(b, Double(2)) - 4 * a * c
    
    if (a == 0) {
        x1 = -(c / b)
        x2 = nil
    } else if (discriminant > 0) {
        x1 = (-b + sqrt(discriminant)) / (2 * a)
        x2 = (-b - sqrt(discriminant)) / (2 * a)
    } else if (discriminant == 0) {
        x1 = -(b / (2 * a))
        x2 = nil
    } else {
        x1 = nil
        x2 = nil
    }
    
    return (x1, x2)
}


// Ввод коэффициентов квадратного уравнения ax2 + bx + c = 0
// Коэффициенты для проверки. Уравнение имеет два различных корня.
let a : Double = 5
let b : Double = 88
let c : Double = 8

// Коэффициенты для проверки. Уравнение имеет один корень.
//let a : Double = 1
//let b : Double = -6
//let c : Double = 9

// Коэффициенты для проверки. Уравнение не имеет действительных кореней.
//let a : Double = 5
//let b : Double = 3
//let c : Double = 7

print("Вычисление корней квадратного уравнения \(a)x2 + \(b)x + \(c) = 0")

let roots = squareEquationSolver(coefficientA: a, coefficientB: b, coefficientC: c)

//switch roots {
//case (_,_) where (roots.0 != nil) && (roots.1 != nil) :
//    print("Уравнение имеет два различных корня:")
//    print("x1 = \(roots.0!)\nx2 = \(roots.1!)")
//case (_,nil) where (roots.0 != nil) :
//     print("Уравнение имеет один корень:")
//     print("x1 = \(roots.0!)")
//default:
//    print("Уравнение не имеет действительных корней.")
//}


if (roots.x1 != nil) && (roots.x2 != nil) {
    print("Уравнение имеет два различных корня:")
    print("x1 = \(roots.x1!)\nx2 = \(roots.x2!)")
} else if (roots.x1 != nil) && (roots.x2 == nil) {
    print("Уравнение имеет один корень:")
    print("x1 = \(roots.x1!)")
} else if (roots.x1 == nil) && (roots.x2 == nil) {
    print("Уравнение не имеет действительных корней.")
}
 
*/



// MARK: Задание 1. Работа над ошибками.
// Решение квадратного уравнения.
//
/*
func squareEquationSolver(coefficientA a : Double, coefficientB b: Double, coefficientC c : Double) -> [Double] {
    
    let discriminant = pow(b, Double(2)) - 4 * a * c
    
    if (a == 0) {
        return [-(c / b)]
    } else if (discriminant > 0) {
        return [(-b + sqrt(discriminant)) / (2 * a), (-b - sqrt(discriminant)) / (2 * a)]
    } else if (discriminant == 0) {
        return [-(b / (2 * a))]
    } else {
        return []
    }
}


// Ввод коэффициентов квадратного уравнения ax2 + bx + c = 0
// Коэффициенты для проверки. Уравнение имеет два различных корня.
let a : Double = 5
let b : Double = 88
let c : Double = 8

// Коэффициенты для проверки. Уравнение имеет один корень.
//let a : Double = 1
//let b : Double = -6
//let c : Double = 9

// Коэффициенты для проверки. Уравнение не имеет действительных кореней.
//let a : Double = 5
//let b : Double = 3
//let c : Double = 7

print("Вычисление корней квадратного уравнения \(a)x2 + \(b)x + \(c) = 0")

let roots = squareEquationSolver(coefficientA: a, coefficientB: b, coefficientC: c)

switch roots.count {
case 2:
    print("Уравнение имеет два различных корня:")
    print("x1 = \(roots[0])\nx2 = \(roots[1])")
case 1:
    print("Уравнение имеет один корень:")
    print("x1 = \(roots[0])")
default:
    print("Уравнение не имеет действительных корней.")
}
*/



// MARK: Задание 1. Решение с использованием перечислений со связанными значениями.
// Решение квадратного уравнения.
//
enum SquareEquationResults {
    case twoRoots(x1 : Double, x2 : Double)
    case oneRoot(x1 : Double)
    case noRealRoots(error : String)
}

func squareEquationSolver(coefficientA a : Double, coefficientB b: Double, coefficientC c : Double) -> SquareEquationResults {
    
    var x1, x2 : Double
    
    let discriminant = pow(b, Double(2)) - 4 * a * c
    
    if (a == 0) {
        x1 = -(c / b)
        return .oneRoot(x1: x1)
    } else if (discriminant > 0) {
        x1 = (-b + sqrt(discriminant)) / (2 * a)
        x2 = (-b - sqrt(discriminant)) / (2 * a)
        return .twoRoots(x1: x1, x2: x2)
    } else if (discriminant == 0) {
        x1 = -(b / (2 * a))
        return .oneRoot(x1: x1)
    } else {
        return .noRealRoots(error: "Уравнение не имеет действительных кореней.")
    }
}


// Ввод коэффициентов квадратного уравнения ax2 + bx + c = 0
// Коэффициенты для проверки. Уравнение имеет два различных корня.
let a : Double = 5
let b : Double = 88
let c : Double = 8

// Коэффициенты для проверки. Уравнение имеет один корень.
//let a : Double = 1
//let b : Double = -6
//let c : Double = 9

// Коэффициенты для проверки. Уравнение не имеет действительных кореней.
//let a : Double = 5
//let b : Double = 3
//let c : Double = 7

print("Вычисление корней квадратного уравнения \(a)x2 + \(b)x + \(c) = 0")

let roots = squareEquationSolver(coefficientA: a, coefficientB: b, coefficientC: c)

switch roots {
case let .twoRoots(rootOne, rootTwo) :
    print("Уравнение имеет два различных корня:")
    print("x1 = \(rootOne)\nx2 = \(rootTwo)")
case let .oneRoot(rootOne) :
    print("Уравнение имеет один корень:")
    print("x1 = \(rootOne)")
case let .noRealRoots(message) :
    print(message)
}


 
// MARK: Задание 2
//Даны катеты прямоугольного треугольника.
//Найти площадь, периметр и гипотенузу треугольника.
//

var calculation: (Double, Double) -> Double

// Ввод длин катетов прямоугольного треугольника
let katetA : Double = 5
let katetB : Double = 8

print("\nРасчет прямоугольного треугольника по длинам катетов а = \(katetA) и b = \(katetB):")

// Вычисление площади прямоугольного треугольника
calculation = { $0 * $1 / 2 }
let areaOfRightTriangle = calculation(katetA, katetB)
print("Площадь S = \(round(areaOfRightTriangle * 1000) / 1000)")

// Вычисление гипотенузы прямоугольного треугольника
calculation = { sqrt(pow($0, Double(2)) + pow($1, Double(2))) }
let gipotenuza = calculation(katetA, katetB)
print("Гипотенуза с = \(round(gipotenuza * 1000) / 1000)")

// Вычисление периметра прямоугольного треугольника
let perimeterOfRightTriangle = katetA + katetB + gipotenuza
print("Периметр P = \(round(perimeterOfRightTriangle * 1000) / 1000)")



// MARK: Задание 3
// Пользователь вводит сумму вклада в банк и годовой процент.
// Найти сумму вклада через 5 лет.
//
// Уравнения для сложного процента когда процент начисляется один раз в год:
// P = C * ((1 + r) в степени t)
// где P - будущая стоимость
// С – начальное значение (депозит)
// r – ставка процента (выражается в дробном виде, например 0,06)
// t – количество лет (инвестиционный период)
//

func interestPayment(deposit : Double, interestRate : Double, term : UInt) -> Double {
    
    let amount = deposit * pow((1 + interestRate), Double(term))
    return amount
}


let initialAmount : Double = 1000
let interestRate : Double = 0.05
let timeInYears : UInt = 5

let amount = interestPayment(deposit: initialAmount, interestRate: interestRate, term: timeInYears)

print("\nСумма вклада с депозитом \(initialAmount) и процентной ставкой \(interestRate * 100)% через \(timeInYears) лет будет равна \(round(amount * 100) / 100)")









