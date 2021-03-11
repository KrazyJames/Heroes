//
//  HeroTableViewCell.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import UIKit
import AlamofireImage

class HeroTableViewCell: UITableViewCell {
    
    static let identifier = "HeroTableViewCell"
    
    //MARK: - IBOutlets
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alignmentLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!

    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func configure(with hero: Hero) {
        nameLabel.text = hero.name
        alignmentLabel.text = hero.biography.alignment
        publisherLabel.text = hero.biography.publisher
        guard let imageUrl = URL(string: hero.image.url) else { return }
        heroImageView.af.setImage(withURL: imageUrl)
    }

}
