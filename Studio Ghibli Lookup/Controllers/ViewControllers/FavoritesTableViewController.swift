//
//  FavoritesTableViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/7/21.
//

import UIKit

class FavoritesTableViewController: UITableViewController {

    // MARK: - Properties
    
    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteController.shared.favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell()}
        
        cell.favoriteFilm = FavoriteController.shared.favorites[indexPath.row]
    
        return cell
    }
} // End of class
