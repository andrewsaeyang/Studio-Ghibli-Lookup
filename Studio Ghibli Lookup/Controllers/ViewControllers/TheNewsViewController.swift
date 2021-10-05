//
//  TheNewsViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 10/4/21.
//

import UIKit

class TheNewsViewController: UIViewController {
    
    var newsArticles: [Value] = []{
        didSet{
            print("number of articles is \(newsArticles.count)")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNewsArticles()
        
        
    }
    
    // MARK: - Helper Methods
    func fetchNewsArticles(){
        BingNewsAPIController.fetchNews { result in
            
            switch result{
            
            case .success(let news):
                self.newsArticles = news.value
                
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        
    }
}
