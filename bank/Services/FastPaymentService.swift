import Foundation

class FastPaymentsService {
    
    let moneyService = ServicesAssembly().MoneyService
    
    func send(from: Phone, summ: Float, to: Phone) throws {
        try moneyService.send(from: from, summ: summ)
        try moneyService.recieve(summ: summ, phone: to)
        
    }
}







