//
//  HeroDetailViewController.swift
//  Heroes
//
//  Created by Jaime Escobar on 08/03/21.
//

import UIKit
import AlamofireImage

class HeroDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var heroImageView: UIImageView!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var firstAppearanceLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    
    @IBOutlet weak var intelligenceLabel: UILabel!
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var durabilityLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var combatLabel: UILabel!
    
    private var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        guard let hero = hero else { return }
        title = hero.name
        
        let bio = hero.biography
        
        publisherLabel.text = bio.publisher
        fullNameLabel.text = getStatText(stat: bio.fullName)
        firstAppearanceLabel.text = bio.firstAppearance
        occupationLabel.text = hero.work.occupation
        
        let stats = hero.powerstats
        
        intelligenceLabel.text = getStatText(stat: stats.intelligence)
        strengthLabel.text = getStatText(stat: stats.strength)
        speedLabel.text = getStatText(stat: stats.speed)
        durabilityLabel.text = getStatText(stat: stats.durability)
        powerLabel.text = getStatText(stat: stats.power)
        combatLabel.text = getStatText(stat: stats.combat)
        
        guard let url = URL(string: hero.image.url) else { return }
        heroImageView.af.setImage(withURL: url)
    }
    
    func configure(with hero: Hero) {
        self.hero = hero
    }
    
    private func getStatText(stat: String) -> String {
        if stat.isEmpty || stat == "null" {
            return "Not specified"
        } else {
            return stat
        }
    }

}
