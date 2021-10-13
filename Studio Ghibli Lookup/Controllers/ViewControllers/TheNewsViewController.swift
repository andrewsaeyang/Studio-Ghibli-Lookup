//
//  TheNewsViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 10/4/21.
//

import UIKit

class TheNewsViewController: UIViewController {
    
    
    // MARK: - Propterties
    let reuseConstant = "newsArticleCell"
    
    var newsArticles: [Article] = []{
        didSet{
            print("number of articles is \(newsArticles.count)")
            tableView.reloadData()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        fetchNewsArticles()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        
    }
    
    // MARK: - Helper Methods
    func fetchNewsArticles(){
        BingNewsAPIController.fetchNews { result in
            DispatchQueue.main.async {
                
                
                switch result{
                
                case .success(let news):
                    self.newsArticles = news.articles
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
    }
} // End of class

extension TheNewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        print("Number of articles is at return count is  \(newsArticles.count)")
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseConstant, for: indexPath) as? NewsArticleTableViewCell else { return UITableViewCell()}
        
        cell.article = newsArticles[indexPath.row]
        
        return cell 
        
    }
}
