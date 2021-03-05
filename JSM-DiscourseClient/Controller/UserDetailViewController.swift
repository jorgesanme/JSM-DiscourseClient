//
//  UserDetailViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 05/03/2021.
//

import UIKit

class UserDetailViewController: UIViewController{
    var detailUser: DirectoryItem?
    
    @IBOutlet weak var userID: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userNickName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User Details"
        
        userID.text = String (detailUser?.user.id ?? 0)
        name.text = detailUser?.user.name        
        userNickName.text = detailUser?.user.username
    }
}
