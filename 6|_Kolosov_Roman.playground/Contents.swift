import UIKit



protocol PerimeterCalculatable {
    var perimeter: Double { get }
}



class Queue<T: PerimeterCalculatable>: CustomStringConvertible {
    
    private var elements: [T] = []
    
    var count: Int {
        return elements.count
    }
    
    var description: String {
        return "\(elements)"
    }
    
    
    func Enqueue(_ element: T) {
        elements.append(element)
    }
    
    
    func Dequeue() -> T? {
        guard elements.count > 0 else { print("Очередь пуста"); return nil }
        return elements.removeFirst()
    }
    
    
    func listOfElements() {
        print("Текущее положение элементов типа \(T.self) в очереди:")
        for (index, element) in elements.enumerated() {
            print("\(element) имеет номер в очереди: \(index + 1)")
        }
    }
    
    
    func totalPerimeter() {
        var totalPerimeter: Double = 0
        for element in elements {
            totalPerimeter += element.perimeter
        }
        print("Сумарный периметр: \(totalPerimeter)")
    }
    
    
    func filter (filterRule: (T) -> Bool) -> [T] {
        var temporaryArray: [T] = []
        for element in elements {
            if filterRule(element) {
                temporaryArray.append(element)
            }
        }
        return temporaryArray
    }
    
    
    subscript(index: Int) -> T? {
        get {
            guard index < elements.count else {
                print("Элемент под индексом \(index) не существует"); return nil }
            return elements[index]
        }
        set {
            guard index < elements.count, let value = newValue else {
                print("Индекс \(index) не существует"); return }
            elements[index] = value
        }
    }
    
    
    subscript(indeces: Int ...) -> Double {
        var summaryPerimeter: Double = 0
        for index in indeces where index < elements.count {
            summaryPerimeter += elements[index].perimeter
        }
        return summaryPerimeter
    }
}



class Circle {
    
    var radius: Double
    
    func printDescription() {
        print(description)
    }
    
    init(radius: Double) {
        self.radius = radius
    }
}



extension Circle: PerimeterCalculatable {
    var perimeter: Double {
           return round(2 * Double.pi * radius * 100) / 100
       }
}



extension Circle: CustomStringConvertible {
    var description: String {
        "Круг радиусом \(radius) и периметром \(perimeter)"
    }
}



class Rectangle {
    
    var sideA: Double
    var sideB: Double
    
    func printDescription() {
        print(description)
    }
    
    init(sideA: Double, sideB: Double) {
        self.sideA = sideA
        self.sideB = sideB
    }
}



extension Rectangle: PerimeterCalculatable {
    var perimeter: Double {
        return round((sideA + sideB) * 2 * 100) / 100
    }
}



extension Rectangle: CustomStringConvertible {
    var description: String {
        "Прямоугольник со сторонами \(sideA) и \(sideB) и периметром \(perimeter)"
    }
}






let queueCircle: Queue = Queue<Circle>()

queueCircle.Enqueue(Circle(radius: 10))
queueCircle.Enqueue(Circle(radius: 20))
queueCircle.Enqueue(Circle(radius: 30))
queueCircle.Enqueue(Circle(radius: 40))

queueCircle.listOfElements()
print("")

queueCircle[20]
queueCircle[5] = Circle(radius: 88)
queueCircle[3] = Circle(radius: 88)

print("\n\nСуммарный периметр окружностей в очереди, вычисленный через subscript:")
print(queueCircle[0, 1, 2, 3])
print("Вычисление суммарного периметра окружностей в очереди методом класса Queue:")
queueCircle.totalPerimeter()

print("\n\nФункции высшего порядка")

let isEvenCirclePerimeter: (Circle) -> Bool = { Int($0.perimeter) % 2 == 0 }
let isOddCirclePerimeter: (Circle) -> Bool = { Int($0.perimeter) % 2 != 0 }
let perimeterIsMoreThan: (Circle) -> Bool = { Int($0.perimeter) > 150 }

print("В очереди находятся:")
print("Окружности с четной целой частью периметра:\n \(queueCircle.filter(filterRule: isEvenCirclePerimeter))")
print("Окружности с нечетной целой частью периметра:\n \(queueCircle.filter(filterRule: isOddCirclePerimeter))")
print("Окружности с периметром больше 50:\n \(queueCircle.filter(filterRule: perimeterIsMoreThan))")

print("\n\n")
queueCircle.listOfElements()

print("\nИзвлечение окружностей из очереди:")
for _ in 0...(queueCircle.count - 1) {
    let element = queueCircle.Dequeue()
    element?.printDescription()
}

print("\nПосле извлечения элементов в очереди не осталось:")
print(queueCircle.description)


let queueRectangle: Queue = Queue<Rectangle>()

queueRectangle.Enqueue(Rectangle(sideA: 10, sideB: 10))
queueRectangle.Enqueue(Rectangle(sideA: 10, sideB: 20))
queueRectangle.Enqueue(Rectangle(sideA: 10, sideB: 30))
queueRectangle.Enqueue(Rectangle(sideA: 10, sideB: 40))

print("\n\n")
queueRectangle.listOfElements()

print("\n\nСуммарный периметр прямоугольников в очереди, вычисленный через subscript:")
print(queueRectangle[0, 1, 2, 3])
print("Вычисление суммарного периметра прямоугольников в очереди методом класса Queue:")
queueRectangle.totalPerimeter()

print("\nИзвлечение прямоугольников из очереди:")
for _ in 0...(queueRectangle.count - 1) {
    let element = queueRectangle.Dequeue()
    element?.printDescription()
}


print("\n\nФункции высшего порядка (чтобы попрактиковаться)")
let arrayOfCircles: [Circle] = (1...10).map{ Circle(radius: Double($0)) }
//let arrayOfCircles: [Circle] = (1...10).map( {element -> Circle in
//    let transformedElement = Circle(radius: Double(element))
//    return transformedElement
//} )

let evenArrayOfCircles: [Circle] = arrayOfCircles.filter(isEvenCirclePerimeter)
print("\nМассив окружностей с четной целой частью периметра:\n\(evenArrayOfCircles)")

let oddArrayOfCircles: [Circle] = arrayOfCircles.filter(isOddCirclePerimeter)
print("\nМассив окружностей с нечетной целой частью периметра:\n\(oddArrayOfCircles)")


let anotherEvenArrayOfCircles: [Circle] = (1...10).compactMap{ element -> Circle? in
    let circle = Circle(radius: Double(element))
    if  Int(circle.perimeter) % 2 == 0 {
        return circle
    }
    else {
        return nil
    }
}

print("\nДругой массив окружностей с четной целой частью периметра:\n\(anotherEvenArrayOfCircles)")


let arrayOfRectangles: [Rectangle] = (1...10).map{ Rectangle(sideA: Double($0), sideB: Double($0 * 3)) }

let filteredArrayOfRectangles: [Rectangle] = arrayOfRectangles.filter{ $0.perimeter > 50 }
print("\n\nМассив прямоугольников с периметром больше 50:\n\(filteredArrayOfRectangles)")


let totalRadiusOfRectangles = arrayOfRectangles.reduce(0.0) { (result, rectangle) -> Double in return result + rectangle.perimeter }
print("\nСуммарный периметр прямоугольников, вычисленный через reduce: \(totalRadiusOfRectangles)\n")

let sortedArrayOfRectangles = arrayOfRectangles.sorted(by:) {$0.perimeter > $1.perimeter}

sortedArrayOfRectangles.forEach { print($0) }

