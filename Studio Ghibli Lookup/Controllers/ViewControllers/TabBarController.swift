//
//  ViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 8/31/21.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: - Outlets
    private let button:UIButton = {
       let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 52))
        button.setTitle("Testing", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create instances of view controllers
     
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let newsVC = UINavigationController(rootViewController: NewsViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        
        //set titles
        homeVC.title = "Home"
        newsVC.title = "News"
        favoritesVC.title = "Favorites"
        
        //assign view controllers to the tab bar
        self.setViewControllers([homeVC, newsVC, favoritesVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        let images = ["house", "star", "heart"]
        
        for i in 0..<items.count {
            items[i].image = UIImage(systemName: images[i])
        }
        
        self.tabBar.tintColor = .black
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.center = view.center
        
    }


}



