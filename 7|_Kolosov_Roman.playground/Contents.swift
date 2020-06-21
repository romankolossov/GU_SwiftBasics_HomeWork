import UIKit



enum VendingMachineError: Error {
    
    case invalidSelection
    case outOfStock
    case insufficienFunds(coinsNeeded: Int)
}



enum BuyerError: Error {
    
    case buyerNotFound
}



struct ItemInStock {
    
    var price: Int
    var count: Int
    let productSpec: ProductSpecification
}



struct ProductSpecification {
    
    let productName: String
}



protocol SalesMakeable {
    
    var coinsDeposited: Int { get set }
    
    func shouldVend(itemForSale item: String) throws -> ProductSpecification
    
    func shouldVendFavoriteProduct(to person: String) throws -> ProductSpecification
    
    func vend(itemForSale item: String) -> (ProductSpecification?, VendingMachineError?)
}



class ColdDrinkVendor: SalesMakeable {
    
    var inventory: [String : ItemInStock] = [
        "Cola" : ItemInStock(price: 50, count: 5, productSpec: ProductSpecification(productName: "Cola Vanilla")),
        "Pepsi" : ItemInStock(price: 30, count: 3, productSpec: ProductSpecification(productName: "Pepsi Cherry")),
        "Fanta" : ItemInStock(price: 20, count: 2, productSpec: ProductSpecification(productName: "Fanta Zero"))
    ]
    
    let favoriteDrink: [String : String] = [
        "Roman" : "Cola",
        "Alice" : "Fanta",
        "John" : "Pepsi"
    ]
    
    
    var coinsDeposited: Int = 0
    
    
    func shouldVend(itemForSale itemKeyWord: String) throws -> ProductSpecification {
        
        guard let item = inventory[itemKeyWord] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficienFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        
        newItem.count -= 1
        
        inventory[itemKeyWord] = newItem
        
        return newItem.productSpec
    }
    
    
    func shouldVendFavoriteProduct(to person: String) throws -> ProductSpecification {
        
        guard let drinkName = favoriteDrink[person] else { throw BuyerError.buyerNotFound }
        
        return try shouldVend(itemForSale: drinkName)
    }
    
    
    func vend(itemForSale itemKeyWord: String) -> (ProductSpecification?, VendingMachineError?) {
        
        guard let item = inventory[itemKeyWord] else {
            return (nil, VendingMachineError.invalidSelection)
        }
        guard item.count > 0 else {
            return (nil, VendingMachineError.outOfStock)
        }
        guard item.price <= coinsDeposited else {
            return (nil, VendingMachineError.insufficienFunds(coinsNeeded: item.price - coinsDeposited))
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        
        newItem.count -= 1
        
        inventory[itemKeyWord] = newItem
        
        return (newItem.productSpec, nil)
    }
}



class SweetsVendor: SalesMakeable {
    
    var inventory: [String : ItemInStock] = [
        "Mars" : ItemInStock(price: 50, count: 5, productSpec: ProductSpecification(productName: "MarsMax")),
        "Snickers" : ItemInStock(price: 30, count: 3, productSpec: ProductSpecification(productName: "Snickers double")),
        "KitKat" : ItemInStock(price: 20, count: 2, productSpec: ProductSpecification(productName: "KitKat Maxi"))
    ]
    
    let favoriteSweet: [String : String] = [
        "Roman" : "KitKat",
        "Alice" : "Mars",
        "John" : "Snickers"
    ]
    
    
    var coinsDeposited: Int = 0
    
    
    func shouldVend(itemForSale itemKeyWord: String) throws -> ProductSpecification {
        
        guard let item = inventory[itemKeyWord] else {
            throw VendingMachineError.invalidSelection
        }
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficienFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        
        newItem.count -= 1
        
        inventory[itemKeyWord] = newItem
        
        return newItem.productSpec
    }
    
    
    func shouldVendFavoriteProduct(to person: String) throws -> ProductSpecification {
        
        guard let sweetName = favoriteSweet[person] else { throw BuyerError.buyerNotFound }
        
        return try shouldVend(itemForSale: sweetName)
    }
    
    
    func vend(itemForSale itemKeyWord: String) -> (ProductSpecification?, VendingMachineError?) {
        
        guard let item = inventory[itemKeyWord] else {
            return (nil, VendingMachineError.invalidSelection)
        }
        guard item.count > 0 else {
            return (nil, VendingMachineError.outOfStock)
        }
        guard item.price <= coinsDeposited else {
            return (nil, VendingMachineError.insufficienFunds(coinsNeeded: item.price - coinsDeposited))
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        
        newItem.count -= 1
        
        inventory[itemKeyWord] = newItem
        
        return (newItem.productSpec, nil)
    }
}



class VendingMachine {
    
    var vendor: SalesMakeable?
    
    
    func insertCoin(coinsDeposited: Int) {
        guard vendor != nil else { print("Внести монеты невозможно. Продавец не определен"); return }
        guard coinsDeposited >= 0 else { print("Неверный номинал монет"); return }
        vendor?.coinsDeposited += coinsDeposited
    }
    
    
    func getChange() -> Int {
        guard vendor != nil else { return 0 }
        
        let change = vendor?.coinsDeposited ?? 0
        vendor?.coinsDeposited = 0
        return change
    }
    
    
    func pressBuyButton(itemForSale: String ) {
        
        guard vendor != nil else { print("Продажа товара \(itemForSale) невозможна. Продавец не определен"); return }
        
        do {
            if let product = try vendor?.shouldVend(itemForSale: itemForSale) {
                print("Возьмите пожалуйста \(product.productName)")
            }
        } catch VendingMachineError.invalidSelection {
            print("Товара \(itemForSale) не существует")
        } catch VendingMachineError.outOfStock {
            print("Товар \(itemForSale) временно отсутствует в продаже")
        } catch VendingMachineError.insufficienFunds(let coinsNeeded) {
            print("Внесенная сумма недостаточна. Необходимо внести \(coinsNeeded) монет")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func pressBuyFavoriteProductButton(for person: String) {
        
        guard vendor != nil else { print("Продажа товара невозможна. Продавец не определен"); return }
        
        do {
            if let product = try vendor?.shouldVendFavoriteProduct(to: person) {
                print("\(person), возьмите пожалуйста ваш любимый продукт \(product.productName)")
            }
        } catch BuyerError.buyerNotFound {
            print("Покупатель \(person) не найден")
        } catch VendingMachineError.invalidSelection {
            print("\(person), вашего любимого товара не существует в базе")
        } catch VendingMachineError.outOfStock {
            print("\(person), ваш любимый товар временно отсутствует в продаже")
        } catch VendingMachineError.insufficienFunds(let coinsNeeded) {
            print("Внесенная сумма недостаточна. Необходимо внести \(coinsNeeded) монет")
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    
    func pressOptionalBuyButton(itemForSale: String) {
        
        guard vendor != nil else { print("Продажа товара \(itemForSale) невозможна. Продавец не определен"); return }
        
        if let purchase = vendor?.vend(itemForSale: itemForSale) {
            
            switch purchase {
            case (nil, .invalidSelection?) :
                print("Товара \(itemForSale) не существует")
            case (nil, .outOfStock?) :
                print("Товар \(itemForSale) временно отсутствует в продаже")
            case (nil, .insufficienFunds(let coinsNeeded)?) :
                print("Внесенная сумма недостаточна. Необходимо внести \(coinsNeeded) монет")
            case ( _ , nil) :
                if let product = purchase.0 {
                    print("Возьмите пожалуйста \(product.productName)")
                }
            default:
                if let error = purchase.1 {
                    print(error.localizedDescription)
                }
            }
        }
    }
}






let vendingMachine = VendingMachine()

print("Проверка обработки ошибок оператором try/catch:")

print("\nКогда продавец не определен:")
vendingMachine.insertCoin(coinsDeposited: 10)
print("Ваша сдача: \(vendingMachine.getChange()) монет")
vendingMachine.pressBuyButton(itemForSale: "Fanta")

print("\nОпредили продавца напитков")
vendingMachine.vendor = ColdDrinkVendor()

print("\nПродажа любимого напитка:")
vendingMachine.pressBuyFavoriteProductButton(for: "Timothy")
vendingMachine.pressBuyFavoriteProductButton(for: "Roman")
vendingMachine.insertCoin(coinsDeposited: 60)
vendingMachine.pressBuyFavoriteProductButton(for: "Roman")
print("Ваша сдача: \(vendingMachine.getChange()) монет")

print("\nПопытка продажи несуществующего напитка:")
vendingMachine.pressBuyButton(itemForSale: "Ice Tea")

print("")
vendingMachine.insertCoin(coinsDeposited: 5)
vendingMachine.pressBuyButton(itemForSale: "Fanta")
vendingMachine.insertCoin(coinsDeposited: 21)
vendingMachine.pressBuyButton(itemForSale: "Fanta")
print("Ваша сдача: \(vendingMachine.getChange()) монет\n")

vendingMachine.insertCoin(coinsDeposited: 40)
vendingMachine.pressBuyButton(itemForSale: "Fanta")
vendingMachine.pressBuyButton(itemForSale: "Fanta")
print("Ваша сдача: \(vendingMachine.getChange()) монет")


print("\n\nОпредили продавца сладостей")
vendingMachine.vendor = SweetsVendor()

print("\nПродажа любимых сладостей:")
vendingMachine.pressBuyFavoriteProductButton(for: "Timothy")
vendingMachine.pressBuyFavoriteProductButton(for: "Roman")
vendingMachine.insertCoin(coinsDeposited: 60)
vendingMachine.pressBuyFavoriteProductButton(for: "Roman")
print("Ваша сдача: \(vendingMachine.getChange()) монет")

print("\nПопытка продажи несуществующей сладости:")
vendingMachine.pressBuyButton(itemForSale: "Picnic")


print("\n\nПроверка обработки ошибок, вернувшихся в кортеже:\n")

print("Попытка продажи несуществующей сладости:")
vendingMachine.pressOptionalBuyButton(itemForSale: "Nuts")

print("")
vendingMachine.insertCoin(coinsDeposited: 5)
vendingMachine.pressOptionalBuyButton(itemForSale: "KitKat")
vendingMachine.insertCoin(coinsDeposited: 21)
vendingMachine.pressOptionalBuyButton(itemForSale: "KitKat")
print("Ваша сдача: \(vendingMachine.getChange()) монет\n")

vendingMachine.insertCoin(coinsDeposited: 40)
vendingMachine.pressOptionalBuyButton(itemForSale: "KitKat")
print("Ваша сдача: \(vendingMachine.getChange()) монет")
