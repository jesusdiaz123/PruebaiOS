//
//  UsuarioViewController.swift
//  ProyectoListaUsuarios
//
//  Created by Jesus Alberto Diaz de Leon on 24/07/23.
//

import UIKit

class UsuarioViewController: UIViewController {
    
    
    //MARK: - Outlets
     
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var ubicacionButton: UIButton!
    @IBOutlet weak var direccionLabel: UILabel!
    @IBOutlet weak var telefonoLabel: UILabel!
    @IBOutlet weak var portadaImage: UIImageView!
    @IBOutlet weak var paisLabel: UILabel!
    @IBOutlet weak var generoLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var perfilImage: UIImageView!
    
    //MARK: -Variables
    
    var myUser: [Result]?
    var myUserName: String?
    var myNumberUser: Int?
    
    //MARK: -Vista
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portadaImage.kf.setImage(with: URL(string:"https://random.imagecdn.app/500/150"))
        confPortada(portada: portadaImage)

        perfilImage.kf.setImage(with: URL(string: myUser?[myNumberUser ?? 0].picture.medium ?? ""))
        confPerfil(perfil: perfilImage)
        
        nombreLabel.text = nombreCompleto()
        direccionLabel.text = direccioCompleta()
        direccionLabel.numberOfLines = 0
        paisLabel.text = estadoPais()
        telefonoLabel.text = myUser?[myNumberUser ?? 0].phone
        generoLabel.text = generoFunc(genero: myUser?[myNumberUser ?? 0].gender ?? "male")
        emailLabel.text = myUser?[myNumberUser ?? 0].email
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UsuarioViewController.tappedMe))
        perfilImage.addGestureRecognizer(tap)
        perfilImage.isUserInteractionEnabled = true
    }
    
    //MARK: -Funciones
    //Configuramos la imagen de Portada
    func confPortada(portada: UIImageView){
        portada.clipsToBounds = true
        portada.layer.borderWidth = 3.0
        if self.traitCollection.userInterfaceStyle == .dark {
            portada.layer.borderColor = UIColor.white.cgColor
        } else {
            portada.layer.borderColor = UIColor.black.cgColor
        }
        
    }
    
    //Configuramos la imagen de Perfil
    func confPerfil(perfil: UIImageView){
        perfil.layer.cornerRadius = (perfilImage.frame.size.width) / 2;
        perfil.clipsToBounds = true
        perfil.layer.borderWidth = 3.0
        if self.traitCollection.userInterfaceStyle == .dark {
            perfil.layer.borderColor = UIColor.white.cgColor
        } else {
            perfil.layer.borderColor = UIColor.black.cgColor
        }
    }
    //Funciona para el nombre completo
    func nombreCompleto() -> String{
        let name = (myUser?[myNumberUser!].name.first ?? "") + " " + (myUser?[myNumberUser!].name.last ?? "")
        
        return name
    }
    //Funcion para la direccion
    func direccioCompleta() -> String{
        let direction = (myUser?[myNumberUser!].location.street.name ?? "") + " " + String((myUser?[myNumberUser!].location.street.number ?? 0))
        let city =  ", " + (myUser?[myNumberUser!].location.city ?? " ")
        
        let direccionFinal = direction + city
        
        return direccionFinal
    }
    
    //Funcion para el estado y el pais
    func estadoPais() -> String{
        let result = (myUser?[myNumberUser!].location.state ?? "") + ", " + String((myUser?[myNumberUser!].location.country ?? ""))
        
        return result
    }
    
    func latitud() -> Double {
        guard let latitud = Double(myUser?[myNumberUser ?? 0].location.coordinates.latitude ?? "0") else { return 0}
        return latitud
    }
    
    func longitud() -> Double {
        guard let longitud = Double(myUser?[myNumberUser ?? 0].location.coordinates.longitude ?? "0") else { return 0}
        return longitud
    }
    
    //Funcion que cambia el valor del genero a Espanol
    func generoFunc(genero: String) -> String {
        if genero == "male" {
            return "Masculino"
        } else {
            return "Fememino"
        }
    }
    
    //MARK: -Actions
    
    
    //Accion al hacer tap en la imagen de perfil
    @objc func tappedMe()
    {
        performSegue(withIdentifier: "vcImage", sender: self)
    }
    
    //Accion para mostrar la ubicacion
    @IBAction func ubicacionAction(_ sender: Any) {
        performSegue(withIdentifier: "VCMapa", sender: self)
    }
    
    //MARK: - Preparacion para la siguiente vista
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destino = segue.destination as? MapViewController {
            destino.latitud = latitud()
            destino.longitud = longitud()
            
        }
        
        if let destino = segue.destination as? ImagePerfilViewController {
            destino.urlImagen = (myUser?[myNumberUser ?? 0].picture.medium ?? "")
            
        }
        
        
    }
    
    
    
}
