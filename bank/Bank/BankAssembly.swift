import Foundation

class BankAssembly {
    
    let storagesAssembly = StoragesAssembly()
    let servicesAssembly = ServicesAssembly()
    
    var bank: Bank {
        return BankImpl(storage: storagesAssembly.userStorage,
                        productStorage: storagesAssembly.productStorage,
                        productService: servicesAssembly.productService,
                        preferencesService: servicesAssembly.preferencesService)
    }
}


