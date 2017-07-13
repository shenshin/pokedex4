//
//  PokeCell.swift
//  pokedex4
//
//  Created by Алик Базин on 13.07.2017.
//  Copyright © 2017 Ales Shenshin. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    //скруглённые края у ячейки
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 10.0
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        self.nameLbl.text = self.pokemon.name.capitalized
        self.thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
}
