import EasyDi

class ClientDetailModuleAssembly: Assembly {
    private lazy var bank: BankAssembly = context.assembly()
    private lazy var router: UserRouterAssembly = context.assembly()
    
    func viewcontroller(user: User) -> UIViewController {
        define(init: (ViewControllersFactory().viewController(identifier: "ClientDetailVC") as ClientDetailVC)) {
            $0.presenter = self.presenter(user: user, view: $0, viewController: $0)
            return $0
        }
    }
}

extension ClientDetailModuleAssembly {

    func presenter(user: User, view: ClientPresenterView, viewController: UIViewController) -> ClientDetailPresenter {
        define(init: ClientDetailPresenterImpl()) {
            $0.view = view
            $0.bank = self.bank.bank
            $0.userProducts = self.bank.bank.products(user: user)
            $0.user = user
            $0.router = self.router.router(viewController: viewController)
            return $0
        }
    }
}
