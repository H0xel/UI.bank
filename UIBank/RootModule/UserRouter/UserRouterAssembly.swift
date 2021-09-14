import EasyDi

class UserRouterAssembly: Assembly {
    
    func router(viewController: UIViewController) -> UserRouter {
        define(init: UserRouterImpl()) {
            $0.viewController = viewController
            return $0
        }
    }
}
