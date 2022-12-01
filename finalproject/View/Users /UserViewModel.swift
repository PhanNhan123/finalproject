/*
import Alamofire
import UIKit
import SwiftyJSON
import CoreData
import Foundation
class UserViewModel{
    var users:  [NSManagedObject] = []
    var infousers : [NSManagedObject] = []
    func getURL(completion: @escaping ([UserModel]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Basic 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"
        ]
        let url = "https://api.github.com/users"
        DispatchQueue.global(qos: .background).async {
        AF.request(url,headers: headers).responseJSON {response in
            switch (response.result) {
            case .success( _):
                do {
                    let users = try JSONDecoder().decode([UserModel].self, from: response.data!)
                    self.removeCoreData()
                    for item in users {
                        self.save(login:item.login,html_url: item.html_url,avatar_url: item.avatar_url)
                    }
                    DispatchQueue.main.async {
                        print("dispatched to main")
                        completion(users)
                    }
//                    completion(users)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
            }
        }
        }
    }
    
    
    func fetchData(completion: @escaping ([NSManagedObject]) -> Void ){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedConText = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do{
            users  = try managedConText.fetch(fetchRequest)
//            removeInfoUser()
            completion(users)
//            for data in users as! [NSManagedObject]{
//                let string = data.value(forKey: "login") as! String
//                getInfoUser(login: string)
//            }
        }catch let error as NSError{
            print("Could not fetch , \(error),\(error.userInfo)")
            print (0)
        }
    }
    
    func removeCoreData() {
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
//    func getInfoUser(login : String ) {
//        let headers: HTTPHeaders = [
//            "Authorization": "Basic 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"
//        ]
//        let url = "https://api.github.com/users/\(login)"
//        DispatchQueue.global(qos: .background).async {
//        AF.request(url,headers: headers).responseJSON {response in
//            if let value = response.value {
//                let swiftyJsonVar = JSON(value)
//                let followers = swiftyJsonVar["followers"].int64Value
//                let name = swiftyJsonVar["name"].stringValue
//                let created_at = swiftyJsonVar["created_at"].stringValue
//                let avatar_url  =  swiftyJsonVar["avatar_url"].stringValue
//                let bio = swiftyJsonVar["bio"].stringValue
//                let email = swiftyJsonVar["email"].stringValue
//                let login = swiftyJsonVar["login"].stringValue
//                let  dateFormatter = DateFormatter()
//                let tempLocale = dateFormatter.locale
//                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//                let date = dateFormatter.date(from: created_at)!
//                
//                self.saveInfoUser(name: name , bio: bio, avatar_url: avatar_url, created_at: date, followers: followers, email: email, login: login)
//            }
//        }
//            DispatchQueue.main.async {
//            print("dispatched to main")
//                
//            }
//        }
//    }
    
//    func saveInfoUser(name: String,bio: String,avatar_url: String,created_at: Date, followers: Int64, email: String, login: String){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "InfoUser", in: managedContext)!
//        let user = NSManagedObject(entity: entity, insertInto: managedContext)
//        user.setValue(name, forKeyPath: "name")
//        user.setValue(bio, forKeyPath: "bio")
//        user.setValue(followers, forKey: "followers")
//        user.setValue(email, forKey: "email")
//        user.setValue(created_at, forKey: "created_at")
//        user.setValue(login, forKey: "login")
//        let urlImage = URL(string: avatar_url)!
//        if let data  = try? Data(contentsOf: urlImage){
//            user.setValue(data, forKeyPath: "avatar_url")
//        }
//        do{
//            try managedContext.save()
//            users.append(user)
//        }catch let error as NSError{
//            print("Could not save, \(error), \(error.userInfo)")
//        }
//    }
    
    func save(login: String,html_url:String,avatar_url:String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(login, forKeyPath: "login")
        user.setValue(html_url, forKeyPath: "html_url")
        let urlImage = URL(string: avatar_url)!
        if let data  = try? Data(contentsOf: urlImage){
            user.setValue(data, forKeyPath: "avatar_url")
        }
        do{
            try managedContext.save()
            users.append(user)
        }catch let error as NSError{
            print("Could not save, \(error), \(error.userInfo)")
        }
    }
    
    func removeInfoUser(){
        guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "InfoUser")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
            print(error.localizedDescription)
        }
    }
    
    func fetchInfoUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedConText = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InfoUser")
        do{
            infousers  = try managedConText.fetch(fetchRequest)
            for data in infousers as! [NSManagedObject]{
                print(data.value(forKey: "created_at") as! Date)
            }
        }catch let error as NSError{
            print("Could not fetch , \(error),\(error.userInfo)")
            print (0)
        }
    }
    
}

*/




import UIKit
import RxSwift
class UserViewModel: BaseViewModel {
    // MARK: - Inputs
    let inReload = PublishSubject<Void>()
    
    // MARK: - Outputs
    let outUsers = PublishSubject<[UserModel]>()
    
    override init() {
        super.init()
        /// subscribe inputs here
        inReload.subscribe(onNext: { () in
            self.loadUsers()
        }).disposed(by: disposeBag)
    }
    
    private func loadUsers() {
        /// show loading
        loading(true)
        /// call request API
        UserRepository.shared.getUsers(since: "")
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext : { [weak self] users in
                    self?.outUsers.onNext(users)
                },
                onError: { [weak self] error in
                    self?.loading(false)
                    self?.alert(error.localizedDescription)
                },
                onCompleted: { [weak self] () in
                    self?.loading(false)
                }
        ).disposed(by: disposeBag)
        
    }
}




