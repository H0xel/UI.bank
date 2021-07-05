import Foundation
import EasyDi


//class FastPaymentsService: Assembly {
//
////    lazy var moneyService: ServicesAssemblyTwo = context.assembly()
//    let moneyService = ServicesAssemblyTwo().MoneyService
//
//    func send(from: Phone, summ: Float, to: Phone) throws {
//        try moneyService.send(from: from, summ: summ)
//        try moneyService.recieve(summ: summ, phone: to)
//
//    }
//}

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





