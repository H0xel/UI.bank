//
//  TabBarController.swift
//  UIBank
//
//  Created by Ivan Amakhin on 20.07.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    var registeClientAssembly: RegisterClientAseembly!
    var lastAddedClientAssembly: LastAddedClientAssembly!
    var showClientAssembly: ShowClientsAssembly!
    var transactionAssembly: TransactionAssembly!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let registerTab = registeClientAssembly.viewcontroller
        let lastClientTab = lastAddedClientAssembly.viewcontroller
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
    

}
