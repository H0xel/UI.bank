import Foundation

enum MoneyServiceError: Error {
    case productNotFound
}

enum MoneySenderError: Error {
    case userNotFound
    case insuffisentFunds
    case productReferensesNotFound
}

enum MoneyRecieverError: Error {
    case userNotFound
    case noValidProducts
    case productPreferencesNotFound
}

protocol MoneyReciever {
    func recieve(summ: Float, phone: Phone) throws
}

protocol MoneySender {
    func send(from: Phone, summ: Float) throws
}


typealias MoneyService = MoneySender & MoneyReciever


class MoneyServiceImpl: MoneyService {
    
    let userStorage: UserStorage
    let productStorage: ProductStorage
    let productService: ProductService
    let preferencesService: PreferencesService
    
    init(userStorage: UserStorage,
         productStorage: ProductStorage,
         productService: ProductService,
         preferencesService: PreferencesService) {
        self.userStorage = userStorage
        self.productStorage = productStorage
        self.productService = productService
        self.preferencesService = preferencesService
    }
    
    func send(from phone: Phone, summ: Float) throws {
        let user = try userStorage.search(phone: phone)
        let productArray = productStorage.get(user: user)
        guard let productId = preferencesService.getPreferences(user: user) else {
            throw MoneySenderError.productReferensesNotFound
        }
        if let product = productArray.first(where: {$0.id == productId.productSenderID}) {
        let productMoneySend = try productService.remove(money: summ, product: product)
            productStorage.add(user: user, product: productMoneySend)
        } else {
        let productMoneySend = try productService.remove(money: summ, product: productArray[0])
            productStorage.add(user: user, product: productMoneySend)
        }
    }
    
    func recieve(summ: Float, phone: Phone) throws {
        let user = try userStorage.search(phone: phone)
        let productArray = productStorage.get(user: user)
        guard let productId = preferencesService.getPreferences(user: user) else {
            throw MoneyRecieverError.productPreferencesNotFound
        }
        if let product = productArray.first(where: {$0.id == productId.productSenderID}) {
        let productMoneyReceive = try productService.add(money: summ, product: product)
            productStorage.add(user: user, product: productMoneyReceive)
        } else {
            let productMoneyReceive = try productService.add(money: summ, product: productArray[0])
            productStorage.add(user: user, product: productMoneyReceive)
        }
    }
}


//Логика 1 и 2 пункта будет находиться тут
//Подготовиться к ретро подумать что получилось/не получилось/что нужно улучшить в нашем процессе обучения



//func settings(user: User, productType: ProductType) -> Product {
//    
//    let products = get(user: user)
//    
//    
//    return Product(id: <#T##String#>, name: <#T##String#>, type: productType)
//}
