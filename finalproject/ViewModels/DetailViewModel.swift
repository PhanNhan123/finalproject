import Alamofire
import UIKit
import SwiftyJSON
import CoreData
import Foundation

class DetailViewModel {
    var infousers : [NSManagedObject] = []
    
    func fetchInfoUser(completion: @escaping ([NSManagedObject]) -> Void ) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedConText = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InfoUser")
        do{
            infousers  = try managedConText.fetch(fetchRequest)
            completion(infousers)
            for data in infousers as! [NSManagedObject]{
                //                print(data.value(forKey: "name") as! String)
            }
        }catch let error as NSError{
            print("Could not fetch , \(error),\(error.userInfo)")
            print (0)
        }
    }
}
