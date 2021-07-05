import Foundation

enum ProductServiceError: Error {
    case productNotFillable
    case notEnoughtMoney
}

protocol ProductService {
    func add(money: Float, product: Product) throws -> Product
    func remove(money: Float, product: Product) throws -> Product
}

class ProductServiceImpl: ProductService {
    
    func add(money: Float, product: Product) throws -> Product {
        switch product.type {
        case let .deposit(deposit):
            return Product(id: product.id, name: product.name, type: .deposit(Deposit(percent: deposit.percent, summ: deposit.summ + money, type: deposit.type)))
        case .credit:
            throw ProductServiceError.productNotFillable
        }
    }
    
    func remove(money: Float, product: Product) throws -> Product {
        
        switch product.type {
        case let .deposit(deposit):
            guard deposit.summ >= money else {
                throw ProductServiceError.notEnoughtMoney
            }
            return Product(id: product.id, name: product.name, type: .deposit(Deposit(percent: deposit.percent, summ: deposit.summ - money, type: deposit.type)))
        case .credit:
            throw ProductServiceError.productNotFillable
        }
    }
}

