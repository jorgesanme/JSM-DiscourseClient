//
//  topicsCell.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 19/01/2021.
//

import UIKit

class topicsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        // prepareForSeguel
        
    }
    @IBSegueAction func SEGUE_FROM_TOPIC_TO_DETAIL(_ coder: NSCoder) -> UIViewController? {
        return UIViewController(coder: coder)
    }
    
}

