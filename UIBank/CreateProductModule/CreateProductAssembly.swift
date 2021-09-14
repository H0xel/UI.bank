//
//  CreateProductAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 30.08.2021.
//

import Foundation
import EasyDi



class CreateProductAssembly: Assembly {
    
    private lazy var router: UserRouterAssembly = context.assembly()
    private lazy var bank: BankAssembly = context.assembly()
    private lazy var services: ServicesAssembly = context.assembly()
    
    func viewcontroller(user: User?, result: @escaping (Product) -> ()) -> CreateProductConrtoller {
        define(init: CreateProductConrtoller()) {
            $0.presenter = self.presenter(user: user, view: $0, viewController: $0, result: result)
            return $0
        }
    }
}

extension CreateProductAssembly {
    
    func presenter(user: User?, view: CreateProductView, viewController: UIViewController, result: @escaping (Product) -> ()) -> CreateProductPresenter {
        define(init: CreateProductPresenterImpl()){
            $0.result = result
            $0.view = view
            $0.user = user
            $0.bank = self.bank.bank
            $0.moneyService = self.services.MoneyService
            $0.router = self.router.router(viewController: viewController)
            return $0
        }
    }
}
