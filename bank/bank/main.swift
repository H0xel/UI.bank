import Foundation



let assembly = BankAssembly()
let bank = assembly.bank

let serviceAssembly = ServicesAssembly()
let moneyService = serviceAssembly.MoneyService

let testclient1 = bank.createClient(name: "John",
                                    secondName: "John",
                                    lastName: "John",
                                    email: "John",
                                    phone: Phone(countryCode: 7, numberPhone: 998_123_45_67), address: Address(country: "Russia", city: "Moscow", street: "Random", house: "Random", flat: 1, floor: 1))

let testclient2 = bank.createClient(name: "Ivan",
                                    secondName: "Ivanovich",
                                    lastName: "Ivanovich",
                                    email: "test",
                                    phone: Phone(countryCode: 7, numberPhone: 999_123_45_67),
                                    address: Address(country: "Russia", city: "Moscow", street: "Random", house: "Random", flat: 1, floor: 1))

var depositProduct = bank.createDepositProduct(user: testclient1)
var depositProduct1 = bank.createDepositProduct(user: testclient2)

try bank.add(phone: Phone(countryCode: 7, numberPhone: 998_123_45_67), product: depositProduct, money: 200)
printData(key: "products_of_user_\(testclient1.id)", type: [Product].self)

try bank.remove(phone: Phone(countryCode: 7, numberPhone: 998_123_45_67), product: depositProduct, money: 100)
printData(key: "products_of_user_\(testclient1.id)", type: [Product].self)

try bank.add(phone: Phone(countryCode: 7, numberPhone: 998_123_45_67), product: depositProduct, money: 200)
printData(key: "products_of_user_\(testclient1.id)", type: [Product].self)

//var preferences = ProductPreferences(productReceiverID: depositProduct.id, productSenderID: depositProduct.id)
//bank.set(preferences: preferences, user: testclient1) - вместо этогоо сделал проксирование PreferencesServiceImpl().set(preferences: ProductPreferences(productReceiverID: product.id, productSenderID: product.id), user: user) при создании Депозитного счета

printData(key: "preferences_id_\(testclient1.id)", type: ProductPreferences.self)

//var preferences2 = ProductPreferences(productReceiverID: depositProduct1.id, productSenderID: depositProduct1.id)
//bank.set(preferences: preferences2, user: testclient2)


try moneyService.send(from: Phone(countryCode: 7, numberPhone: 998_123_45_67), summ: 200)
try moneyService.recieve(summ: 200, phone: Phone(countryCode: 7, numberPhone: 999_123_45_67))

printData(key: "products_of_user_\(testclient1.id)", type: [Product].self)
printData(key: "products_of_user_\(testclient2.id)", type: [Product].self)

// прочитать про ключевое слово static, что это такое



/*
 
 Проблема №2 - нет возможности вытащить депозитный продукт
 
 
 */
