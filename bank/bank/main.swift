import Foundation



let assembly = BankAssembly()

let bank = assembly.bank
let bank2 = assembly.bank

let serviceAssembly = ServicesAssembly()
let moneyService = serviceAssembly.MoneyService
let fastPaymentService = serviceAssembly.fastPaymentService


let testclient1 = bank.createClient(name: "John",
                                    secondName: "John",
                                    lastName: "John",
                                    email: "John",
                                    phone: Phone(countryCode: 7, numberPhone: 998_123_45_67),
                                    address: Address(country: "Russia", city: "Moscow", street: "Random", house: "Random", flat: 1, floor: 1))

let testclient2 = bank.createClient(name: "Ivan",
                                    secondName: "Ivanovich",
                                    lastName: "Ivanovich",
                                    email: "test",
                                    phone: Phone(countryCode: 7, numberPhone: 999_123_45_67),
                                    address: Address(country: "Russia", city: "Moscow", street: "Random", house: "Random", flat: 1, floor: 1))

var depositProduct = bank.createDepositProduct(user: testclient1)
var depositProduct1 = bank.createDepositProduct(user: testclient2)

try bank.add(phone: Phone(countryCode: 7, numberPhone: 998_123_45_67), product: depositProduct, money: 3000)
printData(key: "products_of_user_\(testclient1.id)", type: [Product].self)

let testclient1Bank2 = bank2.createClient(name: "John",
                                    secondName: "John",
                                    lastName: "John",
                                    email: "John",
                                    phone: Phone(countryCode: 7, numberPhone: 916_123_45_67),
                                    address: Address(country: "Russia", city: "Moscow", street: "Random", house: "Random", flat: 1, floor: 1))

let testclient2Bank2 = bank2.createClient(name: "Ivan",
                                    secondName: "Ivanovich",
                                    lastName: "Ivanovich",
                                    email: "test",
                                    phone: Phone(countryCode: 7, numberPhone: 903_123_45_67),
                                    address: Address(country: "Russia", city: "Moscow", street: "Random", house: "Random", flat: 1, floor: 1))

var depositProductBank2 = bank2.createDepositProduct(user: testclient1Bank2)
var depositProduct1Bank2 = bank2.createDepositProduct(user: testclient2Bank2)

try bank2.add(phone: Phone(countryCode: 7, numberPhone: 916_123_45_67), product: depositProductBank2, money: 200)
printData(key: "products_of_user_\(testclient1Bank2.id)", type: [Product].self)

//var preferences = ProductPreferences(productReceiverID: depositProduct.id, productSenderID: depositProduct.id)
//bank.set(preferences: preferences, user: testclient1) - вместо этогоо сделал проксирование PreferencesServiceImpl().set(preferences: ProductPreferences(productReceiverID: product.id, productSenderID: product.id), user: user) при создании Депозитного счета

printData(key: "preferences_id_\(testclient1.id)", type: ProductPreferences.self)

//var preferences2 = ProductPreferences(productReceiverID: depositProduct1.id, productSenderID: depositProduct1.id)
//bank.set(preferences: preferences2, user: testclient2)

try fastPaymentService.send(from: Phone(countryCode: 7, numberPhone: 998_123_45_67),
                            summ: 100,
                            to: Phone(countryCode: 7, numberPhone: 999_123_45_67))

printData(key: "products_of_user_\(testclient1.id)", type: [Product].self)
printData(key: "products_of_user_\(testclient2.id)", type: [Product].self)

try fastPaymentService.send(from: Phone(countryCode: 7, numberPhone: 998_123_45_67),
                            summ: 200,
                            to: Phone(countryCode: 7, numberPhone: 916_123_45_67))

printData(key: "products_of_user_\(testclient1.id)", type: [Product].self)
printData(key: "products_of_user_\(testclient1Bank2.id)", type: [Product].self)
