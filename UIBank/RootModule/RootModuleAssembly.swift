import EasyDi

class RootModuleAssembly: Assembly {
    
    private lazy var registeClientAssembly: RegisterClientAseembly = context.assembly()
    private lazy var lastAddedClientAssembly: LastAddedClientAssembly = context.assembly()
    private lazy var showClientAssembly: ShowClientsAssembly = context.assembly()
    private lazy var transactionAssembly: TransactionAssembly = context.assembly()
    
    var tabBarController: TabBarController {
        define(init: (ViewControllersFactory().tabBarController(identifier: "TabBarController") as TabBarController)) {
            $0.registeClientAssembly = self.registeClientAssembly
            $0.lastAddedClientAssembly = self.lastAddedClientAssembly
            $0.showClientAssembly = self.showClientAssembly
            $0.transactionAssembly = self.transactionAssembly
            return $0
        }
    }
}


