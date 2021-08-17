//
//  UserRouterAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 11.08.2021.
//

import EasyDi

class UserRouterAssembly: Assembly {
    
    func router(viewController: UIViewController) -> UserRouter {
        define(init: UserRouterImpl()) {
            $0.viewController = viewController
            return $0
        }
    }
}
