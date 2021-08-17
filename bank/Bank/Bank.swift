import Foundation

enum BankErrors: Error {
    case productNotFound
}


protocol Bank {
    func createClient(name: String,
                      secondName: String,
                      lastName: String,
                      email: String,
                      phone: Phone,
                      address: Address) -> User
    func createDepositProduct(user: User) -> Product
    func createCreditProduct(user: User) -> Product
    func add( phone: Phone, product: Product, money: Float) throws
    func remove( phone: Phone, product: Product, money: Float) throws
    func getPreferences(user: User) -> ProductPreferences?
    func set(preferences: ProductPreferences, user: User)
    func users() -> [User]
    func search(phone: Phone) throws -> User
    func products(user: User) -> [Product]
}

class BankImpl {
    
    let userStorage: UserStorage
    let productStorage: ProductStorage
    let productService: ProductService
    let preferencesService: PreferencesService
    
    
    init(
        storage: UserStorage,
        productStorage: ProductStorage,
        productService: ProductService,
        preferencesService: PreferencesService
        ) { // инъекция зависимости
        userStorage = storage
        self.productStorage = productStorage
        self.productService = productService
        self.preferencesService = preferencesService
    }
}

extension BankImpl: Bank {
    
    func products(user: User) -> [Product] {
        productStorage.get(user: user)
    }
    
    func search(phone: Phone) throws -> User {
        let user = try userStorage.search(phone: phone)
        return user
    }
    
    func users() -> [User] {
        return userStorage.users()
    }
    
    
    func getPreferences(user: User) -> ProductPreferences? {
        preferencesService.getPreferences(user: user)
    }
    
    func set(preferences: ProductPreferences, user: User) {
        preferencesService.set(preferences: preferences, user: user)
    }
    
    
    func createClient(name: String, secondName: String, lastName: String, email: String, phone: Phone, address: Address) -> User {
        let user = User(id: UUID().uuidString,
                        name: name,
                        secondName: secondName,
                        lastName: lastName,
                        email: email,
                        phone: phone,
                        address: address)
        do {
            
        try userStorage.add(user: user)
            
        } catch {
            print("User exists")
        }
        
        return user
    }
    
    func createDepositProduct(user: User) -> Product {
        let product = Product(id: UUID().uuidString,
                              name: "Разделяй и зарабатывай!",
                              type: .deposit(Deposit(percent: 12, summ: 0, type: .month)))
        
        productStorage.add(user: user, product: product)
        preferencesService.set(preferences: ProductPreferences(productReceiverID: product.id, productSenderID: product.id), user: user)
        
        return product
    }
    
    func createCreditProduct(user: User) -> Product {
        let product = Product(id: UUID().uuidString,
                              name: "Бери щас плати всю жизнь!",
                              type: .credit(Credit(summ: 15_000, months: 12, percentYear: 720)))
        
        productStorage.add(user: user, product: product)
        
        return product
    }
    
    func add(phone: Phone, product: Product, money: Float) throws {
        
        let user = try userStorage.search(phone: phone)
        let productArray = productStorage.get(user: user)
        guard let productIndex = productArray.firstIndex(where: {$0.id == product.id}) else {
            throw BankErrors.productNotFound
        }
            let overrideProduct = try productService.add(money: money, product: productArray[productIndex])
            productStorage.add(user: user, product: overrideProduct)
    }
    
    func remove(phone: Phone, product: Product, money: Float) throws{
        
        let user = try userStorage.search(phone: phone)
        let productArray = productStorage.get(user: user)
        guard let productIndex = productArray.firstIndex(where: {$0.id == product.id}) else {
            throw BankErrors.productNotFound
        }
        let overrideProduct = try productService.remove(money: money, product: productArray[productIndex])
        productStorage.add(user: user, product: overrideProduct)
    }
}
