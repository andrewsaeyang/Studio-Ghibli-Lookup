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
            updateViews()
        }
    }
    
    // MARK: - Helper Methods
    func updateViews(){
        guard let cast = castMember else { return }
        roleLabel.text = cast.character
        nameLabel.text = cast.name
        
    }
}
