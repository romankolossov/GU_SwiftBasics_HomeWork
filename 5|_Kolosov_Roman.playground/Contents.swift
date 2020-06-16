import UIKit



enum carEngineState: String {
    case engineOn = "Двигатель включен"
    case engineOff = "Двигатель заглушен"
}

enum carWindowsState: String {
    case open = "Окна открыты"
    case closed = "Окна закрыты"
}

enum carCargoMode {
    case toLoad(weight: Int)
    case toUnload(weight: Int)
}



protocol CarManufacturable {
    
    var manufacturer: String { get }
    var yearOfManufacture: Int { get }
    
    var enginePower: Double { get set }
    var mileage: Double { get set }
    var wheelRadius: Double { get set }
    var wheelDiameter: Double { get set }
    var weightLoaded: Int { get set }
    
    var engineState: carEngineState { get set }
    var windowsState: carWindowsState { get set }
    
    func startEngine()
    func stopEngine()
    func openWindows()
    func closeWindows()
    
    func cargoLoad(mode: carCargoMode)
}



extension CarManufacturable {
    
    var wheelDiameter : Double {
        get {
            return wheelRadius * 2
        }
        set {
            wheelRadius = newValue / 2
        }
    }
    
    func cargoLoad(mode: carCargoMode) {
        switch mode {
        case let .toLoad(weight):
            print("Машина готова к погрузке \(weight) кг.")
        case let .toUnload(weight):
            print("Машина готова к выгрузке \(weight) кг.")
        }
    }
}



class Car: CarManufacturable {
    
    let manufacturer: String
    let yearOfManufacture: Int
    var enginePower: Double
    var weightLoaded: Int
    var wheelRadius : Double
    
    private(set) static var carCount: Int = 0
    
    var description: String {
        let descriptionMessage: String = manufacturer + " "
            + String(yearOfManufacture) + " года выпуска.\nМощность двигателя: \(enginePower) л.с., пробег: \(mileage) km."
        return descriptionMessage
    }
    
    var mileage: Double {
        didSet {
            let distance = mileage - oldValue
            print("Пройден участок пути \(round(distance * 100) / 100) km.")
        }
    }

    var engineState : carEngineState {
        willSet {
            if newValue == .engineOn  {
                print("Двигатель готов к включению")
            } else {
                print("Двигатель готов выключению")
            }
        }
        didSet {
            if oldValue == .engineOff {
                print("Двигатель включился")
            }
            else {
                print("Двигатель выключился")
            }
        }
    }

    var windowsState : carWindowsState {
        didSet {
            if oldValue == .open {
                print("Окна закрылись")
            } else {
                print("Окна открылись")
            }
        }
    }
    
    
    init?(manufacturer: String, yearOfManufacture: Int, enginePower: Double, mileage: Double, wheelRadius: Double, weightLoaded: Int, engineState: carEngineState, windowsState: carWindowsState) {

        guard yearOfManufacture >= 1900, enginePower >= 0, wheelRadius >= 0, weightLoaded >= 0 else {
            return nil
        }

        self.manufacturer = manufacturer
        self.yearOfManufacture = yearOfManufacture
        self.enginePower = enginePower
        self.mileage = mileage
        self.wheelRadius = wheelRadius
        self.weightLoaded = weightLoaded
        self.engineState = engineState
        self.windowsState = windowsState
        Car.carCount += 1
    }
    
    deinit {
        Car.carCount -= 1
    }

    convenience init?(manufacturer: String) {
        self.init(manufacturer: manufacturer, yearOfManufacture: 2020, enginePower: 180, mileage: 0, wheelRadius: 18, weightLoaded: 0, engineState: .engineOff, windowsState: .closed)
    }
}



extension Car {
    
    func startEngine() {
        engineState = .engineOn
    }
    
    func stopEngine() {
        engineState = .engineOff
    }
    
    func openWindows() {
        windowsState = .open
    }
    
    func closeWindows() {
        windowsState = .closed
    }
    
    static func countInfo() {
        print("Выпущено всего \(self.carCount) автомобилей")
    }
}



extension Car: CustomStringConvertible {
    
    func printDescription() {
        print(description)
    }
}



extension Car: Comparable {

    static func < (lhs: Car, rhs: Car) -> Bool {
        if ( (lhs.enginePower * lhs.wheelRadius) < (rhs.enginePower * rhs.wheelRadius) ) {
            return true
        } else {
            return false
        }
    }

    static func <= (lhs: Car, rhs: Car) -> Bool {
        if ( (lhs.enginePower * lhs.wheelRadius) <= (rhs.enginePower * rhs.wheelRadius) ) {
            return true
        } else {
            return false
        }
    }

    static func > (lhs: Car, rhs: Car) -> Bool {
        if ( (lhs.enginePower * lhs.wheelRadius) > (rhs.enginePower * rhs.wheelRadius) ) {
            return true
        } else {
            return false
        }
    }

    static func >= (lhs: Car, rhs: Car) -> Bool {
        if ( (lhs.enginePower * lhs.wheelRadius) >= (rhs.enginePower * rhs.wheelRadius) ) {
            return true
        } else {
            return false
        }
    }

    static func == (lhs: Car, rhs: Car) -> Bool {
        if ( (lhs.enginePower * lhs.wheelRadius) == (rhs.enginePower * rhs.wheelRadius) ) {
            return true
        } else {
            return false
        }
    }
}



extension Car: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(enginePower)
        hasher.combine(mileage)
        hasher.combine(wheelRadius)
    }
    //    var hashValue: Int {
    //        let hashBase = enginePower * wheelRadius * mileage
    //        return hashBase.hashValue
    //    }
}



final class SportCar : Car {

    let bootVolume : Int
    
    init?(manufacturer: String, yearOfManufacture: Int, enginePower: Double, mileage: Double, wheelRadius: Double, trunkVolume: Int, weightLoaded: Int, engineState: carEngineState, windowsState: carWindowsState) {

        self.bootVolume = trunkVolume

        super.init(manufacturer: manufacturer, yearOfManufacture: yearOfManufacture, enginePower: enginePower, mileage: mileage, wheelRadius: wheelRadius, weightLoaded: weightLoaded, engineState: engineState, windowsState: windowsState)
    }

    convenience init?(manufacturer: String, trunkVolume: Int) {
        self.init(manufacturer: manufacturer, yearOfManufacture: 2020, enginePower: 362, mileage: 0, wheelRadius: 20, trunkVolume: trunkVolume, weightLoaded: 0, engineState: .engineOff, windowsState: .closed)
    }
}



extension SportCar {
    func cargoLoad(mode: carCargoMode) {
        print("В спорткаре есть багажник для перевозки ручной клади объемом \(bootVolume) литра.")
    }
}



final class TruckCar : Car {

    let payload : Int

    init?(manufacturer: String, yearOfManufacture: Int, enginePower: Double, mileage: Double,  wheelRadius: Double, payload: Int, weightLoaded: Int, engineState: carEngineState, windowsState: carWindowsState) {

        self.payload = payload

        super.init(manufacturer: manufacturer, yearOfManufacture: yearOfManufacture, enginePower: enginePower, mileage: mileage, wheelRadius: wheelRadius, weightLoaded: weightLoaded, engineState: engineState, windowsState: windowsState)
    }

    convenience init?(manufacturer: String, payload: Int) {
        self.init(manufacturer: manufacturer, yearOfManufacture: 2020, enginePower: 430, mileage: 0, wheelRadius: 22.5, payload: payload, weightLoaded: 0, engineState: .engineOff, windowsState: .closed)
    }
}



extension TruckCar {
    
    func cargoLoad(mode: carCargoMode) {
        
        super.cargoLoad(mode: mode)

        switch mode {
        case let .toLoad(weight):
            guard weight >= 0 else {
                print("Некорректный вес груза.")
                return
            }
            if (self.weightLoaded + weight) <= self.payload {
                self.weightLoaded += weight
            }
            else {
                print("Машина перегружена, грузоподъемность: \(payload) кг.")
            }
        case let .toUnload(weight):
            guard weight >= 0 else {
                print("Некорректный вес груза.")
                return
            }
            if (self.weightLoaded - weight) >= 0 {
                self.weightLoaded -= weight
            }
            else {
                print("Вы не можете выгрузить \(weight) кг., в машине находится: \(weightLoaded) кг. груза.")
            }
        }
    }
}






var defaultCar : Car? = Car(manufacturer: "Mercedes-Benz")

print("Базовая модель легкового автомобиля:")
defaultCar?.printDescription()

if let defaultCar1 = defaultCar {
    print("Радиус дисков: R\(defaultCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultCar1.wheelDiameter)")
    print("Загрузка багажника: \(defaultCar1.weightLoaded) кг.")
    print(defaultCar1.engineState.rawValue)
    print(defaultCar1.windowsState.rawValue)
}

print("\nДействия с базовой моделью легкового автомобиля \(defaultCar?.manufacturer ?? "noname"):")
defaultCar?.cargoLoad(mode: .toLoad(weight: 100))
defaultCar?.startEngine()
defaultCar?.openWindows()
defaultCar?.mileage = 100
defaultCar?.mileage = 250
print("")
defaultCar?.printDescription()
print(defaultCar?.engineState.rawValue ?? "Статус двигателя не определен")
print(defaultCar?.windowsState.rawValue ?? "Положение окон не определено")

print("")
Car.countInfo()



var defaultSportCar : SportCar? = SportCar(manufacturer: "Tesla", trunkVolume: 745)

print("\n\nБазовая модель спорткара:")
defaultSportCar?.printDescription()

if let defaultSportCar1 = defaultSportCar {
    print("Радиус дисков: R\(defaultSportCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultSportCar1.wheelDiameter)")
    print("Объем багажника: \(defaultSportCar1.bootVolume) литра.")
    print("Загрузка багажника: \(defaultSportCar1.weightLoaded) кг.")
}

print("\nДействия с базовой моделью спорткара \(defaultSportCar?.manufacturer ?? "noname"):")
defaultSportCar?.cargoLoad(mode: .toLoad(weight: 0))
defaultSportCar?.startEngine()
defaultSportCar?.openWindows()
defaultSportCar?.stopEngine()
defaultSportCar?.closeWindows()



var anotherSportCar: SportCar? = SportCar(manufacturer: "Porsche", yearOfManufacture: 2018, enginePower: 345, mileage: 30000, wheelRadius: 20, trunkVolume: 132, weightLoaded: 0, engineState: .engineOff, windowsState: .closed)

print("\n\nДругая базовая модель спорткара:")
anotherSportCar?.printDescription()
print("Радиус дисков: R\(anotherSportCar?.wheelRadius ?? 0)")
print("Диаметр дисков: D\(anotherSportCar?.wheelDiameter ?? 0)")
print("Объем багажника: \(anotherSportCar?.bootVolume ?? 0) литра.")

print("\nДействия с моделью спорткара \(anotherSportCar?.manufacturer ?? "noname"):")
anotherSportCar?.enginePower = 700
anotherSportCar?.wheelRadius = 22.5
anotherSportCar?.startEngine()
anotherSportCar?.mileage = 30300
anotherSportCar?.mileage = 30350
anotherSportCar?.cargoLoad(mode: .toUnload(weight: 0))

if let anotherSportCar1 = anotherSportCar {
    print("\nПрокачали двигатель, сменили диски и немного покатались на спорткаре \(anotherSportCar1.manufacturer) ")
    print("Новый радиус дисков: R\(anotherSportCar1.wheelRadius)")
    print("Новый диаметр дисков: D\(anotherSportCar1.wheelDiameter)")
    print("Мощность нового двигателя: \(anotherSportCar1.enginePower) л.с.")
    print(anotherSportCar1.engineState.rawValue)
    print("Пробег: \(anotherSportCar1.mileage) km.")
}

print("")
Car.countInfo()



var defaultTruck : TruckCar? = TruckCar(manufacturer: "MAN", payload: 20000)

print("\n\nБазовая модель грузовика:")
defaultTruck?.printDescription()

if let defaultTruck1 = defaultTruck {
    print("Радиус дисков: R\(defaultTruck1.wheelRadius)")
    print("Диаметр дисков: D\(defaultTruck1.wheelDiameter)")
    print("Грузоподъемность: \(defaultTruck1.payload) кг.")
    print("Загружено: \(defaultTruck1.weightLoaded) кг.")
    print(defaultTruck1.engineState.rawValue)
    print(defaultTruck1.windowsState.rawValue)
}

print("\nПогрузка грузовой машины \(defaultTruck?.manufacturer ?? "noname"):")
defaultTruck?.cargoLoad(mode: .toUnload(weight: 500))
defaultTruck?.cargoLoad(mode: .toLoad(weight: 11000))
print("Загружено: ", defaultTruck?.weightLoaded ?? 0)
defaultTruck?.cargoLoad(mode: .toLoad(weight: 15000))
print("Загружено: ", defaultTruck?.weightLoaded ?? 0)

print("\nПеревозка груза грузовой машиной \(defaultTruck?.manufacturer ?? "noname"):")
defaultTruck?.startEngine()
defaultTruck?.mileage = 600
defaultTruck?.mileage = 800
defaultTruck?.stopEngine()

defaultTruck?.printDescription()

print("")
Car.countInfo()



print("\n\nСравнение машин:\n")

guard defaultSportCar != nil && defaultTruck != nil else {
    print("Базовая модель спорткара и/или базовая модель грузовой машины не существуют")
    fatalError()
}

if  defaultSportCar! >= defaultTruck! {
    print("Базовая модель спорткара")
    defaultSportCar?.printDescription()
    print("круче базовой модели тягоча")
    defaultTruck?.printDescription()
} else {
    print("Базовая модель тягоча")
    defaultTruck?.printDescription()
    print("круче базовой модели спорткара")
    defaultSportCar?.printDescription()
}

print("")

guard anotherSportCar != nil && defaultTruck != nil else {
    print("Прокаченная модель спорткара и/или базовая модель грузовой машины не существуют")
    fatalError()
}

if  anotherSportCar! >= defaultTruck! {
    print("Прокаченная модель спорткара")
    anotherSportCar?.printDescription()
    print("круче базовой модели тягача")
    defaultTruck?.printDescription()
} else {
    print("Базовая модель тягача")
    defaultTruck?.printDescription()
    print("круче прокаченной модели спорткара")
    anotherSportCar?.printDescription()
}



print("\n\nПроверка реализации протокола Hashable:")

let carDictionary: [Car? : String] = [
    defaultCar : "Базовая модель легкового автомобиля",
    defaultSportCar : "Базовая модель спорткара",
    anotherSportCar : "Прокаченная модель спорткара",
    defaultTruck : "Базовая модель тягача"
]

for (key, value) in carDictionary {
    guard key != nil else {
        print("Машина: \(value) не сущетвует")
        fatalError()
    }
    print("\n\(key!) : \(value)")
}

