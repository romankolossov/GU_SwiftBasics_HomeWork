// Роман Колосов
// rkolossov@mail.ru
// Урок 2 Основы Swift Домашняя работа


import UIKit


let number : Int = 8

// MARK: Задание 1
// Написать функцию, которая определяет, четное число или нет.
//
func isEven(_ number : Int) -> Bool {
    return number % 2 == 0
}


if isEven(number) {
    print("Число \(number) четное")
} else {
    print("Число \(number) нечетное")
}



// MARK: Задание 2
// Написать функцию, которая определяет, делится ли число без остатка на 3.
//
func isDividedByThreeWithoutReminder(_ number : Int) -> Bool {
    return number % 3 == 0
}


if isDividedByThreeWithoutReminder(number) {
    print("Число \(number) делится на 3 без остатка")
} else {
    print("Число \(number) не делится на 3 без остатка")
}



// MARK: Задание 3
// Создать возрастающий массив из 100 чисел.
//
var someArray = Array<Int>()

for _ in 0...99 {
    someArray.append(Int.random(in: 0...1000))
}

let sotedArray = someArray.sorted()

//for number in sotedArr {
//    print(number)
//}



// MARK: Задание 4
// Удалить из возрастающего массива из 100 чисел все четные числа
// и все числа, которые не делятся на 3.
//
// MARK: Задание 4. Решение 1.
//
let oddArray = sotedArray.filter{$0 % 2 != 0}

let finalArray = oddArray.filter{$0 % 3 != 0}

print("\nНечетные числа и числа, которые не делятся на 3 без остатка (Решение 1):\n \(finalArray)")


// MARK: Задание 4. Решение 2.
//
let oddArray2 = sotedArray.filter{!isEven($0)}

let finalArray2 = oddArray.filter{!isDividedByThreeWithoutReminder($0)}

print("\nНечетные числа и числа, которые не делятся на 3 без остатка (Решение 2):\n \(finalArray2)")


// MARK: Задание 4. Решение 3.
//
var finalArray3 = Array<Int>()

for number in sotedArray {
    if (!isEven(number) && !isDividedByThreeWithoutReminder(number)) {
        finalArray3.append(number)
    }
}

print("\nНечетные числа и числа, которые не делятся на 3 без остатка (Решение 3):\n \(finalArray3)")



// MARK: Задание 5.
// Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 100 элементов
//

// Нерекурсивная функция для вычисления числа Фибоначи. Время: O(n), память: O(1)
//
func fibonachi(_ n : Int) -> Double {
    
    var x : Double = 1
    var y : Double = 1
    var ans : Double = 0
    
    if n == 0 {
        return 0
    } else if (n == 1) || (n == 2) {
        return 1
    } else {
        for _ in stride(from: 2, to: n, by: 1) {
            ans = x + y
            x = y
            y = ans
        }
        return ans;
    }
}


let fibonachiArray = (0...99).map{fibonachi($0)}

//var fibonachiArray : Array<Double> = [Double]()
//for i in 0...99 {
//    fibonachiArray.append(fibonachi(i))
//}

print("\n100 первых чисел Фибоначчи:\n \(fibonachiArray)")



// MARK: Задание 6.
// Заполнить массив из 100 элементов различными простыми числами
//

// Решето Эратосфена - алгоритм определения простых чисел
//
func listOfNaturalNumbers(_ n : Int) -> [Int] {
    
    var someArray = Array<Int>(0...n).map{$0}
    var i : Int = 2
    var j : Int
    
    someArray[1] = 0
    
    while i <= n {
        if someArray[i] != 0 {
            j = i + i
            while j <= n {
                someArray[j] = 0
                j = j + i
            }
        }
        i += 1
    }
    
    var naturalNambersSet = Set(someArray)
    naturalNambersSet.remove(0)
    
    return Array(naturalNambersSet.sorted())
}


print("\nНатуральные числа в диапазоне от 0 до 100:\n \(listOfNaturalNumbers(100))")















