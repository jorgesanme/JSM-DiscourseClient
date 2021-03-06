//
//  TopicDetailViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 19/01/2021.
//

import UIKit

class TopicDetailViewController: UIViewController{
    var detailTopic: TopicElement?
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var numberOfPost: UILabel!
    @IBOutlet weak var canDelete: UITextField!
    @IBOutlet weak var topicID: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let muestraID = String ((detailTopic?.id)!)
        title = String("TopicId: \(muestraID)")
        topicLabel.text = detailTopic?.title
        topicID.text =  String((detailTopic?.id)!)
        canDelete.text = String((detailTopic?.canDelete) != nil)
        numberOfPost.text =  String((detailTopic?.postNumber)!)
            
    }
   
}
