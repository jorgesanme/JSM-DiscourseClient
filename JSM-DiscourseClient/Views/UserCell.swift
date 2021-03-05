//
//  UserCell.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 01/03/2021.
//

import UIKit

class UserCell: UITableViewCell {

   
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage?.image =  nil
        nameLabel?.text = nil
    }
    
//    func configure(userList: UserModel, indexPath: IndexPath){
//        userImage?.image =  UIImage(named: userList.directoryItems[indexPath.row].user.avatarTemplate)
//        nameLabel?.text =  userList.directoryItems[indexPath.row].user.name
//    }
    
}
