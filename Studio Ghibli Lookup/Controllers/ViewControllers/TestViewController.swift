//
//  TestViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/9/21.
//

import UIKit

class TestViewController: UIViewController {

    // MARK: - Properties
    var films: [Film] = []
    var filteredFilms: [Film] = []
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    @IBOutlet weak var filmYear: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchFilms()
    }
    
    func fetchFilms(){
        StudioGhibliAPIController.fetchFilms { (result) in
            DispatchQueue.main.async {
                switch result{
                
                case .success(let films):
                    self.films = films
                    self.filmTitle.text = films[4].title
                    self.filmYear.text = films[4].releaseDate
                    
                    self.fetchMovie(for: self.films[4].originalTitle)
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func fetchMovie(for title: String){
        
        MovieAPIController.fetchMovies(with: title) { (result) in
            print(title)
            //dispatch has to do with the view. if in background thread CANNOT UPDATE VIEW. print statemetns are okay, code changes are okay.
            
            //mightn not need this to call the function.
            DispatchQueue.main.async {
                
                switch result{
                
                case .success(let movie):
                    print("Movie title is \(movie[0].movieTitle)")
                    self.fetchPoster(for: movie[0])
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
    }
    
    func fetchPoster(for movie: Movie){
        
        //move into own function (param of movie) pass in move[0]
        MovieAPIController.fetchMoviePoster(with: movie.posterImage) { [weak self]result in
            
            DispatchQueue.main.async {
                switch result{
                
                case .success(let image):
                    print(movie.movieTitle)
                    self?.image.image = image
                    
                case .failure(let error):
                    print("Error IMAGE in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }


}
