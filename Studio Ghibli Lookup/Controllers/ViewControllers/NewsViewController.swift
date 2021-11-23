//
//  NewsViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 10/4/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Propterties
    let reuseConstant = "newsArticleCell"
    
    var newsArticles: [Article] = []{
        didSet{
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        
        loadingView.isHidden = false
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.startAnimating()
        loadingView.backgroundColor = UIColor(white: 1, alpha: 0.6)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.separatorColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        fetchNewsArticles()
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
                self.loadingView.isHidden = true
                self.loadingIndicator.stopAnimating()
            }
        }
    }
} // End of class

extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseConstant, for: indexPath) as? NewsArticleTableViewCell else { return UITableViewCell()}
        cell.article = newsArticles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: newsArticles[indexPath.row].url){
            UIApplication.shared.open(url)
        }
    }
}// End of Extension
