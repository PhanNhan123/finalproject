

import UIKit
import Alamofire

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userTableView: UITableView!
    struct User {
        let login: String
        let avatar_url: String
        let url: String
    }
    let data:[User] = [
        User(login: "mojombo",avatar_url: "dalat",url:"https://api.github.com/users/mojomb"),
        User(login: "mojombo",avatar_url: "dalat",url:"https://api.github.com/users/mojomb"),
        User(login: "mojombo",avatar_url: "dalat",url:"https://api.github.com/users/mojomb"),
        User(login: "mojombo",avatar_url: "dalat",url:"https://api.github.com/users/mojomb"),
        
    ]
    var  userData = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonData()
        //        print("userData:  \(userData)")
        userTableView.dataSource = self
        userTableView.delegate = self
  
//        if let url = URL(string: "https://github.com/brynary") {
//            UIApplication.shared.open(url)
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
        return data.count
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = userTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let user = data[indexPath.row]

        cell.loginLabel.text = user.login
        cell.urlLabel.text  = user.url
        
        cell.userImageView.image = UIImage(named: user.avatar_url)
        return cell
    }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return 140}
    
    
    // navigtion
    
    func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc?.image = UIImage(named: data[indexPath.row].avatar_url)!
        vc?.login = data[indexPath.row].login
        vc?.content = data[indexPath.row].url
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // loaddata
    func loadJsonData(){
        AF.request("https://api.github.com/users").responseJSON{(response) in
            //            print("Response result value \(response.value)")
            if let json = response.value as! [[String:Any]]?  {
                
                if let responseValue = json as! [[String:Any]]? {
                    //                    print("jsonresponseValue:  \(responseValue)")
                    self.userData = responseValue
                    //                    self.tableView.reloadData()
//                    print("jsonresponseValue:  \(responseValue[9]["url"]!)")
                }
            }
        }
    }
}


