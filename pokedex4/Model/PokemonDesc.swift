//
//  PokemonDesc.swift
//  pokedex4
//
//  Created by Aleksandr Shenshin on 19.07.17.
//  Copyright © 2017 Ales Shenshin. All rights reserved.
//

import Foundation
import Alamofire

class PokemonDesc {
    
    private var url: String
    private var _pokeDesc: String!
    
    var pokeDesc: String {
        if _pokeDesc == nil {
            return "Class PokemonDesc: No description."
        } else {
            return _pokeDesc
        }
    }
    
    init (descriptionUrl: String) {
        self.url = descriptionUrl
    }
    
    func getDescFromUrl (comleted: @escaping DownloadComplete) {
        let fullURL = "\(URL_BASE)\(self.url)"
        Alamofire.request(fullURL).responseJSON(completionHandler: {response in
            if let descDic = response.result.value as? Dictionary<String, AnyObject> {
                if let desc = descDic["description"] as? String {
                    self._pokeDesc = desc
                    print("описание из класса PokemonDesc: ", self.pokeDesc)
                }
            } else {
                self._pokeDesc = "Description can not be uploaded."
                print("описание из класса PokemonDesc: ", self.pokeDesc)
            }
            comleted()
        }) //response
    }//func
    
}//class
