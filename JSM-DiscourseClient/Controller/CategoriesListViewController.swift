//
//  CategoriesListViewController.swift
//  JSM-DiscourseClient
//
//  Created by Jorge Sanchez on 19/01/2021.
//

import UIKit

class CategoriesListViewController: UIViewController{
    
    @IBOutlet weak var tableViewCategories: UITableView!
   
    var categorieslist: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCategories.register(UINib(nibName: "topicsCell", bundle: nil), forCellReuseIdentifier: "topicsCell")
        tableViewCategories.dataSource = self
        
        fetchCategories{[weak self] result in
            guard let self =  self else {return}
            switch result{
                case.success(let category):
                    
                    self.categorieslist =  category
                    self.tableViewCategories.reloadData()
                    print (self.categorieslist?.categoryList.categories[0].name)
                case.failure(let error):
                    print(error)
            }
        }
        
    }
    
    private  func fetchCategories(completion: @escaping(Result<Category,Error>)-> Void){
        guard let url: URL = URL(string: Constants.urlCategories) else {return}
        let session: URLSession = URLSession(configuration: .default)
        let fetchCategoriesRequest: URLRequest = .init(url: url)
        
        let dataTask =  session.dataTask(with: fetchCategoriesRequest) { (data, response, error) in
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
                let category = try JSONDecoder().decode(Category.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(category))
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

extension CategoriesListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categorieslist?.categoryList.categories.count ?? 0

    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicsCell", for: indexPath)
        
        cell.textLabel?.text = categorieslist?.categoryList.categories[indexPath.row].name
        return cell
    }
}
