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
        print("\nВыпущено \(self.carCount) автомобилей")
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
            print("Машина готова к разгрузке \(weight) кг..")
        }
    }
}



final class SportCar : Car {
    
    let trunkVolume : Int
    
    init?(manufacturer: String, yearOfManufacture: Int, mileage: Double, wheelRadius: Double, trunkVolume: Int, weightLoaded: Int, engineState: carEngineState, windowsState: carWindowsState) {
        
        self.trunkVolume = trunkVolume
        
        super.init(manufacturer: manufacturer, yearOfManufacture: yearOfManufacture, mileage: mileage, wheelRadius: wheelRadius, weightLoaded: weightLoaded, engineState: engineState, windowsState: windowsState)
    }
    
    convenience init?(manufacturer: String, trunkVolume: Int) {
        self.init(manufacturer: manufacturer, yearOfManufacture: 2020, mileage: 0, wheelRadius: 20, trunkVolume: trunkVolume, weightLoaded: 0, engineState: .engineOff, windowsState: .closed)
    }
    
    override func cargoLoad(mode: carCargoMode) {
        print("В спорткаре есть багажник для перевозки ручной клади объемом \(trunkVolume) литров.")
    }
}



final class TruckCar : Car {
    
    let payload : Int
    private(set) static var trunkCount = 0
    
    static func trunkCountInfo () {
        print("Выпущено \(trunkCount) грузовых автомобилей.")
    }
    
    init?(manufacturer: String, yearOfManufacture: Int, mileage: Double, wheelRadius: Double, payload: Int, weightLoaded: Int, engineState: carEngineState, windowsState: carWindowsState) {
        
        self.payload = payload
        
        super.init(manufacturer: manufacturer, yearOfManufacture: yearOfManufacture, mileage: mileage, wheelRadius: wheelRadius, weightLoaded: weightLoaded, engineState: engineState, windowsState: windowsState)
        
        TruckCar.trunkCount += 1
    }
    deinit {
        TruckCar.trunkCount -= 1
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

defaultCar?.cargoLoad(mode: .toLoad(weight: 100))
defaultCar?.startEngine()
defaultCar?.openWindows()
Car.countInfo()


var defaultSportCar : SportCar? = SportCar(manufacturer: "Tesla", trunkVolume: 745)

if let defaultSportCar1 = defaultSportCar {
    print("\n\nБазовая модель спорткара: ", defaultSportCar1.manufacturer)
    print("Год выпуска: ", defaultSportCar1.yearOfManufacture)
    print("Пробег: \(defaultSportCar1.mileage) km.")
    print("Радиус дисков: R\(defaultSportCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultSportCar1.wheelDiameter)")
    print("Объем багажника: \(defaultSportCar1.trunkVolume) литра.")
    print("Загрузка багажника: \(defaultSportCar1.weightLoaded) кг.")
    print(defaultSportCar1.engineState.rawValue)
    print(defaultSportCar1.windowsState.rawValue)
}

defaultSportCar?.cargoLoad(mode: .toLoad(weight: 0))
defaultSportCar?.startEngine()
defaultSportCar?.openWindows()
defaultSportCar?.stopEngine()
defaultSportCar?.closeWindows()
print("\nВыпущено \(Car.carCount) автомобилей.")


var anotherSportCar : SportCar? = SportCar(manufacturer: "Porsche", trunkVolume: 132)

if let defaultSportCar1 = anotherSportCar {
    print("\n\nДругая базовая модель спорткара: ", defaultSportCar1.manufacturer)
    print("Радиус дисков: R\(defaultSportCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultSportCar1.wheelDiameter)")
}

anotherSportCar?.wheelRadius = 22.5
anotherSportCar?.cargoLoad(mode: .toUnload(weight: 0))
anotherSportCar?.startEngine()
anotherSportCar?.openWindows()

if let defaultSportCar1 = anotherSportCar {
    print("\nMодель спорткара: ", defaultSportCar1.manufacturer)
    print("Радиус дисков: R\(defaultSportCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultSportCar1.wheelDiameter)")
    print(defaultSportCar1.engineState.rawValue)
    print(defaultSportCar1.windowsState.rawValue)
}

Car.countInfo()
defaultSportCar = anotherSportCar
Car.countInfo()
anotherSportCar = nil

if let defaultSportCar1 = defaultSportCar {
    print("\nБазовая модель спорткара: ", defaultSportCar1.manufacturer)
    print("Радиус дисков: R\(defaultSportCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultSportCar1.wheelDiameter)")
    print("Объем багажника: \(defaultSportCar1.trunkVolume) литра.")
    print(defaultSportCar1.engineState.rawValue)
    print(defaultSportCar1.windowsState.rawValue)
}







//var bmwCar = Vehicule(type: .car, manufacturer: "BMW", yearOfManufacture: 2019, mileage:  20000, wheelRadius: 19, payload: 300, weightLoaded: 50, engineState: .engineOn, windowsState: .open)
//
//var anotherBMWCar = bmwCar
//anotherBMWCar?.wheelRadius = 22.5
//
//if let bmwCar1 = bmwCar {
//    print("\n\n\(bmwCar1.type.rawValue):")
//    print("Модель: ", bmwCar1.manufacturer)
//    print("Год выпуска: ", bmwCar1.yearOfManufacture)
//    print("Пробег: \(bmwCar1.mileage) km")
//    print("Радиус дисков: R\(bmwCar1.wheelRadius)")
//    print("Диаметр дисков: D\(bmwCar1.wheelDiameter)")
//    print("Вместительность багажника: \(bmwCar1.payload) кг.")
//    print("Загрузка багажника: \(bmwCar1.weightLoaded) кг.")
//    print(bmwCar1.engineState.rawValue)
//    print(bmwCar1.windowsState.rawValue)
//}
//
//print("\nПогрузка легковой машины BMW:")
//bmwCar?.cargoLoad(mode: .load(weight: 80))
//bmwCar?.cargoLoad(mode: .load(weight: 100))
//bmwCar?.cargoLoad(mode: .load(weight: 250))
//bmwCar?.cargoLoad(mode: .unload(weight: 250))
//bmwCar?.cargoLoad(mode: .unload(weight: 50))
//
//print("\nДействия с машиной BMW:")
//bmwCar?.closeWindows()
//bmwCar?.stopEngine()
//bmwCar?.mileage = 20100
//
//print("\nДругой легковой автомобиль BMW:")
//anotherBMWCar?.mileage = 20300
//
//if let bmwCar1 = bmwCar {
//    print("\n\(bmwCar1.type.rawValue):")
//    print("Модель: ", bmwCar1.manufacturer)
//    print("Год выпуска: ", bmwCar1.yearOfManufacture)
//    print("Пробег: \(bmwCar1.mileage) km")
//    print("Радиус дисков: R\(bmwCar1.wheelRadius)")
//    print("Диаметр дисков: D\(bmwCar1.wheelDiameter)")
//    print("Загрузка багажника: \(bmwCar1.weightLoaded) кг.")
//    print(bmwCar1.engineState.rawValue)
//    print(bmwCar1.windowsState.rawValue)
//}
//
//if let bmwCar1 = anotherBMWCar {
//    print("\nДругой \(bmwCar1.type.rawValue):")
//    print("Модель: ", bmwCar1.manufacturer)
//    print("Год выпуска: ", bmwCar1.yearOfManufacture)
//    print("Пробег: \(bmwCar1.mileage) km")
//    print("Радиус дисков: R\(bmwCar1.wheelRadius)")
//    print("Диаметр дисков: D\(bmwCar1.wheelDiameter)")
//    print("Загрузка багажника: \(bmwCar1.weightLoaded) кг.")
//    print(bmwCar1.engineState.rawValue)
//    print(bmwCar1.windowsState.rawValue)
//}
//
//
//
//var defaultTruck = Vehicule(type: .truck, payload: 36000, wheelRadius: 22.5)
//
//if let defaultTruck1 = defaultTruck {
//    print("\n\nБазовая \(defaultTruck1.type.rawValue).")
//    print("Модель: ", defaultTruck1.manufacturer)
//    print("Год выпуска: ", defaultTruck1.yearOfManufacture)
//    print("Пробег: \(defaultTruck1.mileage) km")
//    print("Радиус дисков: R\(defaultTruck1.wheelRadius)")
//    print("Диаметр дисков: D\(defaultTruck1.wheelDiameter)")
//    print("Грузоподъемность: \(defaultTruck1.payload) кг.")
//    print("Загружено: \(defaultTruck1.weightLoaded) кг.")
//    print(defaultTruck1.engineState.rawValue)
//    print(defaultTruck1.windowsState.rawValue)
//}
//
//var mercedesTruck = Vehicule(type: .truck, manufacturer: "Mercedes-Benz", yearOfManufacture: 2018, mileage: 200000, wheelRadius: 22.5, payload: 25000, weightLoaded: 10000, engineState: .engineOff, windowsState: .closed)
//
//if let mercedesTruck1 = mercedesTruck {
//    print("\n\n\(mercedesTruck1.type.rawValue):")
//    print("Модель: ", mercedesTruck1.manufacturer)
//    print("Год выпуска: ", mercedesTruck1.yearOfManufacture)
//    print("Пробег: \(mercedesTruck1.mileage) km")
//    print("Радиус дисков: R\(mercedesTruck1.wheelRadius)")
//    print("Диаметр дисков: D\(mercedesTruck1.wheelDiameter)")
//    print("Грузоподъемность: \(mercedesTruck1.payload) кг.")
//    print("Загружено: \(mercedesTruck1.weightLoaded) кг.")
//    print(mercedesTruck1.engineState.rawValue)
//    print(mercedesTruck1.windowsState.rawValue)
//}
//
//print("\nПогрузка фуры Mercedes-Benz:")
//mercedesTruck?.cargoLoad(mode: .load(weight: 25000))
//mercedesTruck?.cargoLoad(mode: .unload(weight: 15000))
//mercedesTruck?.cargoLoad(mode: .load(weight: 8000))
//
//print("\nДействия с фурой Mercedes-Benz:")
//mercedesTruck?.openWindows()
//mercedesTruck?.startEngine()
//mercedesTruck?.mileage = 200600
//
//if let mercedesTruck1 = mercedesTruck {
//    print("\n\(mercedesTruck1.type.rawValue):")
//    print("Модель: ", mercedesTruck1.manufacturer)
//    print("Год выпуска: ", mercedesTruck1.yearOfManufacture)
//    print("Пробег: \(mercedesTruck1.mileage) km")
//    print("Загружено: \(mercedesTruck1.weightLoaded) кг.")
//    print(mercedesTruck1.engineState.rawValue)
//    print(mercedesTruck1.windowsState.rawValue)
//}
//
