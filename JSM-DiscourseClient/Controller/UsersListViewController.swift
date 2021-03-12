//
//  UsersListViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 19/01/2021.
//

import UIKit

class UsersListViewController: UIViewController{
    
    @IBOutlet weak var tableViewUser: UITableView!
    
    var userList: UserModel?
    var userImage: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewUser.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        tableViewUser.dataSource = self
        tableViewUser.delegate = self
        
        fetchUser { [weak self] result in
            switch result {
                case.success(let userDecoded):
                    
                    self?.userList = userDecoded
                    self?.tableViewUser.reloadData()
                    
                case.failure(let error):
                    print(error)
            }
            
        }
        
    }
    
    private func fetchImage(url: String) -> UIImage?{
        let imageURL =  Constants.userImage + url
        //        let otraURL =  "https://mdiscourse.keepcoding.io\(url)"
        //se limpia a url para que {size} tenga un tamaño de xx
        let cleanUrl = imageURL.replacingOccurrences(of: "{size}", with: "50")
        
        guard let imageUrl: URL = URL(string: cleanUrl) else {return nil}
        
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
            if let imageUrl: URL = URL(string: cleanUrl),
               let imageData = try? Data(contentsOf: imageUrl){             DispatchQueue.main.async {
                    self?.userImage = UIImage(data: imageData)
                }
            }
        }
        return userImage
    }
    
    private func fetchUser(completion: @escaping (Result<UserModel,Error>) -> Void){
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
                let userDecoded = try JSONDecoder().decode(UserModel.self, from: data)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueIdentifier = segue.identifier,
           segueIdentifier == "SEGUE_TO_USERDETAIL"{
            let destination = segue.destination as? UserDetailViewController
            
            let indexPathSelected = tableViewUser.indexPathForSelectedRow!
            guard  let selectedUser = userList?.directoryItems[indexPathSelected.row]  as? DirectoryItem? else {return}
            destination?.detailUser = selectedUser
        }
    }
}

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userList?.directoryItems.count ?? 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell
        let imageurl = userList?.directoryItems[indexPath.row].user.avatarTemplate
        
        
        if let image = fetchImage(url: imageurl ?? "") {
            cell?.userImage.image = image
        }
        
        cell?.nameLabel.text = userList?.directoryItems[indexPath.row].user.name
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row <  userList?.directoryItems.count ?? 1){
            performSegue(withIdentifier: "SEGUE_TO_USERDETAIL", sender: userList?.directoryItems[indexPath.row])
        }
    }
}

