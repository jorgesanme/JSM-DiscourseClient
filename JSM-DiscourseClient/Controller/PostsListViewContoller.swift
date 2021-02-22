//
//  PostsListViewContoller.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 20/01/2021.
//

import UIKit

class PostsListViewContoller: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var postList: [LatestPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PostsCell", bundle: nil), forCellReuseIdentifier: "PostsCell")
        fetchTopic { [weak self] result in
            switch result {
                case.success(_):
                    //self?.postList = post
                    self?.postList = [LatestPost(id: 1, name: "uno"),LatestPost(id: 2, name: "dos")]
                    self?.tableView.reloadData()
                    break
                case.failure(let error):
                    print(error)
            }
        }
    }
    
    private func fetchTopic(completion: @escaping(Result<Posts, Error>) -> Void){
        guard let url: URL = URL(string: Constants.urlPosts) else {return}
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
                let post = try JSONDecoder().decode(Posts.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(post))
                }
            }catch{
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
        }
    

}

extension PostsListViewContoller: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicsCell", for: indexPath)
        cell.textLabel?.text = postList[indexPath.row].name
        performSegue(withIdentifier: "SEGUE_TO_DETAIL", sender: "")
        
        return cell
    }
    
    
    }
