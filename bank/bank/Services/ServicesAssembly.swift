import Foundation

class ServicesAssembly {
    private let storage = StoragesAssembly()
    
    var productService: ProductService {
        return ProductServiceImpl()
    }
    
    var fastPaymentService: FastPaymentsService {
        return FastPaymentsService()
    }
    
    var preferencesService: PreferencesService {
        let preferencesService = PreferencesServiceImpl()
        preferencesService.storage = storage.inMemory
        return preferencesService
    }
    
    var MoneyService: MoneyService {
        let moneyService = MoneyServiceImpl(userStorage: storage.userStorage,
                                            productStorage: storage.productStorage,
                                            productService: productService,
                                            preferencesService: preferencesService)
        return moneyService
    }
}

