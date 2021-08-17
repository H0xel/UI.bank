import EasyDi

class LastAddedClientAssembly: Assembly {
    private lazy var bankAssembly: BankAssembly = context.assembly()
    
    var viewcontroller: LastAddedClientController {
        define(init: (ViewControllersFactory().viewController(identifier: "LastAddedClientController") as LastAddedClientController)) {
            $0.presenter = self.presenter(view: $0)
            return $0
        }
    }
}


extension LastAddedClientAssembly {
    func presenter(view: LastAddedClientView) -> LastAddedClientPresenter {
        define(init: lastAddedClientPresenterImpl()) {
            $0.view = view
            $0.bank = self.bankAssembly.bank
            return $0
        }
    }
}

