//
//  ProductDetailPresenterAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 13.08.2021.
//

import EasyDi

class ProductDetailPresenterAssembly: Assembly {
    private lazy var router: UserRouterAssembly = context.assembly()
    private lazy var services: ServicesAssembly = context.assembly()
    
    func productDetailAssembly(user: User, product: Product, view: ProductDetailPresenterView, viewcontroller: UIViewController) ->  ProductDetailPresenterImpl {
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
