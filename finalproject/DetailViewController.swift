
import UIKit
import Alamofire

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var detailTableView: UITableView!
    var image = UIImage()
    var login = ""
    var content = ""
    var follower = ""
    var createAt = ""
    var userDetail = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonData()
        detailTableView.dataSource = self
        detailTableView.delegate = self
  
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
        return 1
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! DetailTableViewCell
        let defaults = UserDefaults.standard
        let data = defaults.object(forKey:"brynary")
        print("data: \(data!)")
        
       
        cell.nameLabel.text = login
        cell.avtImage.image = image
        cell.contentLabel.text = content
        let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapFunction))
        cell.contentLabel.isUserInteractionEnabled = true
        cell.contentLabel.addGestureRecognizer(tap)
        //        cell.flLabel.text = loadData["followers"]

        
        return cell
    }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return 1000}
    
    func loadJsonData(){
        AF.request("https://api.github.com/users/brynary").responseJSON{(response) in
            if let json = response.value as! [String:Any]?  {
                if let responseValue = json as! [String:Any]? {
                    print("selfuserDetail: \(responseValue["login"]!)")
                    // NSUserdefault
                    let defaults = UserDefaults.standard
                    defaults.set("\(responseValue)", forKey:"\(responseValue["login"]!)")
                }
            }
        }
    }
    
    // func tap
    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
            print("tap working")
        }
    
    
}
