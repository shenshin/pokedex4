//
//  PokemonDetailVC.swift
//  pokedex4
//
//  Created by Aleksandr Shenshin on 16.07.17.
//  Copyright © 2017 Ales Shenshin. All rights reserved.
//

import UIKit
import Alamofire

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel! //+
    @IBOutlet weak var mainImg: UIImageView! //+
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel! //+
    @IBOutlet weak var defenceLbl: UILabel! //+
    @IBOutlet weak var heightLbl: UILabel! //+
    @IBOutlet weak var pokedexLbl: UILabel! //+
    @IBOutlet weak var weightLbl: UILabel! //+
    @IBOutlet weak var attackLbl: UILabel! //+
    @IBOutlet weak var evoLbl: UILabel! //+
    @IBOutlet weak var currentEvoImg: UIImageView! //+
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    var pokemon: Pokemon!
    
   /* override func viewWillDisappear(_ animated: Bool) {
        nameLbl.text = ""
        mainImg.image = UIImage()
        descriptionLbl.text = ""
        typeLbl.text = ""
        defenceLbl.text = ""
        heightLbl.text = ""
        pokedexLbl.text = ""
        weightLbl.text = ""
        attackLbl.text = ""
        evoLbl.text = ""
        currentEvoImg.image = UIImage()
        nextEvoImg.image = UIImage()
    }*/
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemon.downloadPokemonDetails {
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        self.nameLbl.text = pokemon.name
        self.mainImg.image = UIImage(named: "\(pokemon.pokedexID)")
        self.typeLbl.text = pokemon.type
        self.defenceLbl.text = "\(pokemon.defense)"
        self.heightLbl.text = pokemon.height
        self.pokedexLbl.text = "\(pokemon.pokedexID)"
        self.weightLbl.text = pokemon.weight
        self.attackLbl.text = "\(pokemon.attack)"
        self.evoLbl.text = pokemon.nextEvolutionTxt
        if pokemon.nextEvolutionTxt == "No evolutions" || pokemon.nextEvolutionNum == "" {
            self.nextEvoImg.isHidden = true
        } else {
            self.nextEvoImg.image = UIImage(named: pokemon.nextEvolutionNum)
        }
        self.currentEvoImg.image = UIImage(named: "\(pokemon.pokedexID)")
        self.descriptionLbl.text = pokemon.description
        
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}

