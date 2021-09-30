//
//  HomeViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/3/21.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    var films: [Film] = []
    var filteredFilms: [Film] = []
    var castMemebers: [Cast]?
    let highPriorityQueue = DispatchQueue.global(qos: .userInitiated)
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        fetchFilms()
        self.title = "Home"
        
    }
    
    // MARK: - Helper Methods
    func fetchFilms(){
        StudioGhibliAPIController.fetchFilms { (result) in
            DispatchQueue.main.async {
                switch result{
                case .success(let films):
                    self.films = films
                    self.filteredFilms = films
                    self.collectionView.reloadData()
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func fetchCastMembers(for name: String, destination: FilmDetailViewController){
        MovieAPIController.fetchMovies(with: name) { (result) in
            
            switch result{
            case .success(let movie):
                self.setCastMembers(for: movie, destination: destination)
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    func setCastMembers(for movie: Movie, destination: FilmDetailViewController){
        
        MovieAPIController.fetchCastMembers(for: movie.id) { (result) in
            
            switch result{
            case .success(let cast):
                destination.castMemebers = cast
                print("number of cast is \(cast.count)")
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredFilms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmCell", for: indexPath) as? FilmCollectionViewCell else { return UICollectionViewCell()}
        
        cell.film = filteredFilms[indexPath.row]
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC"{
            guard let cell = sender as? FilmCollectionViewCell,
                  let indexPath = collectionView.indexPath(for: cell),
                  let destination = segue.destination as? FilmDetailViewController else { return }
            
            let filmToSend = filteredFilms[indexPath.row]
            
            highPriorityQueue.async {
                
                self.segueCastMembers(for: filmToSend, destination: destination)
                destination.film = filmToSend
            }
        }
    }
    
    func segueCastMembers(for film: Film, destination: FilmDetailViewController){
        fetchCastMembers(for: film.originalTitle, destination: destination)
    }
    
} // End of class

//MARK: - Collection View Flow Layout Delegate Methods
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //we want 90% of the screen to be used, / 2 - 45%
        
        let width = view.frame.width * 0.45
        
        return CGSize(width: width, height: width * 3/2 )
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let width = view.frame.width * 0.45
        let cellsTotalWidth = width * 2
        let leftOverWidth = view.frame.width - cellsTotalWidth
        let inset = leftOverWidth / 3
        //insets == padding
        return UIEdgeInsets(top: inset, left: inset, bottom: 0, right: inset)
    }
} //End of extension


// MARK: - Search Bar Delegate Methods
extension HomeViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredFilms = films
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            self.collectionView.reloadData()
            return
        }
        
        let filtered = filteredFilms.filter {
            $0.title.localizedCaseInsensitiveContains(searchTerm)
        }
        
        self.filteredFilms = filtered
        self.collectionView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredFilms = films
        collectionView.reloadData()
        //searchBar.text = ""
        searchBar.resignFirstResponder()
    }
} //End of extension
