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
        return topLevel?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokedexCell", for: indexPath)

        let pokemon = pokedex[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = pokemon.name
        config.secondaryText = pokemon.url
        cell.contentConfiguration = config

        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
