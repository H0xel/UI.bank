import UIKit

protocol UserRouter {
    func userDetails(user: User)
    func productDetails(user: User, product: Product)
}

class UserRouterImpl: UserRouter {
    weak var viewController: UIViewController?
    
    func userDetails(user: User) {
        let vc = ClientDetailModuleAssembly.instance().viewcontroller(user: user)
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func productDetails(user: User, product: Product) {
        let vc = ProductDetailModuleAssembly.instance().viewcontroller(user: user, product: product)
        viewController?.present(vc, animated: true, completion: nil)
    }
}


