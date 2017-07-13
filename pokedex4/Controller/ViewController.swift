//
//  ViewController.swift
//  pokedex4
//
//  Created by Алик Базин on 13.07.2017.
//  Copyright © 2017 Ales Shenshin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer:AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.dataSource = self
        collection.delegate = self
        
        parsePokemonCSV()
        initAudio()
    }
    
    func parsePokemonCSV(){
        
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexID: pokeID)
                self.pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke = self.pokemon[indexPath.row]
            cell.configureCell(pokemon: poke)
                        
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    func initAudio(){
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        let pathURL = URL(string: path)!
        do {
            try self.musicPlayer = AVAudioPlayer(contentsOf: pathURL)
            self.musicPlayer.prepareToPlay()
            self.musicPlayer.numberOfLoops = -1
            self.musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        if self.musicPlayer.isPlaying {
            self.musicPlayer.pause()
            sender.alpha = 0.5
        } else {
            self.musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
}

