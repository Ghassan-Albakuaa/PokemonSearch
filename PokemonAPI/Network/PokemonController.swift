//
//  PokemonController.swift
//  PokemonAPI
//
//  Created by Ghassan  albakuaa  on 10/25/20.
//

import Foundation

class PokemonController  {
    
    var pokemonTeam: [Pokemon] = []
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    
    
    func getPokemon(searchTerm: String , completion: @escaping (Result<Pokemon , Error>)  -> Void) {
        let rquestURL = baseURL.appendingPathComponent(searchTerm.lowercased())
        
        
        //connect xcode with api
        URLSession.shared.dataTask(with: rquestURL) { (jsonData, _, error) in
            if let error = error {
                print("error getting pokemon: \(error)")
                completion(.failure(error))
                return
            }
            guard let pokemonData = jsonData else{
                print("error retrieving data from data task")
                completion(.failure(NSError()))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(Pokemon.self, from:pokemonData)      //     let pokemon = try JSONDecoder().decode(Pokemon.self, from: pokemonData)
                print(pokemon)
                completion(.success(pokemon))
            } catch {
                print("error decoding data to type pokemon: \(error)")
                completion(.failure(error))
                
            }
        }.resume()
    }
    func addPokemon(pokemon: Pokemon)  {
        pokemonTeam.append(pokemon)
    }
}
