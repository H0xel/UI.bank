import Foundation
import EasyDi

class BankAssembly: Assembly {
    
    lazy var storagesAssembly: StoragesAssembly = context.assembly()
    lazy var servicesAssembly: ServicesAssembly = context.assembly()
    
    var bank: Bank {
        return define(init: BankImpl(storage: self.storagesAssembly.userStorage,
                                     productStorage: self.storagesAssembly.productStorage,
                                     productService: self.servicesAssembly.productService,
                                     preferencesService: self.servicesAssembly.preferencesService))
    }
}
