import UIKit



enum VendingMachineError: Error {
    
    case invalidSelection
    case outOfStock
    case insufficienFunds(coinsNeeded: Int)
}



struct ItemToVend {
    
    var price: Int
    var count: Int
    let product: ProductSpecifications
}



struct ProductSpecifications {
    
    let productName: String
}



protocol SalesMakeable {
    
    var coinsDeposited: Int { get set }
    func shouldVend(itemForSale item: String) throws -> ProductSpecifications
}



class ColdDrinksVendor: SalesMakeable {
    
    var inventory: [String : ItemToVend] = [
        "Cola" : ItemToVend(price: 50, count: 10, product: ProductSpecifications(productName: "Cola Vanilla")),
        "Pepsi" : ItemToVend(price: 30, count: 5, product: ProductSpecifications(productName: "Pepsi Cherry")),
        "Fanta" : ItemToVend(price: 20, count: 3, product: ProductSpecifications(productName: "Fanta Zero"))
    ]
    
    var coinsDeposited: Int = 0
    
    func shouldVend(itemForSale itemKeyWord: String) throws -> ProductSpecifications {
        
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
        
        return newItem.product
    }
}



class VendingMachine {
    
    var vendor: SalesMakeable?
    
//    init(vendor: SalesMakeable) {
//        self.vendor = vendor
//    }
    
    func insertCoin(coinsDeposited: Int) {
        vendor?.coinsDeposited = coinsDeposited
    }
    
    func pressBuyButton(itemForSale: String ) {
        vendor?.shouldVend(itemForSale: itemForSale)
           
    }
}






let vendingMachine = VendingMachine()
vendingMachine.vendor = ColdDrinksVendor()



