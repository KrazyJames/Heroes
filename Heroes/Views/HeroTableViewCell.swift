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
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var alignmentLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!

    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
    func configure(with hero: Hero) {
        nameLabel.text = hero.name
        let bio = hero.biography
        alignmentLabel.text = bio.alignment
        publisherLabel.text = bio.publisher
        switch bio.alignment.lowercased() {
            case "good":
                tagView.backgroundColor = .systemGreen
            case "bad":
                tagView.backgroundColor = .systemRed
            default:
                return
        }
        guard let imageUrl = URL(string: hero.image.url) else { return }
        heroImageView.af.setImage(withURL: imageUrl)
    }

}
