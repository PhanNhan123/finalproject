import Foundation
import UIKit
import SafariServices

/// Handle action of navigation in [UIViewController]
class Navigator {
    
    /// dismiss sender viewcontroller
    func dismiss(sender: UIViewController?) {
        sender?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    /// sender sender viewcontroller
    /// toRoot : pop to root or not
    func pop(sender: UIViewController?, toRoot: Bool = false) {
        if toRoot {
            sender?.navigationController?.popToRootViewController(animated: true)
        } else {
            sender?.navigationController?.popViewController()
        }
    }
    
    /// push a target [UIViewController] from sender
    func push(target: UIViewController, sender: UIViewController) {
        if let nav = sender.navigationController {
            // push controller to navigation stack
            nav.pushViewController(target, animated: true)
        }
    }
    
    /// present a target [UIViewController] from sender
    func modal(target: UIViewController, sender: UIViewController) {
        let nav = UINavigationController(rootViewController: target)
        sender.present(nav, animated: true, completion: nil)
    }
    
    /// show detail a target [UIViewController] from sender
    func detail(target: UIViewController, sender: UIViewController) {
        let nav = UINavigationController(rootViewController: target)
        sender.showDetailViewController(nav, sender: nil)
    }
    
    /// open safari browser by URL string
    func safari(url : String) {
        UIApplication.shared.open(url.url!, options: [:], completionHandler: nil)
    }
}

