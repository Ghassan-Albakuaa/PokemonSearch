//
//  PokemonSearchViewController.swift
//  PokemonAPI
//
//  Created by Ghassan  albakuaa  on 10/25/20.
//

import UIKit

class PokemonSearchViewController: UIViewController , UISearchBarDelegate {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    var pokemonController: PokemonController?
    var pokemon: Pokemon? {
        didSet{
        updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return}
        pokemonController?.getPokemon(searchTerm: searchTerm) { (pokemon) in
            guard let searchPokemon = try? pokemon.get() else {return}
            DispatchQueue.main.async {
                self.pokemon = searchPokemon
            }
        }
        }
    
    func updateViews(){
        guard  let pokemon = pokemon else {return}
        saveButton.isEnabled = true
        title = pokemon.name.capitalized + " " + " ID: \(pokemon.id)"
        
        //get image
        guard let pokemonImageData = try? Data(contentsOf: pokemon.sprites.frontDefault) else { return  }
        imageView.image = UIImage(data: pokemonImageData)
    }
    
    func hideViews()
    {
        saveButton.isEnabled = false
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
        guard  let pokemonToBeSaved = pokemon else {return}
        pokemonController?.addPokemon(pokemon: pokemonToBeSaved)
       
        navigationController?.popToRootViewController(animated: true)
    }
    
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


