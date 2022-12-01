/*
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
    func getInfoUser(login : String ) {
    
        let headers: HTTPHeaders = [
            "Authorization": "Basic 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"
        ]
        let url = "https://api.github.com/users/\(login)"
        DispatchQueue.global(qos: .background).async {
            print("get info detail user background threaad")
        AF.request(url,headers: headers).responseJSON {response in
            if let value = response.value {
                let swiftyJsonVar = JSON(value)
                let followers = swiftyJsonVar["followers"].int64Value
                let name = swiftyJsonVar["name"].stringValue
                let created_at = swiftyJsonVar["created_at"].stringValue
                let avatar_url  =  swiftyJsonVar["avatar_url"].stringValue
                let bio = swiftyJsonVar["bio"].stringValue
                let email = swiftyJsonVar["email"].stringValue
                let login = swiftyJsonVar["login"].stringValue
                let  dateFormatter = DateFormatter()
                let tempLocale = dateFormatter.locale
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                let date = dateFormatter.date(from: created_at)!
                self.saveInfoUser(name: name , bio: bio, avatar_url: avatar_url, created_at: date, followers: followers, email: email, login: login)
            }
        }
            DispatchQueue.main.async {
                print("get info detail user main  threaad")
                
            }
        }
    }
    
    func saveInfoUser(name: String,bio: String,avatar_url: String,created_at: Date, followers: Int64, email: String, login: String){
        print("save infor detail users")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "InfoUser", in: managedContext)!
        let user = NSManagedObject(entity: entity, insertInto: managedContext)
        user.setValue(name, forKeyPath: "name")
        user.setValue(bio, forKeyPath: "bio")
        user.setValue(followers, forKey: "followers")
        user.setValue(email, forKey: "email")
        user.setValue(created_at, forKey: "created_at")
        user.setValue(login, forKey: "login")
        let urlImage = URL(string: avatar_url)!
        if let data  = try? Data(contentsOf: urlImage){
            user.setValue(data, forKeyPath: "avatar_url")
        }
        do{
            try managedContext.save()
            infousers.append(user)
        }catch let error as NSError{
            print("Could not save, \(error), \(error.userInfo)")
        }
    }
    
}


 */




import RxSwift

final class DetailViewModel: BaseViewModel {
    let outUsers = PublishSubject<[InfoUserModel]>()
    let user : InfoUserModel!
    
    // MARK: - Inputs
    let inReload = PublishSubject<Void>()
    
    // MARK: - Outputs
    let outUser = PublishSubject<InfoUserModel>()
    
    init(user : InfoUserModel?) {
        self.user = user
        super.init()
        
        /// subscribe inputs here
        inReload.subscribe(onNext: { () in
            self.loadUser()
        }).disposed(by: disposeBag)
    }
    
    private func loadUser() {
        /// show loading
        loading(true)
        /// call request API
        UserRepository.shared.getUser(username: user.login)
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext : { [weak self] user in
//                    self?.outUser.onNext(user)
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



