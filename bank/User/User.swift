import Foundation

struct Address: Codable {
    let country: String
    let city: String
    let street: String
    let house: String
    let flat: Int
    let floor: Int
}

struct Phone: Codable, Equatable {
    let countryCode: Int
    let numberPhone: Int
}

struct User: Codable {
    let id: String
    let name: String
    let secondName: String
    let lastName: String
    let email: String
    let phone: Phone
    let address: Address
}

//struct BankAccount: Codable {
//
//    var storage: Storage
//    var userStorage: UserStorage
//    var deposit: Float
//
//    func addMoney(summ: Float, user: User){
//        guard let userArray = try storage.get(key: "depositMoney_\(user.id)") else {
//        }
//    }
//    func removeMoney(summ: Float, user: User){
//
//    }
//}
