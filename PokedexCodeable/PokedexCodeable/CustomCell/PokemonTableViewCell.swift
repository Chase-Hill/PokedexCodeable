//
//  PokemonTableViewCell.swift
//  PokedexCodeable
//
//  Created by Chase on 2/28/23.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var pokemonSpriteImage: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    // MARK: - Functions
    override func prepareForReuse() {
        super.prepareForReuse()
        pokemonSpriteImage.image = nil
        pokemonNameLabel.text = nil
        pokemonIDLabel.text = nil
    }
    
    func updateUI(forPokemon pokemon: PokemonResults) {
        
        NetworkingController.fetchPokemon(with: pokemon.url) { result in
            switch result {
            case .success(let pokemon):
                self.fetchSprite(forPokemon: pokemon)
                DispatchQueue.main.async {
                    self.pokemonNameLabel.text = pokemon.name.capitalized
                    self.pokemonIDLabel.text = "Pokemon ID: \(pokemon.id)"
                }
                print(pokemon.name)
            case .failure(let error):
                print(error.errorDescription ?? "An Unknown Error Has Occured")
            }
        }
    }
    
    func fetchSprite(forPokemon pokemon: Pokemon) {
        NetworkingController.fetchSprite(for: pokemon.sprites.frontDefault) { result in
            switch result {
            case .success(let sprite):
                DispatchQueue.main.async {
                    self.pokemonSpriteImage.image = sprite
                }
            case .failure(let error):
                print(error.errorDescription ?? "An Unknown Error Has Occured")
            }
        }
    }
}
