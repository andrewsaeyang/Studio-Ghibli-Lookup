//
//  FilmCollectionViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/2/21.
//

import UIKit

private let reuseIdentifier = "Cell"



class FilmCollectionViewController: UICollectionViewController {
    
    
    // MARK: - Properties
     private var films: [Film] = []
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Helper Methods
    func fetchFilms(){
        StudioGhibliAPIController.fetchFilms { (result) in
            DispatchQueue.main.async {
                switch result{
                
                case .success(let films):
                    self.films = films
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return films.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as? FilmCollectionViewCell else { return UICollectionViewCell()}
        
        let film = films[indexPath.row]
        
        
        
        
    
        // Configure the cell
    
        return cell
    }

   
}
