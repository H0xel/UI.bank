//
//  LastAddedClientAssembly.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import EasyDi

class LastAddedClientAssembly: Assembly {
    
    private lazy var storageAssembly: StoragesAssembly = context.assembly()
    
    var viewcontroller: LastAddedClientController {
        define(init: (ViewControllersFactory().viewController(identifier: "LastAddedClientController") as LastAddedClientController)) {
            $0.storageAssembly = self.storageAssembly
            return $0
        }
    }
}
