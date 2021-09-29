//
//  VoiceActorTableViewCell.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 9/16/21.
//

import UIKit

class VoiceActorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    
    // MARK: - Properties
    var castMember: Cast?{
        didSet{
            print("Is this working?")
            updateViews()
            
        }
    }
    
    // MARK: - Helper Methods
    func updateViews(){
        guard let cast = castMember else {
            roleLabel.text = "Cat"
            nameLabel.text = "Billy Bob"
            return }
        // TODO: Add Photo
        print("Cast member name is: \(cast.name) and role is: \(cast.character)")
        roleLabel.text = cast.character
        nameLabel.text = cast.name
        
    }
}
