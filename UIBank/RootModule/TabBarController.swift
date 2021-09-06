//
//  TabBarController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    init(registerAsembly: RegisterClientAseembly,
         lastAddedClientAseembly: LastAddedClientAssembly,
         showClientAssembly: ShowClientsAssembly,
         transactionAssembly: TransactionAssembly) {
        
        super.init(nibName: nil, bundle: nil)
        
        let registerTab = registerAsembly.viewcontroller
        let lastClientTab = lastAddedClientAseembly.viewcontroller
        let showClientTab = showClientAssembly.tableViewController
        let transactionTab = transactionAssembly.viewcontroller
        
        registerTab.title = "Register"
        lastClientTab.title = "Last added client"
        showClientTab.title = "Show clients"
        transactionTab.title = "Transaction"
        
        self.setViewControllers([registerTab, lastClientTab, showClientTab, transactionTab], animated: false)
        
        guard let items = self.tabBar.items else { return }
        let images = ["house", "star", "bell", "star"]
        
        for x in 0..<images.count {
            items[x].image = UIImage(systemName: images[x])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

