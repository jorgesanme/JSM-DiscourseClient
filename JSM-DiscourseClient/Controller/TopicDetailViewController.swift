//
//  TopicDetailViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 19/01/2021.
//

import UIKit

class TopicDetailViewController: UIViewController{
    
    @IBOutlet weak var topicLabel: UILabel!
    var detailTopic: Topic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = detailTopic?.topicList?.topics?.description
        topicLabel.text = detailTopic?.topicList?.topics?.description
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        //cerrando ventana modal
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }   
}
