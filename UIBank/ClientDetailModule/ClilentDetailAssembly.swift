import EasyDi

class ClientDetailModuleAssembly: Assembly {
    var viewcontroller: ClientDetailVC {
        define(init: (ViewControllersFactory().viewController(identifier: "ClientDetailVC"))) {
            return $0
        }
    }
}
