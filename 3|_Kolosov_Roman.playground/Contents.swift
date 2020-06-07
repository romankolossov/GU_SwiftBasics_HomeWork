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
    
    var wheelRadius : Int
    var wheelDiameter : Int {
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
            if (self.weightLoaded + weight) <= self.payload {
                self.weightLoaded += weight
            }
            else {
                print("Машина перегружена")
            }
        case let .unload(weight):
            if (self.weightLoaded - weight) >= 0 {
                self.weightLoaded -= weight
            }
            else {
                print("Вы не можете столько выгрузить из машины")
            }
        }
    }
    
    
    init?(type: vehiculeType, manufacturer: String, yearOfManufacture: Int, mileage: Double, wheelRadius: Int, payload: Int, weightLoaded: Int, engineState: vehiculeEngineState, windowsState: vehiculeWindowsState) {
        
        guard yearOfManufacture > 0, payload >= 0, wheelRadius > 0 else {
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



var bmwCar = Vehicule(type: .car, manufacturer: "BMW", yearOfManufacture: 2020, mileage:  100, wheelRadius: 20, payload: 300, weightLoaded: 50, engineState: .engineOn, windowsState: .open)

var anotherBMWCar = bmwCar

if let bmwCar1 = bmwCar {
    print(bmwCar1.type.rawValue)
    print("Модель: ", bmwCar1.manufacturer)
    print("Год выпуска: ", bmwCar1.yearOfManufacture)
    print("Пробег: \(bmwCar1.mileage) km")
    print("Радиус дисков: R\(bmwCar1.wheelRadius)")
    print("Диаметр дисков: D\(bmwCar1.wheelDiameter)")
    print(bmwCar1.engineState.rawValue)
    print(bmwCar1.windowsState.rawValue)
    print("Загрузка багажника машины: \(bmwCar1.weightLoaded) кг.\n")
}

bmwCar?.closeWindows()
bmwCar?.stopEngine()
bmwCar?.mileage = 150
print("")
bmwCar?.cargoLoad(mode: .load(weight: 99))
bmwCar?.cargoLoad(mode: .load(weight: 100))
bmwCar?.cargoLoad(mode: .load(weight: 250))
bmwCar?.cargoLoad(mode: .unload(weight: 250))
bmwCar?.cargoLoad(mode: .unload(weight: 49))

print("\nДругая машина BMW:")
anotherBMWCar?.mileage = 300

if let bmwCar1 = bmwCar {
    print("\nМодель: ", bmwCar1.manufacturer)
    print("Пробег: \(bmwCar1.mileage) km")
    print(bmwCar1.engineState.rawValue)
    print(bmwCar1.windowsState.rawValue)
    print("Загрузка багажника машины: \(bmwCar1.weightLoaded) кг.\n")
}

if let bmwCar1 = anotherBMWCar {
    print("\nДругая машина BMW:")
    print("Пробег: \(bmwCar1.mileage) km")
    print(bmwCar1.engineState.rawValue)
    print(bmwCar1.windowsState.rawValue)
    print("Загрузка багажника машины: \(bmwCar1.weightLoaded) кг.\n")
}

