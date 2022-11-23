
import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import CoreData
class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var infousers : [NSManagedObject] = []
    @IBOutlet weak var detailTableView: UITableView!
    var login = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchInfoUser()
        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
        return 1
    }
    
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        let user  = infousers.filter{item in return item.value(forKey:"login") as! String == login}
        let infouser = user[indexPath.row]
        cell.nameLabel.text = infouser.value(forKey: "name") as! String
        cell.nameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        cell.contentLabel.text = infouser.value(forKey: "bio") as! String
        //        cell.contentLabel.text = "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available."
        //        cell.contentLabel.numberOfLines = 0
        //        cell.contentLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        //        cell.contentLabel.sizeToFit()
        
        
        cell.avtImage.frame = CGRect(x:0 , y: 70 , width: UIScreen.main.bounds.width , height: 300)
        cell.infoContentView.frame = CGRect(x: 0 ,y: 370 , width:  UIScreen.main.bounds.width, height: 100 )
        cell.infoContentView.backgroundColor = .lightGray
        // change format date
        let date = infouser.value(forKey: "created_at") as! Date
        let  dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MMM d, yyyy"
        dateFormatter.locale = tempLocale
        let dateString = dateFormatter.string(from: date)
        cell.dateLabel.text = "Since \(dateString)"
        let data = infouser.value(forKey: "avatar_url") as! Data
        cell.avtImage.image = UIImage(data: data)
        cell.flLabel.text = "\(String(infouser.value(forKey: "followers") as! Int64)) Followers"
        cell.emailLabel.text = infouser.value(forKey: "email") as! String
        //        cell.emailLabel.text = "email@gmail.com"
        cell.gitImage.image = UIImage(named: "github.png")
        cell.emailImage.image = UIImage(named: "email.png")
        
        cell.contentLabel.frame = CGRect(x:20 , y: 470 , width: UIScreen.main.bounds.width , height: 200)
        cell.emailImage.frame = CGRect(x:100 , y: 670 , width: 30 , height: 30)
        cell.emailLabel.frame = CGRect(x:140 , y: 670 , width: 250 , height: 30)
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

