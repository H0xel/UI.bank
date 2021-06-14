import Foundation

class FastPaymentsService {
    
    let moneyService = ServicesAssembly().MoneyService
    
    var banks = [MoneyReciever & MoneySender]()
    

    func send(from: Phone, summ: Float, to: Phone) throws {
        try moneyService.send(from: from, summ: summ)
        try moneyService.recieve(summ: summ, phone: to)
    }
    
    func register(bank: MoneyReciever & MoneySender) {
        banks.append(bank)
    }
}







