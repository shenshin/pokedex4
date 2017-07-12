//
//  Pokemon.swift
//  pokedex4
//
//  Created by Алик Базин on 13.07.2017.
//  Copyright © 2017 Ales Shenshin. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexID: Int!
    
    var name: String {
        return self._name
    }
    
    var pokedexID: Int {
        return self._pokedexID
    }
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
    }
}
