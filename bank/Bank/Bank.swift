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
    // func products(user: User) -> [Product]
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


/*
 
 -2. Избавиться от for и if в работе с массивами - вернуться к концепции first(where: ), filter(where:) и т д
 
 -1. Предварительно в protocol Bank добавить метод списания средств со счета.
 
 0. Предварительно в protocol Bank внести изменения - сделать метод, добавляющий денег на счет.

 1. Банк должен реализовать протокол MoneySender. В методе send(from: Phone, summ: Float) нужно проверить:
 
  - существует ли клиент с номером телефона Phone. Если не найден - кидаете ошибку MoneySenderError.userNotFound
 
  - Если существует - идете в счета юзера. Нельзя отправить бабки с кредитного счета. Нельзя отправить бабки с дебетного счета, если там недостаточно средств. Если не выполняется одно из условий - кидаете ошибку MoneySenderError.insuffisentFunds.
 
 - если все ок - берем дебетный счет и списываем деньги.
 
 2. Банк должен реализовать протокол MoneyReciever.
 
  - существует ли клиент с номером телефона Phone. Если не существует - кидаем ошибку MoneyRecieverError.userNotFound
 
  - Если существует - берем продукты юзера. Если продуктов нет - кидаем ошибку MoneyRecieverError.noValidProducts
 
  - Если есть дебетные счета - пополняем (с помощью пункта 0) первый дебетный счет. Если нету - то пополняем кредитный счет;
 
 3. FastPaymentsService send(from: Phone, summ: Float, to: Phone) throws как реализовать метод:
 
    - идем в цикле по banks. У каждого элемента вызываем метод send(from: Phone, summ: Float). в do блоке если прошли за метод try bank.send() -> значит, что бабки списались и начинаем их отправлять, выходим из цикла (break)
 
    - идем в цикле по banks. У каждого элемента вызываем метод try bank.recieve(). если успешно -> печатаем в консоль успех!!!
 
 4. Дебаг - как понять, что деньги ушли? В протокол Bank добавляем метод products(of: User) - достаем все продукты юзеров и печатаем баланс после перевода - смотрим, перевелись ли деньги.;
 
 */







//let service = FastPaymentsAssembly().service
//let bank1 = BankAssembly().bank
//let bank2 = BankAssembly().bank
//
// создать клиентов, создать продукты клиентам, положить деньги на счет клиентов (пункт 0)
//
//service.register(receiver: bank1)
//service.register(reciever: bank2)
//
//service.send(summ: <#T##Float#>, phone: <#T##Phone#>)
