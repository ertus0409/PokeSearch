//
//  TableViewCell.swift
//  PokeSearch
//
//  Created by Guner Babursah on 26/08/2017.
//  Copyright © 2017 Guner Babursah. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var thumbImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(pokmeon: String, pokemonId: Int){
        nameLbl.text? = pokmeon.capitalized
        thumbImg.image = UIImage(named: "\(pokemonId)")
    }


}
