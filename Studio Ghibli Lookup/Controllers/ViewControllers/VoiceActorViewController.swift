//
//  VoiceActorTableViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/17/21.
//

import UIKit

protocol reloadProtocol: AnyObject {
    func reloadIt()
}

class VoiceActorViewController: UITableViewController {
    
   
    
    // MARK: - Properties
    
    var film: Film?
    var castMemebers: [Cast]?
    weak var delegate: reloadProtocol?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let film = film else { return }
        fetchCastMembers(for: film.originalTitle)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.contentSize.height = 1000
    }
    
    // MARK: - Helper Methods
    func fetchCastMembers(for name: String){
        MovieAPIController.fetchMovies(with: name) { (result) in
            switch result{
            
            case .success(let movie):
                self.setCastMembers(for: movie)
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    func setCastMembers(for movie: Movie){
        
        MovieAPIController.fetchPeople(for: movie.id) { (result) in
            
            switch result{
            case .success(let cast):
                self.castMemebers = cast
                print("number of cast is \(cast.count)")
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cast = castMemebers else { return 1}
        print("number of cast in num rows section \(cast.count)")
        return cast.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VOCell", for: indexPath) as? VoiceActorTableViewCell,
              let film = film,
              let cast = castMemebers else { return UITableViewCell()}
        
        
        MovieAPIController.fetchMovies(with: film.originalTitle) { [weak self]result in
            switch result{
            
            case .success(let movie):
                self!.setCastMembers(for: movie)
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
        }
        print("Cast member in data source is \(cast.count)")
        let castMember = cast[indexPath.row]
        cell.castMember = castMember
        
        
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
