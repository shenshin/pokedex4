//
//  PokemonDetailVC.swift
//  pokedex4
//
//  Created by Aleksandr Shenshin on 16.07.17.
//  Copyright © 2017 Ales Shenshin. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
    }



}
