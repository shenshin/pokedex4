//
//  Pokemon.swift
//  pokedex4
//
//  Created by Алик Базин on 13.07.2017.
//  Copyright © 2017 Ales Shenshin. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String! //?
    private var _pokedexID: Int! //?
    private var _description: String!
    private var _type: String!//+
    private var _defense: Int! //+
    private var _height: String! //+
    private var _weight: String! //+
    private var _attack: Int! //+
    private var _nextEvolutionTxt: String! //+
    private var _nextEvolutionNum: String! //+
    private var _pokemonURL: String! //-
    
    
    var name: String {
        if self._name == nil {
            self._name = ""
        }
        return self._name
    }
    
    var pokedexID: Int {
        if self._pokedexID == nil {
            self._pokedexID = 0
        }
        return self._pokedexID
    }
    
    var description: String {
        if self._description == nil {
            self._description = ""
        }
        return self._description
    }
    
    var type: String {
        if self._type == nil {
            self._type = ""
        }
        return self._type
    }
    
    var defense: Int {
        if self._defense == nil {
            self._defense = 0
        }
        return self._defense
    }
    
    var height: String {
        if self._height == nil {
            self._height = ""
        }
        return self._height
    }
    
    var weight: String {
        if self._weight == nil {
            self._weight = ""
        }
        return self._weight
    }
    
    var attack: Int {
        if self._attack == nil {
            self._attack = 0
        }
        return self._attack
    }
    
    var nextEvolutionTxt: String {
        if self._nextEvolutionTxt == nil {
            self._nextEvolutionTxt = ""
        }
        return self._nextEvolutionTxt
    }
    
    var nextEvolutionNum: String {
        if self._nextEvolutionNum == nil {
            self._nextEvolutionNum = ""
        }
        return self._nextEvolutionNum
    }
    
    init(name: String, pokedexID: Int){
        self._name = name
        self._pokedexID = pokedexID
        self._pokemonURL = URL_BASE + ULR_POKEMON + String(self.pokedexID) + "/"
    }
    
    //функция для создания позднего связывания
    func downloadPokemonDetails(completed: @escaping DownloadComplete ) {
    //func downloadPokemonDetails(completed: DownloadComplete) {
        
        Alamofire.request(self._pokemonURL).responseJSON { response in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = attack
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = defense
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                
                //Заполнение Типа покемона в переменную self._type в виде строки
                if let typesArr = dict["types"] as? [Dictionary<String,String>], typesArr.count > 0 {
                    var type = ""
                    for typeDics in typesArr {
                        type += "\(typeDics["name"]!.capitalized)/"
                    }
                    type.removeLast(1)
                    self._type = type
                } else {
                    self._type = ""
                }
                
                //Нахождение Описания для покемона
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>], descArr.count > 0 {
                    if let url = descArr[0]["resource_uri"] {                        
                        let fullURL = "\(URL_BASE)\(self.url)"
                        Alamofire.request(fullURL).responseJSON(completionHandler: {response in
                            if let descDic = response.result.value as? Dictionary<String, AnyObject> {
                                if let desc = descDic["description"] as? String {
                                    self._description = desc
                                } else {
                                    self._description = "Description can not be uploaded1."
                                }
                            } else {
                                self._description = "Description can not be uploaded2."
                            }
                            completed()
                        })
                    }
                } 
                
                //Эволюция: название и номер
                if let evolutionArr = dict["evolutions"] as? Array<AnyObject> {
                    if evolutionArr.count > 0 {
                        if let evolutionDict = evolutionArr[0] as? Dictionary<String,AnyObject> {
                            if let evolutionURL = evolutionDict["resource_uri"] as? String {
                                let evolURLtoArray = evolutionURL.components(separatedBy: "/") //"/api/v1/pokemon/3/"
                                if evolURLtoArray.count > 0 {
                                    let number = Int(evolURLtoArray[evolURLtoArray.count - 2])
                                    if number! < 0 || number! <= 718 {
                                        self._nextEvolutionNum = "\(number!)"
                                    } else {
                                        self._nextEvolutionNum = ""
                                    }
                                    
                                } else {
                                    self._nextEvolutionTxt = "no"
                                    self._nextEvolutionNum = ""
                                }
                            }
                            if let evolutionName = evolutionDict["to"] as? String {
                                self._nextEvolutionTxt = evolutionName
                            }
                        }
                    } else {
                        self._nextEvolutionTxt = "no"
                        self._nextEvolutionNum = ""
                    }
                    
                   
                }
                
            } //if
            completed()
        } //response
        
    } //func
    
} //class
