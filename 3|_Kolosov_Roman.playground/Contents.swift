import UIKit


enum vehiculeType : String {
    case car = "Легковой автомобиль"
    case truck = "Грузовая машина"
}

enum vehiculeEngineState : String {
    case engineOn = "Двигатель включен"
    case engineOff = "Двигатель заглушен"
}

enum vehiculeWindowsState : String {
    case open = "Окна открыты"
    case closed = "Окна закрыты"
}

enum vehiculeCargoMode {
    case load(weight: Int)
    case unload(weight: Int)
}


struct Vehicule {
    
    let type : vehiculeType
    let manufacturer : String
    let yearOfManufacture : Int
    let payload : Int
    var weightLoaded : Int = 0
    var mileage : Double = 0 {
        didSet {
            let distance = mileage - oldValue
            print("Пройден участок пути \(round(distance * 100) / 100) km")
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
    
    var engineState : vehiculeEngineState {
        willSet {
            if newValue == .engineOn  {
                print("Двигатель сейчас включится")
            } else {
                print("Двигатель сейчас выключится")
            }
        }
    }
    
    var windowsState : vehiculeWindowsState {
        didSet {
            if oldValue == .open {
                print("Окна закрылись")
            } else {
                print("Окна открылись")
            }
        }
    }
    
    
    mutating func startEngine() {
        self.engineState = .engineOn
    }
    
    mutating func stopEngine() {
        self.engineState = .engineOff
    }
    
    mutating func openWindows() {
        self.windowsState = .open
    }
    
    mutating func closeWindows() {
        self.windowsState = .closed
    }
    
    mutating func cargoLoad(mode: vehiculeCargoMode) {
        switch mode {
        case let .load(weight):
            guard weight >= 0 else {
                fatalError()
            }
            if (self.weightLoaded + weight) <= self.payload {
                self.weightLoaded += weight
            }
            else {
                print("Машина перегружена, грузоподъемность: \(payload) кг.")
            }
        case let .unload(weight):
            guard weight >= 0 else {
                fatalError()
            }
            if (self.weightLoaded - weight) >= 0 {
                self.weightLoaded -= weight
            }
            else {
                print("Вы не можете выгрузить \(weight) кг., в машине находится: \(weightLoaded) кг. груза.")
            }
        }
    }
    
    
    init?(type: vehiculeType, payload: Int, wheelRadius: Double) {
        
        guard payload >= 0, wheelRadius >= 0 else {
            return nil
        }
        
        self.type = type
        self.manufacturer = "Tesla"
        self.yearOfManufacture = 2020
        self.mileage = 0
        self.wheelRadius = wheelRadius
        self.payload = payload
        self.weightLoaded = 0
        self.engineState = .engineOff
        self.windowsState = .closed
    }
    
    init?(type: vehiculeType, manufacturer: String, yearOfManufacture: Int, mileage: Double, wheelRadius: Double, payload: Int, weightLoaded: Int, engineState: vehiculeEngineState, windowsState: vehiculeWindowsState) {
        
        guard yearOfManufacture >= 1900, payload >= 0, wheelRadius >= 0, weightLoaded >= 0 else {
            return nil
        }
        
        self.type = type
        self.manufacturer = manufacturer
        self.yearOfManufacture = yearOfManufacture
        self.mileage = mileage
        self.wheelRadius = wheelRadius
        self.payload = payload
        self.weightLoaded = weightLoaded
        self.engineState = engineState
        self.windowsState = windowsState
    }
}



var defaultCar = Vehicule(type: .car, payload: 1600, wheelRadius: 20)

if let defaultCar1 = defaultCar {
    print("Базовый \(defaultCar1.type.rawValue):")
    print("Модель: ", defaultCar1.manufacturer)
    print("Год выпуска: ", defaultCar1.yearOfManufacture)
    print("Пробег: \(defaultCar1.mileage) km")
    print("Радиус дисков: R\(defaultCar1.wheelRadius)")
    print("Диаметр дисков: D\(defaultCar1.wheelDiameter)")
    print("Грузоподъемность: \(defaultCar1.payload) кг.")
    print("Загрузка багажника: \(defaultCar1.weightLoaded) кг.")
    print(defaultCar1.engineState.rawValue)
    print(defaultCar1.windowsState.rawValue)
}


var bmwCar = Vehicule(type: .car, manufacturer: "BMW", yearOfManufacture: 2019, mileage:  20000, wheelRadius: 19, payload: 300, weightLoaded: 50, engineState: .engineOn, windowsState: .open)

var anotherBMWCar = bmwCar
anotherBMWCar?.wheelRadius = 22.5

if let bmwCar1 = bmwCar {
    print("\n\n\(bmwCar1.type.rawValue):")
    print("Модель: ", bmwCar1.manufacturer)
    print("Год выпуска: ", bmwCar1.yearOfManufacture)
    print("Пробег: \(bmwCar1.mileage) km")
    print("Радиус дисков: R\(bmwCar1.wheelRadius)")
    print("Диаметр дисков: D\(bmwCar1.wheelDiameter)")
    print("Вместительность багажника: \(bmwCar1.payload) кг.")
    print("Загрузка багажника: \(bmwCar1.weightLoaded) кг.")
    print(bmwCar1.engineState.rawValue)
    print(bmwCar1.windowsState.rawValue)
}

print("\nПогрузка легковой машины BMW:")
bmwCar?.cargoLoad(mode: .load(weight: 80))
bmwCar?.cargoLoad(mode: .load(weight: 100))
bmwCar?.cargoLoad(mode: .load(weight: 250))
bmwCar?.cargoLoad(mode: .unload(weight: 250))
bmwCar?.cargoLoad(mode: .unload(weight: 50))

print("\nДействия с машиной BMW:")
bmwCar?.closeWindows()
bmwCar?.stopEngine()
bmwCar?.mileage = 20100

print("\nДругой легковой автомобиль BMW:")
anotherBMWCar?.mileage = 20300

if let bmwCar1 = bmwCar {
    print("\n\(bmwCar1.type.rawValue):")
    print("Модель: ", bmwCar1.manufacturer)
    print("Год выпуска: ", bmwCar1.yearOfManufacture)
    print("Пробег: \(bmwCar1.mileage) km")
    print("Радиус дисков: R\(bmwCar1.wheelRadius)")
    print("Диаметр дисков: D\(bmwCar1.wheelDiameter)")
    print("Загрузка багажника: \(bmwCar1.weightLoaded) кг.")
    print(bmwCar1.engineState.rawValue)
    print(bmwCar1.windowsState.rawValue)
}

if let bmwCar1 = anotherBMWCar {
    print("\nДругой \(bmwCar1.type.rawValue):")
    print("Модель: ", bmwCar1.manufacturer)
    print("Год выпуска: ", bmwCar1.yearOfManufacture)
    print("Пробег: \(bmwCar1.mileage) km")
    print("Радиус дисков: R\(bmwCar1.wheelRadius)")
    print("Диаметр дисков: D\(bmwCar1.wheelDiameter)")
    print("Загрузка багажника: \(bmwCar1.weightLoaded) кг.")
    print(bmwCar1.engineState.rawValue)
    print(bmwCar1.windowsState.rawValue)
}



var defaultTruck = Vehicule(type: .truck, payload: 36000, wheelRadius: 22.5)

if let defaultTruck1 = defaultTruck {
    print("\n\nБазовая \(defaultTruck1.type.rawValue).")
    print("Модель: ", defaultTruck1.manufacturer)
    print("Год выпуска: ", defaultTruck1.yearOfManufacture)
    print("Пробег: \(defaultTruck1.mileage) km")
    print("Радиус дисков: R\(defaultTruck1.wheelRadius)")
    print("Диаметр дисков: D\(defaultTruck1.wheelDiameter)")
    print("Грузоподъемность: \(defaultTruck1.payload) кг.")
    print("Загружено: \(defaultTruck1.weightLoaded) кг.")
    print(defaultTruck1.engineState.rawValue)
    print(defaultTruck1.windowsState.rawValue)
}

var mercedesTruck = Vehicule(type: .truck, manufacturer: "Mercedes-Benz", yearOfManufacture: 2018, mileage: 200000, wheelRadius: 22.5, payload: 25000, weightLoaded: 10000, engineState: .engineOff, windowsState: .closed)

if let mercedesTruck1 = mercedesTruck {
    print("\n\n\(mercedesTruck1.type.rawValue):")
    print("Модель: ", mercedesTruck1.manufacturer)
    print("Год выпуска: ", mercedesTruck1.yearOfManufacture)
    print("Пробег: \(mercedesTruck1.mileage) km")
    print("Радиус дисков: R\(mercedesTruck1.wheelRadius)")
    print("Диаметр дисков: D\(mercedesTruck1.wheelDiameter)")
    print("Грузоподъемность: \(mercedesTruck1.payload) кг.")
    print("Загружено: \(mercedesTruck1.weightLoaded) кг.")
    print(mercedesTruck1.engineState.rawValue)
    print(mercedesTruck1.windowsState.rawValue)
}

print("\nПогрузка фуры Mercedes-Benz:")
mercedesTruck?.cargoLoad(mode: .load(weight: 25000))
mercedesTruck?.cargoLoad(mode: .unload(weight: 15000))
mercedesTruck?.cargoLoad(mode: .load(weight: 8000))

print("\nДействия с фурой Mercedes-Benz:")
mercedesTruck?.openWindows()
mercedesTruck?.startEngine()
mercedesTruck?.mileage = 200600

if let mercedesTruck1 = mercedesTruck {
    print("\n\(mercedesTruck1.type.rawValue):")
    print("Модель: ", mercedesTruck1.manufacturer)
    print("Год выпуска: ", mercedesTruck1.yearOfManufacture)
    print("Пробег: \(mercedesTruck1.mileage) km")
    print("Загружено: \(mercedesTruck1.weightLoaded) кг.")
    print(mercedesTruck1.engineState.rawValue)
    print(mercedesTruck1.windowsState.rawValue)
}

