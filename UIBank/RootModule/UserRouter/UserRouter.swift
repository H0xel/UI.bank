import UIKit

protocol UserRouter {
    func userDetails(user: User)
    func productDetails(user: User, product: Product)
    func createProduct(user: User, result: @escaping (Product) -> ())
    func dissmiss()
}

class UserRouterImpl: UserRouter {
    weak var viewController: UIViewController?
    
    func userDetails(user: User) {
        let vc = ClientDetailModuleAssembly.instance().viewcontroller(user: user)
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func createProduct(user: User, result: @escaping (Product) -> ()) {
        let vc = CreateProductAssembly.instance().viewcontroller(user: user, result: result)
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func productDetails(user: User, product: Product) {
        let vc = ProductDetailModuleAssembly.instance().viewcontroller(user: user, product: product)
        viewController?.present(vc, animated: true, completion: nil)
    }
    
    func dissmiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    func test() {
        print(0)
        test2 {
            print(viewController)
        }
        print(4)
    }
    
    func test2(completion: () -> Void) {
        print(1)
        completion()
        print(2)
    }
}



