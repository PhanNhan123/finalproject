
import Foundation
import UIKit
import Alamofire
import SDWebImage
import MBProgressHUD
import SwiftyJSON

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var userTableView: UITableView!
    struct User {
        let login: String
        let avatar_url: String
        let url: String
    }
    let data:[User] = [
        User(login: "mojombo",avatar_url: "dalat",url:"https://github.com/wayneeseguin"),
        User(login: "mojombo",avatar_url: "dalat",url:"https://github.com/wayneeseguin"),
        User(login: "mojombo",avatar_url: "dalat",url:"https://github.com/wayneeseguin"),
        User(login: "mojombo",avatar_url: "dalat",url:"https://github.com/wayneeseguin"),
        
    ]
    let  userData = [[String:Any]]()
    
    override func viewDidLoad() {
        loadJsonData()
        userTableView.dataSource = self
        userTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
        return data.count
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = userTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let user = data[indexPath.row]
        getURL() { () in
            //            print("url: \(url)")
        }
        
        cell.loginLabel.text = user.login
        cell.urlLabel.text  = user.url
        cell.urlLabel.isUserInteractionEnabled = true
        let tap = MyTapGesture(target: self, action: #selector(self.tapFunction(sender:)))
        cell.urlLabel.addGestureRecognizer(tap)
        tap.url = user.url
        
        cell.userImageView.sd_setImage(with: URL(string: "https://avatars.githubusercontent.com/u/18?v=4"), placeholderImage: UIImage(named: "placeholder.png"))
        
        //        cell.userImageView.image = UIImage(named: user.avatar_url)
        
        //
        
        // download image
        
        //        let destination: DownloadRequest.Destination = { _, _ in
        //            let documentsURL = FileManager.default.urls(for: .picturesDirectory, in: .userDomainMask)[0]
        //            let fileURL = documentsURL.appendingPathComponent("image.png")
        //
        //            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        //        }
        //
        //        AF.download("https://avatars.githubusercontent.com/u/18?v=4", to: destination)
        //            .downloadProgress { progress in
        //                print("Download Progress: \(progress.fractionCompleted)")
        //            }
        //            .response { response in
        //                debugPrint(response)
        //
        //                if response.error == nil, let imagePath = response.fileURL?.path {
        //                    let image = UIImage(contentsOfFile: imagePath)
        //                }
        //            }
        
        return cell
    }
    
    // tap function
    
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return 300}
    
    // navigtion
    
    func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc?.image = UIImage(named: data[indexPath.row].avatar_url)!
        vc?.login = data[indexPath.row].login
        vc?.content = data[indexPath.row].url
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func getURL(completion: @escaping ([String:Any]) -> Void) {
        let url = "https://api.github.com/users"
        AF.request(url).responseJSON {response in
            if let value = response.value {
                let swiftyJsonVar = JSON(value)
//                print("swiftyJsonVar: \(swiftyJsonVar)")
                let data = swiftyJsonVar.arrayObject
                print("data:\(data)")
                completion()
            }
        }
    }
    
    @IBAction func tapFunction(sender: MyTapGesture){
        if let url = URL(string: sender.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)}
    }
    
    
    // loaddata
    func loadJsonData(){
        AF.request("https://api.github.com/users").responseJSON{(response) in
            if let json = response.value as! [[String:Any]]?  {
                
                if let responseValue = json as! [[String:Any]]? {
                    //                    print("jsonresponseValue:  \(responseValue)")
                    //                    self.tableView.reloadData()
                    //                    print("jsonresponseValue:  \(responseValue[9]["url"]!)")
                    //                    print("userData: \(self.userData)")
                }
            }
        }
    }
    
    // local data from file json
    struct ResponseData: Decodable {
        var person: [Person]
    }
    struct Person : Decodable {
        var name: String
        var age: String
        var employed: String
    }
    
    
    
}
class MyTapGesture: UITapGestureRecognizer {
    var url = String()
}


