
import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    struct User{
        var login : String
        var id : Int
        var node_id : String
        var avatar_url : String
        var gravatar_id : String
        var url : String
        var html_url : String
        var  followers_url : String
        var following_url : String
        var  gists_url : String
        var starred_url: String
        var subscriptions_url: String
        var organizations_url: String
        var repos_url: String
        var events_url: String
        var received_events_url : String
        var type : String
        var site_admin : Bool
        var name : String
        var company : String
        var  blog: String
        var  location : String
        var email: String
        var hireable: String
        var bio : String
        var twitter_username: String
        var public_repos: Int
        var  public_gists: Int
        var followers: Int
        var  following: Int
        var created_at : Date
        var updated_at : Date
    }
    @IBOutlet weak var detailTableView: UITableView!
    var image = UIImage()
    var login = ""
    var content = ""
    var follower = ""
    var createAt = ""
    var userDetail = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        detailTableView.dataSource = self
        detailTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
        return 1
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
//        let defaults = UserDefaults.standard
//        let data = defaults.object(forKey:"brynary")
//
//        print(data)
        getURL() { (followers,avatar) in
            cell.flLabel.text = "\(followers) Followers"
            
        }
        
        cell.nameLabel.text = login
        cell.avtImage.image = image
        cell.contentLabel.text = content
        //        cell.flLabel.text = loadData["followers"]
        
        
        return cell
    }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return 1000}
    
//    func loadJsonData(){
//        AF.request("https://api.github.com/users/\(login)").responseJSON{(response) in
//            if let json = response.value as! [String:Any]?  {
//                if let responseValue = json as! [String:Any]? {
////                    print("selfuserDetail: \(responseValue["login"]!)")
//
////                     NSUserdefault
//                    let defaults = UserDefaults.standard
//                    defaults.set("\(responseValue)", forKey:"\(responseValue["login"]!)")
//                }
//            }
//        }
//    }
    func getURL(completion: @escaping (String,String) -> Void) {
        let url = "https://api.github.com/users/\(login)"
        AF.request(url).responseJSON {response in
            if let value = response.value {
                let swiftyJsonVar = JSON(value)
                print("swiftyJsonVar: \(swiftyJsonVar)")
                let followers = swiftyJsonVar["followers"].stringValue
                let avatar = swiftyJsonVar["avatar_url"].stringValue
                let created_at = swiftyJsonVar["created_at"].stringValue
//                let dateFormatter = NSDate
//                print("date: \(date)")
                completion(followers,avatar)
            }
        }
    }
    
    // func tap
//    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
//        if let url = URL(string: "https://github.com/\(login)") {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)}
//    }
    
    
    
//    func getQuests(category: NSString, count: Int) -> NSArray {
//        var quests = NSArray()
//
//        AF.request("https://api.github.com/users/\(login)")
//            .responseJSON {(json) in
//                dispatch_async(dispatch_get_main_queue(), {
//                    quests = json as NSArray
//                })
//        }
//        return quests
//    }
    
    
    
}
