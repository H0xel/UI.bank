import Foundation

struct Credit: Codable {
    let summ: Float
    let months: Int
    let percentYear: Float
}

enum CashOutType: String, Codable {
    case month
    case year
}

struct Deposit: Codable {
    let percent: Float
    let summ: Float
    let type: CashOutType
}

enum ProductType: Codable {
    case credit(Credit)
    case deposit(Deposit)
    
    // 1 шаг - определить ключи, которые будут в жсоне
    enum CodingKeys: String, CodingKey {
        case credit
        case deposit
    }
    
    enum ProductTypeDecodingError: Error {
        case wrongNumberOfKeys
    }
    
    // 2 шаг - описываем конструктор https://developer.apple.com/documentation/swift/decoder/2892621-container
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard container.allKeys.count == 1,
              let key = container.allKeys.first else {
            throw ProductTypeDecodingError.wrongNumberOfKeys
        }
        
        switch key {
        case .credit:
            let credit = try container.decode(Credit.self, forKey: .credit)
            self = .credit(credit)
        case .deposit:
            let deposit = try container.decode(Deposit.self, forKey: .deposit)
            self = .deposit(deposit)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        switch self {
        case let .credit(credit):
            try container.encode(credit, forKey: .credit)
        case let .deposit(deposit):
            try container.encode(deposit, forKey: .deposit)
        }
    }
}

struct Product: Codable {
    let id: String
    let name: String
    let type: ProductType
}

//extension Product {
//    func add(money: Float) -> Product {
//        switch self {
//        case let .deposit(deposit):
//            return Product(id: id, name: name, type: .deposit(Deposit(percent: deposit.percent, summ: deposit.summ + money, type: deposit.type)))
//        case let .credit(credit):
//            return Product(id: id, name: name, type: .credit(Credit(summ: credit.summ, months: months, percentYear: <#T##Float#>)))
//        }
//    }
//}



