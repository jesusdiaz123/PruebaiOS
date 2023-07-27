//
//  customCell.swift
//  ProyectoListaUsuarios
//
//  Created by Jesus Alberto Diaz de Leon on 24/07/23.
//

import UIKit
import Kingfisher

class customCell: UITableViewCell {
    
    //MARK: -Outlets

    @IBOutlet weak var labelPersona: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var labelGenero: UILabel!
    @IBOutlet weak var personImageView: UIImageView!
    
    //MARK: -Celda
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelPersona.font = UIFont.boldSystemFont(ofSize: 16)
        labelPersona .numberOfLines = 0
        
    }
    
    //MARK: -Actions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
