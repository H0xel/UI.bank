import EasyDi

class ClientDetailModuleAssembly: Assembly {
    var clientDetail: ClientDetailVC {
        define(init: (ViewControllersFactory().viewController(identifier: "ClientDetailVC"))) {
            return $0
        }
    }
}
