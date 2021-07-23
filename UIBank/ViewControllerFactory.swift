import UIKit

class ViewControllersFactory {
    private static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func viewController<T: UIViewController>(identifier: String) -> T {
        ViewControllersFactory.storyboard.instantiateViewController(identifier: identifier) as! T
    }
    
    func tabBarController<T: UITabBarController>(identifier: String) -> T {
        ViewControllersFactory.storyboard.instantiateViewController(identifier: identifier) as! T
    }
    
    func tableViewController<T: UITableViewController>(identifier: String) -> T {
        ViewControllersFactory.storyboard.instantiateViewController(identifier: identifier) as! T
    }
}
