//
//  ModalFiltroVC.swift
//  ProyectoListaUsuarios
//
//  Created by Jesus Alberto Diaz de Leon on 20/07/23.
//

import UIKit

    //MARK: -DataEnteredDelegate

    //Protocolo Delegado para mandar informacion a la vista anterior
    protocol DataEnteredDelegate: AnyObject {
        func userDidEnterInformation(male: Bool, female: Bool)
    }

    

    //MARK: -Vista
class ModalFiltroVC: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var btnMujer: UIButton!
    @IBOutlet weak var btnHombre: UIButton!
    
    //MARK: -Variables
    var filterMale: Bool!
    var filterFemale: Bool!
    weak var delegate: DataEnteredDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if filterMale == true && filterFemale == false{
            btnHombre.tintColor = .red
            colorBotonDefecto(btnDefecto: btnMujer)
            
        } else if filterFemale == true && filterMale == false {
            colorBotonDefecto(btnDefecto: btnHombre)
            btnMujer.tintColor = .red
        }
    }
    
    //MARK: -Funciones
    
    //Cambia el color del texto del boton dependiendo del modo (Oscuro o Normal)
    func colorBotonDefecto(btnDefecto: UIButton){
        if self.traitCollection.userInterfaceStyle == .dark {
            btnDefecto.tintColor = .white
        } else {
            btnDefecto.tintColor = .black
        }
    }
    
    //MARK: -Actions
    
    //Accion para mandar el dato para la validacion del filtro
    @IBAction func hombreAction(_ sender: Any) {
        
        delegate?.userDidEnterInformation(male: true, female: false)
        self.dismiss(animated: true, completion: nil)
        btnHombre.tintColor = .red
        colorBotonDefecto(btnDefecto: btnMujer)
    }
    
    @IBAction func mujerAction(_ sender: Any) {
        
        delegate?.userDidEnterInformation(male: false, female: true)
        self.dismiss(animated: true, completion: nil)
        colorBotonDefecto(btnDefecto: btnHombre)
        btnMujer.tintColor = .red
    }
}
