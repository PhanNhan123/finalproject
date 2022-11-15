//
//  ViewController.swift
//  finalproject
//
//  Created by Phan Nhân on 11/14/22.
//  Copyright © 2022 Phan Nhân. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

  
    @IBOutlet weak var userTableView: UITableView!
    struct User {
          let login: String
          let avatar_url: String
          let url: String
      }
    let data:[User] = [
        User(login: "dalat",avatar_url: "dalat",url:"dalat"),
          User(login: "dalat",avatar_url: "dalat",url:"dalat"),
          User(login: "dalat",avatar_url: "dalat",url:"dalat"),
            User(login: "dalat",avatar_url: "dalat",url:"dalat")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()


         userTableView.dataSource = self
        userTableView.delegate = self
    
//        self.userTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

    }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->  Int{
           return data.count
       }
       func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
           let cell = userTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
           let user = data[indexPath.row]
            cell.loginLabel.text = user.login
            cell.urlLabel.text = user.url
            cell.userImageView.image = UIImage(named: user.avatar_url)
           return cell
       }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return 140}
    func tableView(_ tableView:UITableView,didSelectRowAt indexPath: IndexPath){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc?.image = UIImage(named: data[indexPath.row].avatar_url)!
        vc?.login = data[indexPath.row].login
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}

   
