//
//  FilmDetailViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/7/21.
//

import UIKit

class FilmDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var filmTitleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var voiceActorTable: UITableView!
    
    // MARK: - Properties
    var film: Film?
    let defaultURL: URL = URL(string: "https://image.tmdb.org/t/p/w500/xi8z6MjzTovVDg8Rho6atJCcKjL.jpg")!
    var cast: [Cast] = []
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        //blurr()
        
        updateViews()
        voiceActorTable.delegate = self
        voiceActorTable.dataSource = self
        
    }
    
    // MARK: - Helper Methods
    func updateViews(){
        
        guard let film = film else { return }
        self.title = film.title
        filmTitleLabel.text = film.title
        yearLabel.text = film.releaseDate
        synopsisLabel.text = film.filmDescription
        
        
        MovieAPIController.fetchMovies(with: film.originalTitle) { (result) in
            
            //dispatch has to do with the view. if in background thread CANNOT UPDATE VIEW. print statemetns are okay, code changes are okay.
            
            //mightn not need this to call the function.
            DispatchQueue.main.async {
                
                switch result{
                
                case .success(let movie):
                    self.fetchPoster(for: movie)
                    self.fetchCast(for: movie)
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
    }
    
    func fetchPoster(for movie: Movie){
        
        //move into own function (param of movie) pass in move[0]
        MovieAPIController.fetchMoviePoster(with: movie.posterPath ?? defaultURL) { [weak self]result in
            //print(movie.posterImage)
            DispatchQueue.main.async {
                switch result{
                
                case .success(let image):
                    // self?.view.backgroundColor = UIColor(patternImage: image)
                    self?.view.contentMode = .scaleAspectFill
                    
                    self?.filmImageView.image = image
                    self?.filmImageView.contentMode = .scaleAspectFill
                    self?.filmImageView.layer.cornerRadius = 8
                case .failure(let error):
                    print("Error IMAGE in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func fetchCast(for movie: Movie){
        
        MovieAPIController.fetchPeople(for: movie.id) { (result) in
            
            DispatchQueue.main.async {
                switch result{
                
                case .success(let cast):
                    self.cast = cast
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func blurr(){
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
    }
    
} // End of class
extension FilmDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("number of cast is \(cast.count)")
        return cast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VOCell", for: indexPath) as? VoiceActorTableViewCell else { return UITableViewCell()}
        
        let castMember = cast[indexPath.row]
        
        cell.castMember = castMember
        
        return cell
    }
}
