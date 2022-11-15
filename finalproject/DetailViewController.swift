//
//  DetailViewController.swift
//  finalproject
//
//  Created by Phan Nhân on 11/15/22.
//  Copyright © 2022 Phan Nhân. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {


    @IBOutlet weak var detailTableView: UITableView!
    var image = UIImage()
    var login = ""
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
            cell.loginLabel.text = login
            cell.avatarImage.image = image
           return cell
       }
    func tableView(_ tableView:UITableView, heightForRowAt indexPath: IndexPath) ->CGFloat{return 140}
    

}
