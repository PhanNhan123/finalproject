
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData
class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var infousers : [NSManagedObject] = []
    @IBOutlet weak var detailTableView: UITableView!
//    var image = UIImage()
    var login = ""
//    var content = ""
//    var follower = ""
//    var createAt = ""
//    var userDetail = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInfoUser()
        detailTableView.dataSource = self
        detailTableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
        return 1
    }
    //    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    //        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
    //        getURL() { (name,followers,avatar,dateString,avatar_url,content) in
    //            cell.nameLabel.text = name
    //            cell.gitImage.image = UIImage(named: "github.png")
    //            cell.nameLabel.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //            cell.avtImage.sd_setImage(with: URL(string: avatar_url), placeholderImage: UIImage(named: "placeholder.png"))
    ////            cell.avtImage.frame = CGRect(x:10, y:10, width: 200, height:200)
    ////            cell.avtImage.layoutMargins =  UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    //
    //            cell.flLabel.text = "\(followers) Followers"
    //            cell.dateLabel.text = "Since \(dateString)"
    //            cell.contentLabel.text = content
    //
    //        }
    //        return cell
    //    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        let user  = infousers.filter{item in return item.value(forKey:"login") as! String == login}
        //        let infouser = infousers[indexPath.row]
        let infouser = user[indexPath.row]
        cell.nameLabel.text = infouser.value(forKey: "name") as! String
        cell.nameLabel.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        cell.contentLabel.text = infouser.value(forKey: "bio") as! String
        // change format date
        let date = infouser.value(forKey: "created_at") as! Date
        let  dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        //
//        cell.dateLabel.text = "Since \(infouser.value(forKey: "created_at") as! Date)"
        cell.dateLabel.text = "Since \(dateString)"
        let data = infouser.value(forKey: "avatar_url") as! Data
        cell.avtImage.image = UIImage(data: data)
        cell.flLabel.text = "\(String(infouser.value(forKey: "followers") as! Int64)) Followers"
        cell.emailLabel.text = infouser.value(forKey: "email") as! String
        cell.gitImage.image = UIImage(named: "github.png")
        cell.emailImage.image = UIImage(named: "email.png")
        return cell
    }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return 1000}
    
    func fetchInfoUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return }
        let managedConText = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "InfoUser")
        do{
            infousers  = try managedConText.fetch(fetchRequest)
            for data in infousers as! [NSManagedObject]{
                //                print(data.value(forKey: "name") as! String)
            }
        }catch let error as NSError{
            print("Could not fetch , \(error),\(error.userInfo)")
            print (0)
        }
    }
    
}

