//
//  ViewController.swift
//  pokedex4
//
//  Created by Алик Базин on 13.07.2017.
//  Copyright © 2017 Ales Shenshin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let charmander = Pokemon(name: "Charmander", pokedexID: 4)
        print(charmander.name, " ", charmander.pokedexID)
    }


}

