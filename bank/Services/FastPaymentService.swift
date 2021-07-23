import Foundation
import EasyDi

protocol FastPaymentsService {
    func send(from: Phone, summ: Float, to: Phone) throws
}

class FastPaymentsServiceImpl: FastPaymentsService {
    
    
    var moneyService: MoneyService! // инъекция
    
    
    func send(from: Phone, summ: Float, to: Phone) throws {
     
        try moneyService.send(from: from, summ: summ)
        try moneyService.recieve(summ: summ, phone: to) // done
    }
}





