import Foundation
import EasyDi

class ServicesAssembly: Assembly {
    
    private lazy var storageAssembly: StoragesAssembly = context.assembly()
    
    var productService: ProductService {
        return define(init: ProductServiceImpl())
    }
    
    var fastPaymentService: FastPaymentsService {
        return define(init: FastPaymentsServiceImpl()) {
            $0.moneyService = self.MoneyService
            return $0
        }
    }
    
    
    var preferencesService: PreferencesService {
        define(init: PreferencesServiceImpl()) {
            $0.storage = self.storageAssembly.inMemory
            return $0
        }
    }
    var MoneyService: MoneyService {
        
        return define(init: MoneyServiceImpl(userStorage: self.storageAssembly.userStorage,
                                             productStorage: self.storageAssembly.productStorage,
                                             productService: self.productService,
                                             preferencesService: self.preferencesService))
    }
}


