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
var arr = Array<Int>()

for _ in 0...99 {
    arr.append(Int.random(in: 0...1000))
}

let sotedArray = arr.sorted()

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

//print("Нечетные числа и которые не делятся на 3 без остатка:")
//for number in finalArray {
//    print(number)
//}


// MARK: Задание 4. Решение 2.
//
let oddArray2 = sotedArray.filter{!isEven($0)}

let finalArray2 = oddArray.filter{!isDividedByThreeWithoutReminder($0)}

//print("Нечетные числа и которые не делятся на 3 без остатка:")
//for number in finalArray2 {
//    print(number)
//}


// MARK: Задание 4. Решение 3.
//
var finalArray3 = Array<Int>()

for number in sotedArray {
    if (!isEven(number) && !isDividedByThreeWithoutReminder(number)) {
        finalArray3.append(number)
    }
}

print("Нечетные числа и которые не делятся на 3 без остатка:")
for number in finalArray3 {
    print(number)
}











