//
//  PokedexTableViewController.swift
//  PokedexCodeable
//
//  Created by Chase on 2/28/23.
//

import UIKit

class PokedexTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPokedex()
    }

    // MARK: - Properties
    var topLevel: TopLevel?
    var pokedex: [PokemonResults] = []
    
    // MARK: - Functions
    func fetchPokedex() {
        NetworkingController.fetchPokedex(with: Constants.Pokemon.pokedexBaseURL) { result in
            switch result {
            case .success(let topLevel):
                self.topLevel = topLevel
                self.pokedex = topLevel.results
                self.reloadTableViewOnMain()
            case .failure(let error):
                print(error.errorDescription ?? "Unknown Error")
            }
        }
    }
    
    func reloadTableViewOnMain() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokedex.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath) as? PokemonTableViewCell else { return UITableViewCell() }

        let pokemon = pokedex[indexPath.row]
        cell.updateUI(forPokemon: pokemon)

        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let topLevel = topLevel else { return }
        
        if indexPath.row == pokedex.count - 1 {
            NetworkingController.fetchPokedex(with: topLevel.next) { result in
                switch result {
                case .success(let topLevel):
                    self.topLevel = topLevel
                    self.pokedex.append(contentsOf: topLevel.results)
                    self.reloadTableViewOnMain()
                    
                case .failure(let error):
                    print(error.errorDescription ?? "An Unknown Error Has Occured")
                }
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
