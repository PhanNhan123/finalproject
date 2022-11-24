
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
    
    var viewModelUser = UserViewModel()
    override func viewDidLoad() {
        self.title = "Switters"
        
        print("viewdidload")
        //        self.viewModelUser.getURL() {(users) in
        //        }
        //        self.viewModelUser.removeInfoUser()
        self.viewModelUser.fetchData(){(users) in
            self.users = users
        }
        userTableView.dataSource = self
        userTableView.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("viewwillappear")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewdidappear")
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
        cell.titleView.backgroundColor = UIColor(red: 255, green: 255, blue: 240, alpha: 1.0)
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
    
    @IBAction func tapFunction(sender: MyTapGesture){
        if let url = URL(string: sender.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)}
    }
}
class MyTapGesture: UITapGestureRecognizer {
    var url = String()
}


