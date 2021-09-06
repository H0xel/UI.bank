import EasyDi

class RootModuleAssembly: Assembly {
    
    private lazy var registeClientAssembly: RegisterClientAseembly = context.assembly()
    private lazy var lastAddedClientAssembly: LastAddedClientAssembly = context.assembly()
    private lazy var showClientAssembly: ShowClientsAssembly = context.assembly()
    private lazy var transactionAssembly: TransactionAssembly = context.assembly()
    
    var tabBarController: TabBarController {
        define(init: TabBarController(registerAsembly: self.registeClientAssembly,
                                      lastAddedClientAseembly: self.lastAddedClientAssembly,
                                      showClientAssembly: self.showClientAssembly,
                                      transactionAssembly: self.transactionAssembly))
    }
}


