import UIKit


enum carEngineState : String {
    case engineOn = "Двигатель включен"
    case engineOff = "Двигатель заглушен"
}

enum carWindowsState : String {
    case open = "Окна открыты"
    case closed = "Окна закрыты"
}

enum carCargoMode {
    case toLoad(weight: Int)
    case toUnload(weight: Int)
}


class Car {
    
    let manufacturer : String
    let yearOfManufacture : Int
    var weightLoaded : Int = 0
    var mileage : Double = 0 {
        didSet {
            let distance = mileage - oldValue
            print("Пройден участок пути \(round(distance * 100) / 100) km.")
        }
    }
    
    var wheelRadius : Double
    var wheelDiameter : Double {
        get {
            return wheelRadius * 2
        }
        set {
            wheelRadius = newValue / 2
        }
    }
    
    var engineState : carEngineState {
        willSet {
            if newValue == .engineOn  {
                print("Двигатель сейчас включится")
            } else {
                print("Двигатель сейчас выключится")
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
    
    
    private(set) static var carCount = 0
    
    static func countInfo() {
        print("Выпущено всего \(self.carCount) автомобилей")
    }
    
    init?(manufacturer: String, yearOfManufacture: Int, mileage: Double, wheelRadius: Double, weightLoaded: Int, engineState: carEngineState, windowsState: carWindowsState) {
        
        guard yearOfManufacture >= 1900, wheelRadius >= 0, weightLoaded >= 0 else {
            return nil
        }
        
        self.manufacturer = manufacturer
        self.yearOfManufacture = yearOfManufacture
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
        self.init(manufacturer: manufacturer, yearOfManufacture: 2020, mileage: 0, wheelRadius: 18, weightLoaded: 0, engineState: .engineOff, windowsState: .closed)
    }
    
    
    func startEngine() {
        self.engineState = .engineOn
    }
    
    func stopEngine() {
        self.engineState = .engineOff
    }
    
    func openWindows() {
        self.windowsState = .open
    }
    
    func closeWindows() {
        self.windowsState = .closed
    }
    
    func cargoLoad(mode: carCargoMode) {
        switch mode {
        case let .toLoad(weight):
            print("Машина готова к погрузке \(weight) кг.")
        case let .toUnload(weight):
            print("Машина готова к выгрузке \(weight) кг..")
        }
    }
}



final class SportCar : Car {
    
    let bootVolume : Int
    private(set) static var sportCarCount = 0
    
    static func sportCarCountInfo () {
        print("Выпущено \(self.sportCarCount) спорткаров")
    }
    
    init?(manufacturer: String, yearOfManufacture: Int, mileage: Double, wheelRadius: Double, trunkVolume: Int, weightLoaded: Int, engineState: carEngineState, windowsState: carWindowsState) {
        
        self.bootVolume = trunkVolume
        
        super.init(manufacturer: manufacturer, yearOfManufacture: yearOfManufacture, mileage: mileage, wheelRadius: wheelRadius, weightLoaded: weightLoaded, engineState: engineState, windowsState: windowsState)
        
        SportCar.sportCarCount += 1
    }
    deinit {
        SportCar.sportCarCount -= 1
    }
    
    convenience init?(manufacturer: String, trunkVolume: Int) {
        self.init(manufacturer: manufacturer, yearOfManufacture: 2020, mileage: 0, wheelRadius: 20, trunkVolume: trunkVolume, weightLoaded: 0, engineState: .engineOff, windowsState: .closed)
    }
    
    override func cargoLoad(mode: carCargoMode) {
        print("В спорткаре есть багажник для перевозки ручной клади объемом \(bootVolume) литра.")
    }
}



final class TruckCar : Car {
    
    let payload : Int
    private(set) static var truсkCount = 0
    
    static func truckCountInfo () {
        print("Выпущено \(self.truсkCount) грузовых машин")
    }
    
    init?(manufacturer: String, yearOfManufacture: Int, mileage: Double, wheelRadius: Double, payload: Int, weightLoaded: Int, engineState: carEngineState, windowsState: carWindowsState) {
        
        self.payload = payload
        
        super.init(manufacturer: manufacturer, yearOfManufacture: yearOfManufacture, mileage: mileage, wheelRadius: wheelRadius, weightLoaded: weightLoaded, engineState: engineState, windowsState: windowsState)
        
        TruckCar.truсkCount += 1
    }
    deinit {
        TruckCar.truсkCount -= 1
    }
    
    convenience init?(manufacturer: String, payload: Int) {
        self.init(manufacturer: manufacturer, yearOfManufacture: 2020, mileage: 0, wheelRadius: 22.5, payload: payload, weightLoaded: 0, engineState: .engineOff, windowsState: .closed)
    }
    
    
    override func cargoLoad(mode: carCargoMode) {
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


func ordinaryCarCount() {
    let numberOfOrdinaryCarsIssued = Car.carCount - SportCar.sportCarCount - TruckCar.truсkCount
    print("Выпущено обычных легковых машин: ", numberOfOrdinaryCarsIssued)
}

func foo() -> Car? {
    let fooDefaultCar : Car? = Car(manufacturer: "BMW")
    print("inside foo info: Выпущено всего \(Car.carCount) автомобилей")
    return fooDefaultCar
}



var defaultCar : Car? = Car(manufacturer: "Mercedes-Benz")

if let defaultCar1 = defaultCar {
    print("Базовая модель автомобиля: ", defaultCar1.manufacturer)
    print("Год выпуска: ", defaultCar1.yearOfManufacture)
    print("Пробег: \(defaultCar1.mileage) km")
    print("Радиус дисков: R\(defaultCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultCar1.wheelDiameter)")
    print("Загрузка багажника: \(defaultCar1.weightLoaded) кг.")
    print(defaultCar1.engineState.rawValue)
    print(defaultCar1.windowsState.rawValue)
}

print("")
defaultCar?.cargoLoad(mode: .toLoad(weight: 100))
defaultCar?.startEngine()
defaultCar?.openWindows()

print("")
Car.countInfo()
ordinaryCarCount()
print("")


// MARK: Николай здравствуйте! Разбираю Ваш пример с урока. Не могу понять - после каждого вызова foo увеличивается количество машин и после завершения foo их количество не уменьшается и обратится к ним невозможно. Здесь memory cycle? foo ссылается на Car, а Car ссылается на foo? как из него выйти? или я что-то не так делаю?
print("\nВопрос по работе функции, возвращающей тип Car? :\n")
foo()
foo()
Car.countInfo()

print("")
var defaulCar2 : Car? = foo()
Car.countInfo()

defaulCar2 = nil

print("")
Car.countInfo()
ordinaryCarCount()
//---------------------------------------------------------------------------------



var defaultSportCar : SportCar? = SportCar(manufacturer: "Tesla", trunkVolume: 745)

if let defaultSportCar1 = defaultSportCar {
    print("\n\nБазовая модель спорткара: ", defaultSportCar1.manufacturer)
    print("Год выпуска: ", defaultSportCar1.yearOfManufacture)
    print("Пробег: \(defaultSportCar1.mileage) km.")
    print("Радиус дисков: R\(defaultSportCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultSportCar1.wheelDiameter)")
    print("Объем багажника: \(defaultSportCar1.bootVolume) литра.")
    print("Загрузка багажника: \(defaultSportCar1.weightLoaded) кг.")
    print(defaultSportCar1.engineState.rawValue)
    print(defaultSportCar1.windowsState.rawValue)
}

print("")
defaultSportCar?.cargoLoad(mode: .toLoad(weight: 0))
defaultSportCar?.startEngine()
defaultSportCar?.openWindows()
defaultSportCar?.stopEngine()
defaultSportCar?.closeWindows()

print("")
Car.countInfo()


var anotherSportCar : SportCar? = SportCar(manufacturer: "Porsche", trunkVolume: 132)

if let anotherSportCar1 = anotherSportCar {
    print("\n\nДругая базовая модель спорткара: ", anotherSportCar1.manufacturer)
    print("Радиус дисков: R\(anotherSportCar1.wheelRadius)")
    print("Диаметр дисков: D\(anotherSportCar1.wheelDiameter)")
}

anotherSportCar?.wheelRadius = 22.5
anotherSportCar?.cargoLoad(mode: .toUnload(weight: 0))
anotherSportCar?.startEngine()
anotherSportCar?.openWindows()

if let anotherSportCar1 = anotherSportCar {
    print("\nСменили диски, открыли окна и запустили двигатель у спорткара: ", anotherSportCar1.manufacturer)
    print("Новый радиус дисков: R\(anotherSportCar1.wheelRadius)")
    print("Новый диаметр дисков: D\(anotherSportCar1.wheelDiameter)")
    print(anotherSportCar1.engineState.rawValue)
    print(anotherSportCar1.windowsState.rawValue)
}

print("")
Car.countInfo()

defaultSportCar = anotherSportCar
Car.countInfo()

anotherSportCar = nil

SportCar.sportCarCountInfo()
ordinaryCarCount()

if let defaultSportCar1 = defaultSportCar {
    print("\n\nНовая базовая модель спорткара: ", defaultSportCar1.manufacturer)
    print("Радиус дисков: R\(defaultSportCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultSportCar1.wheelDiameter)")
    print("Объем багажника: \(defaultSportCar1.bootVolume) литра.")
    print(defaultSportCar1.engineState.rawValue)
    print(defaultSportCar1.windowsState.rawValue)
}



var defaultTruck : TruckCar? = TruckCar(manufacturer: "MAN", payload: 20000)

if let defaultTruck1 = defaultTruck {
    print("\n\nБазовая модель грузовика: ", defaultTruck1.manufacturer)
    print("Год выпуска: ", defaultTruck1.yearOfManufacture)
    print("Пробег: \(defaultTruck1.mileage) km")
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

print("")
TruckCar.truckCountInfo()


var anotherTruck : TruckCar? = defaultTruck
TruckCar.truckCountInfo()

print("")
anotherTruck?.startEngine()
anotherTruck?.openWindows()

print("\nСостояние грузовой машины \(defaultTruck?.manufacturer ?? "noname"):")
print(defaultTruck?.engineState.rawValue ?? "Статус двигателя не определен")
print(defaultTruck?.windowsState.rawValue ?? "Состояние окон не определено")


anotherTruck = TruckCar(manufacturer: "Scania", payload: 25000)

print("")
TruckCar.truckCountInfo()

if let anotherTruck1 = anotherTruck {
    print("\n\nДругая базовая модель грузовика: ", anotherTruck1.manufacturer)
    print("Год выпуска: ", anotherTruck1.yearOfManufacture)
    print("Пробег: \(anotherTruck1.mileage) km")
    print("Радиус дисков: R\(anotherTruck1.wheelRadius)")
    print("Диаметр дисков: D\(anotherTruck1.wheelDiameter)")
    print("Грузоподъемность: \(anotherTruck1.payload) кг.")
    print("Загружено: \(anotherTruck1.weightLoaded) кг.")
    print(anotherTruck1.engineState.rawValue)
    print(anotherTruck1.windowsState.rawValue)
}


print("")
Car.countInfo()
SportCar.sportCarCountInfo()
TruckCar.truckCountInfo()
ordinaryCarCount()



