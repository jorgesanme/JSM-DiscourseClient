//
//  AddTopicViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 20/01/2021.
//

import UIKit

class AddTopicViewController: UIViewController{
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func addTopicButtonTapped(_ sender: Any) {
        //TODO aqui se debe llamar a la funcion que sube el topic y luego se refresca la lista y se cierra la  ventana modal        
        
        //cerrando ventana modal
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
