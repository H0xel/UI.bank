import Foundation

struct Formater {
    func format(phone: Phone) -> String {
        return "\(phone.countryCode) \(phone.numberPhone)"
    }
    func format(adress: Address) -> String {
        return "\(adress.country) \(adress.city) \(adress.street) \(adress.house) \(adress.floor) \(adress.flat)"
    }
    func format(fullname: User) -> String {
        return "\(fullname.name) \(fullname.secondName) \(fullname.lastName)"
    }
}
