//
//  ProductDetailAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import EasyDi

class ProductDetailModuleAssembly: Assembly {
    private lazy var router: UserRouterAssembly = context.assembly()
    private lazy var services: ServicesAssembly = context.assembly()
    
    func viewcontroller(user: User, product: Product) -> UIViewController {
        define(init: (ViewControllersFactory().viewController(identifier: "ProductDeatilViewController") as ProductDeatilViewController)) {
            $0.presenter = self.presenter(user: user, product: product, view: $0, viewcontroller: $0)
            return $0
        }
    }
}

extension ProductDetailModuleAssembly {

    func presenter(user: User, product: Product, view: ProductDetailPresenterView, viewcontroller: UIViewController) ->  ProductDetailPresenter {
        define(init: ProductDetailPresenterImpl()) {
            $0.view = view
            $0.router = self.router.router(viewController: viewcontroller)
            $0.user = user
            $0.product = product
            $0.moneyService = self.services.MoneyService
            $0.fastPaymentService = self.services.fastPaymentService
            return $0
        }
    }
}
