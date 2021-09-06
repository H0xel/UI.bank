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
    func format(product: Product) -> String {
            switch product.type {
            case let .credit(credit):
                return "Кредит - \(credit.summ)"
            case let .deposit(deposit):
            return "Депозит - \(deposit.summ)"
            }
    }
}



