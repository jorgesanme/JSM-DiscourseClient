//
//  UsersListViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 19/01/2021.
//

import UIKit

class UsersListViewController: UIViewController{
    
    @IBOutlet weak var tableViewUser: UITableView!
    
    //cuando funcione le pongo nombre en ingles
    var listaUsuarios = user?.self
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewUser.register(UINib(nibName: "topicsCell", bundle: nil), forCellReuseIdentifier: "topicsCell")
        tableViewUser.dataSource = self
        fetchUser { [weak self] result in
            switch result {
                case.success(let userDecoded):
                    guard let users = userDecoded.directoryItems.map({ directoryItem  in
                        return directoryItem
                    })else {return}
                    //self?.listaUsuarios = users
                    self?.tableViewUser.reloadData()
                case.failure(let error):
                    print(error)
            }
            
        }
        
    }
    
    private func fetchUser(completion: @escaping (Result<user,Error>) -> Void){
        guard let url: URL = URL(string: Constants.urlUser) else {return}
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
                let userDecoded = try JSONDecoder().decode(user.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(userDecoded))
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

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1//listaUsuarios. 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "topicsCell", for: indexPath)
        
            //cell.textLabel?.text =  listaUsuarios.directoryItems?[indexPath.row].user?.username
        
            cell.textLabel?.text = " unser no encontrado"
       
       
        return cell
    }
    
    
}
//navigationController?.popViewController(animated: true)
