/*
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var users:  [NSManagedObject] = []
    var infousers : [NSManagedObject] = []
    @IBOutlet weak var userTableView: UITableView!
    var screen = UIScreen.main.bounds
    var viewModelUser = UserViewModel()
    override func viewDidLoad() {
        self.title = "Switters"
//        setImage()
//        self.viewModelUser.getURL() {(users) in
//        }
        self.viewModelUser.fetchData(){(users) in
            self.users = users
        }
//        let screen = UIScreen.main.bounds
//        let screenWidth = screen.size.width
//        let screenHeight = screen.size.height
//        print("screenWidth: \(screenWidth),screenHeight: \(screenHeight)")
        
        userTableView.dataSource = self
        userTableView.delegate = self
        

        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section:Int) -> String?
    {
        return "Switters"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
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
        //        tap.numberOfTapsRequired = 2
        cell.urlLabel.addGestureRecognizer(tap)
        tap.url =  user.value(forKey: "html_url") as! String
        
        let data = user.value(forKey: "avatar_url") as! Data
        cell.userImageView.image  = UIImage(data: data)
        cell.userImageView.layer.cornerRadius = 20
        cell.userImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        let screen = UIScreen.main.bounds
        let screenWidth = screen.size.width
        let screenHeight = screen.size.height
        cell.userImageView.frame = CGRect(x: 0, y: 0, width: screenWidth*0.9, height: screenHeight*0.3)
        cell.userImageView.translatesAutoresizingMaskIntoConstraints = false

        
        cell.titleView.frame = CGRect(x: 0, y: screenHeight*0.3, width: screenWidth*0.9, height: screenHeight*0.2)
        cell.titleView.translatesAutoresizingMaskIntoConstraints = false
        cell.titleView.backgroundColor = UIColor(red: 255, green: 255, blue: 240, alpha: 1.0)
        cell.titleView.layer.cornerRadius = 20
        cell.titleView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return cell
    }

    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return screen.size.height*0.53
        
    }
    
    // navigtion
    
    func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        var user = users[indexPath.row]
        vc?.login =  user.value(forKey: "login") as! String
        self.navigationController?.pushViewController(vc!, animated: true)
        self.navigationController?.navigationBar.tintColor = UIColor.red
//        self.viewModelUser.getInfoUser(login: user.value(forKey: "login") as! String )
        //        self.navigationController?.popViewController(animated: true)
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
    }
    
    @IBAction func tapFunction(sender: MyTapGesture){
        if let url = URL(string: sender.url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)}
    }
}
class MyTapGesture: UITapGestureRecognizer {
    var url = String()
}



//let defaults = UserDefaults.standard
//defaults.set(25, forKey: "Age")
//defaults.set(true, forKey: "UseTouchID")
//defaults.set(CGFloat.pi, forKey: "Pi")
//defaults.set("Paul Hudson", forKey: "Name")
//let dict = ["Name": "Paul", "Country": "UK"]
//defaults.set(dict, forKey: "SavedDict")
//let array = ["Hello", "World"]
//defaults.set(array, forKey: "SavedArray")
//let age = defaults.integer(forKey: "Age")
//let UseTouchID = defaults.bool(forKey: "UseTouchID")
//let  dicts = defaults.dictionary(forKey: "SavedDict")
//print("age \(age)")
//print("UseTouchID \(UseTouchID)")
//print("SavedDict \(dicts!)")
//print("array  \(defaults.array(forKey: "SavedArray")

//
//extension ViewController: ImageDownLoadProtocol{
//    func setImage(){
//        let url = URL(string: "https://avatars.githubusercontent.com/u/1?v=4")!
//        downloadImage(from: url) { image in
//                   if Thread.isMainThread {
//                       print("Thread is main")
//                   }
//                    print("imageViewOne: \(image)")
////                   self.imageViewOne.image = image
//                   print("Done")
//               }
//    }
//}


*/




import UIKit
import RxSwift

class UsersViewController: BaseViewController<UserViewModel> {
    
    @IBOutlet weak var userTableView: UITableView!
    
    override func setupUI() {
        super.setupUI()
        userTableView.refreshControl = UIRefreshControl()
        print("userviewcontroller")
    }
    
    override func setupViewModel() {
        super.setupViewModel()
        viewModel = UserViewModel()
        
        viewModel.base.loading
            .bind(to: (userTableView.refreshControl?.rx.isRefreshing)!)
            .disposed(by: disposeBag)
        
        viewModel.outUsers
            .bind(to: userTableView.rx.items(cellIdentifier: UserTableViewCell.reuseID , cellType: UserTableViewCell.self)) { index, user, cell in
                cell.bind(user: user)
        }.disposed(by: disposeBag)
        
        userTableView.refreshControl?.rx
            .controlEvent(.valueChanged)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] () in
                self?.viewModel?.inReload.onNext(())
            }).disposed(by: disposeBag)
        
        userTableView.rx.modelSelected(User.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { user in
//                let vc = DetailViewController.create(user: user)
//                self.navigator.push(target: vc, sender: self)
            }).disposed(by: disposeBag)
    }
    
    override func setupData() {
        viewModel?.inReload.onNext(())
    }
}



