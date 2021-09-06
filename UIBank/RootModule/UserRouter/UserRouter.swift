import UIKit

protocol UserRouter {
    func userDetails(user: User)
    func productDetails(user: User, product: Product)
    func createProduct(user: User)
    func dissmiss()
}

class UserRouterImpl: UserRouter {
    weak var viewController: UIViewController?
    
    func userDetails(user: User) {
        let vc = ClientDetailModuleAssembly.instance().viewcontroller(user: user)
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func createProduct(user: User) {
        let vc = CreateProductAssembly.instance().viewcontroller(user: user)
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func productDetails(user: User, product: Product) {
        let vc = ProductDetailModuleAssembly.instance().viewcontroller(user: user, product: product)
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}



