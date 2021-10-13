//
//  NewsArticleTableViewCell.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 10/7/21.
//

import UIKit

class NewsArticleTableViewCell: UITableViewCell {

    // MARK: - Properties
    var article: Article?{
        didSet{
            updateView()
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    // MARK: - Helper methods
    func updateView(){
        guard let article = article,
              let link = article.articleImage?.thumbnail.contentUrl else { return }
        let url = URL(string: link)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data{
            let image = UIImage(data: imageData)
            articleImage.image = image
            
        }else{
            print("NO DATA FOR ARTICLE IMAGE")
        }
        articleImage.contentMode = .scaleAspectFit
        articleImage.layer.cornerRadius = 8
        
        providerLabel.text = article.provider[0].name
        dateLabel.text = article.datePublished
        articleTitle.text = article.name
        synopsisLabel.text = article.description
        
    }
}
