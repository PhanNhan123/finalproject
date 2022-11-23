
import Foundation
import UIKit
import Alamofire
import SDWebImage
import SwiftyJSON
import CoreData

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    var users:  [NSManagedObject] = []
    var infousers : [NSManagedObject] = []
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        self.title = "Switters"
        getURL() {(users) in
        }
        removeInfoUser()
        fetchData()
        //        userTableView.dataSource = self
        //        userTableView.delegate = self
        print("viewdidload")
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewwillappear")
        userTableView.dataSource = self
        userTableView.delegate = self
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Switters"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
        //        return data.count
        return  users.count
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = userTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        cell.loginLabel.text = user.value(forKey: "login") as! String
        cell.loginLabel.font = UIFont.boldSystemFont(ofSize: 18)
        cell.urlLabel.text  =  user.value(forKey: "html_url") as! String
        cell.urlLabel.textColor = .blue
        cell.urlLabel.isUserInteractionEnabled = true
        let tap = MyTapGesture(target: self, action: #selector(self.tapFunction(sender:)))
        cell.urlLabel.addGestureRecognizer(tap)
        tap.url =  user.value(forKey: "html_url") as! String
        
        let data = user.value(forKey: "avatar_url") as! Data
        cell.userImageView.image  = UIImage(data: data)
        cell.userImageView.layer.cornerRadius = 20
        cell.userImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        cell.userImageView.frame = CGRect(x: 5, y: 5, width: 342, height: 250)
        
        cell.titleView.frame = CGRect(x: 5, y: 255, width: 342, height: 100)
        cell.titleView.backgroundColor = .lightGray
        cell.titleView.layer.cornerRadius = 20
        cell.titleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return cell
    }
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return 380
        
    }
    
    // navigtion
    
    func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        var user = users[indexPath.row]
        vc?.login =  user.value(forKey: "login") as! String
        self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.red
        //        self.navigationController?.popViewController(animated: true)
        //        self.navigationController?.navigationBar.ti   tleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }
    
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
    
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedConText = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do{
            users  = try managedConText.fetch(fetchRequest)
            for data in users as! [NSManagedObject]{
                let string = data.value(forKey: "login") as! String
                getInfoUser(login: string)
            }
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
    
    func getURL(completion: @escaping ([UserModel]) -> Void) {
        let headers: HTTPHeaders = [
            "Authorization": "Basic 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"
        ]
        let url = "https://api.github.com/users"
        AF.request(url,headers: headers).responseJSON {response in
            switch (response.result) {
            case .success( _):
                do {
                    let users = try JSONDecoder().decode([UserModel].self, from: response.data!)
                    self.removeCoreData()
                    for item in users {
                        self.save(login:item.login,html_url: item.html_url,avatar_url: item.avatar_url)
                    }
                    completion(users)
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
            case .failure(let error):
                print("Request error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveInfoUser(name: String,bio: String,avatar_url: String,created_at: Date, followers: Int64, email: String, login: String){
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
            users.append(user)
        }catch let error as NSError{
            print("Could not save, \(error), \(error.userInfo)")
        }
    }
    
    func getInfoUser(login : String ) {
        let headers: HTTPHeaders = [
            "Authorization": "Basic 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"
        ]
        let url = "https://api.github.com/users/\(login)"
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
                //                print("saveinfo")
            }
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
    @IBAction func tapFunction(sender: MyTapGesture){
        if let url = URL(string: sender.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)}
    }
}
class MyTapGesture: UITapGestureRecognizer {
    var url = String()
}


