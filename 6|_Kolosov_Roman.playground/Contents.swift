import UIKit



protocol PerimeterCalculatable {
    var perimeter: Double { get }
}



class Queue<T: PerimeterCalculatable>: CustomStringConvertible {
    
    private var elements: [T] = []
    
    var count: Int {
        return elements.count
    }
    
    func Enqueue(_ element: T) {
        elements.append(element)
    }
    
    func Dequeue() -> T? {
        guard elements.count > 0 else { print("Очередь пуста"); return nil }
        return elements.removeFirst()
    }
    
    var description: String {
        return "\(elements)"
    }
    
    func listOfElements() {
        print("Текущее положение элементов типа \(T.self) в очереди:")
        for (index, element) in elements.enumerated() {
            print("\(element) имеет номер в очереди: \(index + 1)")
        }
    }
    
    func totalPerimeter() -> Double{
        var totalPerimeter: Double = 0
        for element in elements {
            totalPerimeter += element.perimeter
        }
        return totalPerimeter
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
    
    //    subscript(indeces: Int ...) -> Double {
    //        var summaryPerimeter: Double = 0
    //        for index in indeces where index < elements.count {
    //            summaryPerimeter += elements[index].perimeter
    //        }
    //        return summaryPerimeter
    //    }
}



class Circle: PerimeterCalculatable {
    
    var radius: Double
    
    var perimeter: Double {
        return round(2 * Double.pi * radius * 100) / 100
    }
    
    func printDescription() {
        print(description)
    }
    
    init(radius: Double) {
        self.radius = radius
    }
}



extension Circle: CustomStringConvertible {
    var description: String {
        "Круг радиусом \(radius), периметром \(perimeter)"
    }
}



class Rectangle: PerimeterCalculatable {
    
    var sideA: Double
    var sideB: Double
    
    var perimeter: Double {
        return round((sideA + sideB) * 2 * 100) / 100
    }
    
    func printDescription() {
        print(description)
    }
    
    init(sideA: Double, sideB: Double) {
        self.sideA = sideA
        self.sideB = sideB
    }
}



extension Rectangle: CustomStringConvertible {
    var description: String {
        "Прямоугольник со сторонами \(sideA) и \(sideB), периметром \(perimeter)"
    }
}




let queueCircle: Queue = Queue<Circle>()

queueCircle.Enqueue(Circle(radius: 10))
queueCircle.Enqueue(Circle(radius: 20))
queueCircle.Enqueue(Circle(radius: 30))
queueCircle.Enqueue(Circle(radius: 40))

print(queueCircle.description, "\n")
queueCircle.listOfElements()
print("")

queueCircle[20]
queueCircle[5] = Circle(radius: 88)
queueCircle[3] = Circle(radius: 88)

print("")
queueCircle.listOfElements()

//print(queueCircle[1, 2])

print("\nСуммарный периметр окружностей: \(queueCircle.totalPerimeter())\n")

print("Извлечение окружностей из очереди:")
for _ in 0...(queueCircle.count - 1) {
    let element = queueCircle.Dequeue()
    element?.printDescription()
}



let queueRectangle: Queue = Queue<Rectangle>()

queueRectangle.Enqueue(Rectangle(sideA: 10, sideB: 10))
queueRectangle.Enqueue(Rectangle(sideA: 10, sideB: 20))
queueRectangle.Enqueue(Rectangle(sideA: 10, sideB: 30))
queueRectangle.Enqueue(Rectangle(sideA: 10, sideB: 40))

print("\n\n")
queueRectangle.listOfElements()

print("\nСуммарный периметр прямоугольников: \(queueRectangle.totalPerimeter())\n")

print("Извлечение прямоугольников из очереди:")
for _ in 0...(queueRectangle.count - 1) {
    let element = queueRectangle.Dequeue()
    element?.printDescription()
}



var arrayOfCircles: [Circle] = (1...10).map( { Circle(radius: Double($0)) } )

//var arrayOfCircles: [Circle] = (1...10).map( {element -> Circle in
//    let transformedElement = Circle(radius: Double(element))
//    return transformedElement
//} )

//let isEven: (Int) -> Bool = { $0 % 2 == 0 }
//let isOdd: (Int) -> Bool = { $0 % 2 != 0 }

