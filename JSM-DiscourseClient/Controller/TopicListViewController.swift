//
//  ViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 15/01/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var latestTopic: Topic?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "topicsCell", bundle: nil), forCellReuseIdentifier: "topicsCell")
        tableView.dataSource =  self
        
        fetchTopic {[weak self] result in
            switch result {
                case.success(let topic):
                    self?.latestTopic = topic
                    self?.tableView.reloadData()
                case.failure(let error):
                    print(error)
            }
            
        }
    }

    
    
    private func fetchTopic(completion: @escaping(Result<Topic, Error>) -> Void){
        guard let url: URL = URL(string: Constants.urlLatestTopic) else {return}
        let session: URLSession = URLSession(configuration: .default)
        let fetchTopicRequest: URLRequest = .init(url: url)
        
        let dataTask =  session.dataTask(with: fetchTopicRequest) { (data, response, error) in
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier,
           segueIdentifier == "DIRECTO_TO_DETAIL"{
            let destination = segue.destination as? TopicDetailViewController
            
            let indexPathSelected = tableView.indexPathForSelectedRow!
            guard  let selectedTopic = latestTopic?.topicList?.topics?[indexPathSelected.row] as? Topic? else {return}
            destination?.detailTopic = selectedTopic
        }
        
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestTopic?.topicList?.topics?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicsCell", for: indexPath)
        cell.textLabel?.text = latestTopic?.topicList?.topics?[indexPath.row].title
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        performSegue(withIdentifier: "DIRECTO_TO_DETAIL", sender: nil)
        if(indexPath.row < latestTopic?.topicList?.topics?.count ?? 1 ){
            performSegue(withIdentifier: "DIRECTO_TO_DETAIL", sender: latestTopic?.topicList?.topics?[indexPath.row])
        }
        
        
    }
    
    }
    

  //navigationController?.popViewController(animated: true)
    
//performSegue(withIdentifier: "SEGUE_TO_DETAIL", sender: "")
    


