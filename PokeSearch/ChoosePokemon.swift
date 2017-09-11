//
//  ChoosePokemon.swift
//  PokeSearch
//
//  Created by Guner Babursah on 26/08/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MapKit

class ChoosePokemon: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var pokemonTableView: UITableView!
    
    
    
    var inSearchMode = false
    var noFilterPokemonn = [String]()
    var filteredPokemon = [String]()
    
    var geoFire: GeoFire!
    var geoFireRef: DatabaseReference!
    
    let locationManager = CLLocationManager()
    var pokemonLocation = CLLocation()
    
    var pokemonNumberChosen: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonTableView.delegate = self
        pokemonTableView.dataSource = self
        
        search.delegate = self
        search.returnKeyType = UIReturnKeyType.done
        
        geoFireRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: geoFireRef)
        
    }
    
    

    //SETTING LOCATION
    func createSighting(forLoaction location: CLLocation, withPokemon pokeId: Int) {
        geoFire.setLocation(location, forKey: "\(pokeId)")
    }

    
    @IBAction func backToMainPageBtn(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    
    //TABLEVIEW FUNCTIONS
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            let pokemons: String!
            if inSearchMode {
                pokemons = filteredPokemon[indexPath.row]
                cell.updateUI(pokmeon: pokemons, pokemonId: (indexPath.row + 1))
                return cell
            } else {
                pokemons = pokemon[indexPath.row]
                cell.updateUI(pokmeon: pokemons, pokemonId: (indexPath.row + 1))
                return cell
            }
           
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        createSighting(forLoaction: pokemonLocation , withPokemon: (indexPath.row+1))
        pokemonNumberChosen = indexPath.row+1
        performSegue(withIdentifier: "cancelBtnSegue", sender: Any?.self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        } else {
            return pokemon.count
        }
    }
    
    
    //CencelBtnSegue
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "cancelBtnSegue" {
//            let yourVC: MainVC = segue.destination as! MainVC
////            yourVC.pokemonNumber = self.pokemonNumberChosen
//            yourVC.addMyPokemon(pokeId: self.pokemonNumberChosen)
//        }
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //SEARCHBAR FUNCTIONNS
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == nil) || (searchBar.text == "") {
            inSearchMode = false
            pokemonTableView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemon = pokemon.filter({$0.range(of: lower) != nil})
//            filteredPokemon = pokemon.filter({$0 == searchBar.text?.lowercased()})
            pokemonTableView.reloadData()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
