//
//  AddTopicViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 20/01/2021.
//

import UIKit

class AddTopicViewController: UIViewController{
    
    var topicUpdateDelegate: AddTopicDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var contentTopic: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        topicUpdateDelegate?.updateTopic()
        
    }
    
    
    private func addTopic(completion: @escaping(Result<Topic, Error>) -> Void){
        guard let url: URL = URL(string: Constants.urlPosts) else {return}
        guard let title =  textField.text else {return}
        guard let content =  contentTopic.text else {return}
        let configuration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: configuration)
        var addTopicRequest: URLRequest = .init(url: url)
        addTopicRequest.httpMethod =  "POST"
        addTopicRequest.setValue(Constants.apiKey, forHTTPHeaderField: "Api-Key")
        addTopicRequest.setValue(Constants.userName, forHTTPHeaderField: "Api-Username")
        addTopicRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONSerialization.data(withJSONObject: ["title": title,
                                                                    "raw": content,
                                                                    "create_at": ""])
        addTopicRequest.httpBody = jsonData
        
        let dataTask =  session.dataTask(with: addTopicRequest) { (data, response, error) in
            if let error = error{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            if let httpResponse =  response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                DispatchQueue.main.async {
                    let httpError: NSError =  NSError(domain: "fetchTopic", code: httpResponse.statusCode, userInfo: nil)
                    completion(.failure(httpError))
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    let dataError: NSError = NSError(domain: "fetchTopic", code: 0, userInfo: nil)
                    completion(.failure(dataError))
                }
                return
            }
            
            do {
                let topic = try JSONDecoder().decode(Topic.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(topic))
                }
            }catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
        }
    
    @IBAction func addTopicButtonTapped(_ sender: Any) {
        //TODO aqui se debe llamar a la funcion que sube el topic y se cierra la  ventana modal
        addTopic {[weak self] result in
            guard let self =  self else {return}
            switch result{
                case.success(_):
                    // lanza alerta de exito
                    //cerrando ventana modal al pulsar el botón  de la alerta
                    self.showAlert("Topic añadido correctamente", "3 puntos colega", "volvemos", handler: ((UIAlertAction) -> Void)?{_ in 
                                    self.presentingViewController?.dismiss(animated: true, completion: nil)})
                    
                case.failure(let error):
                    // lanza alerta de error
                    // cerrando ventana modal al pulsar el botón  de la alerta
                    self.showAlert(String(error.localizedDescription), "Cascotazo", "Saliendo?", handler: ((UIAlertAction) -> Void)?{_ in
                                    self.presentingViewController?.dismiss(animated: true, completion: nil)})
                    
            }
        }
        
        
    }
    
    
    
}
