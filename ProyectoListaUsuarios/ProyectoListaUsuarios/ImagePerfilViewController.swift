//
//  ImagePerfilViewController.swift
//  ProyectoListaUsuarios
//
//  Created by Jesus Alberto Diaz de Leon on 25/07/23.
//

import UIKit

class ImagePerfilViewController: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var imagePerfil: UIImageView!
    
    
    //MARK: -Variables
    var urlImagen: String?
    
    //MARK: -Vista
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePerfil.kf.setImage(with: URL(string: urlImagen ?? "" ))
        
    }
    

    
}
