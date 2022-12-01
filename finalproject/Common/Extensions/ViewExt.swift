import Foundation
import UIKit

protocol Reusable {
    static var reuseID: String {get}
}

extension Reusable {
    static var reuseID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UIViewController {
    
    func alert(error: Error) {
        alert(title: "ERROR", msg: error.localizedDescription, buttons: ["OK"], handler: nil)
    }
    
    func alert(title: String? = nil, msg: String, buttons: [String], handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        for button in buttons {
            let action = UIAlertAction(title: button, style: .cancel, handler: { action in
                handler?(action)
            })
            alert.addAction(action)
        }
        present(alert, animated: true, completion: nil)
    }
    
    func alert(msg: String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func alert(msg: String, title:String) {
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: title, style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
