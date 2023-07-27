//
//  ViewController.swift
//  ProyectoListaUsuarios
//
//  Created by Jesus Alberto Diaz de Leon on 20/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: -Outlet
    @IBOutlet weak var personasTable: UITableView!
    
    //MARK: -Variables
    private var myUsers: [Result] = []
    private var myUsersDefault: [Result] = []
    private var numColumna = 0
    private var filterMale = false
    private var filterFemale = false
    
    //MARK: -Vista
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Registramos la customCell
        personasTable.register(UINib(nibName: "customCell", bundle: nil), forCellReuseIdentifier: "myCustomCell")
        
        //Hacemos el llamado a la API con el resultado de 50 personas aleatoreas y recargamos la tabla
        NetworkingProvider.shared.getList() { (user) in
            self.myUsers = user
            self.myUsersDefault = user
            DispatchQueue.main.async {
                self.personasTable.reloadData()
            }

        } failure: { (error) in
            print(error.debugDescription)
        }
        
        //Empezamos a configurar nuestra tabla
        personasTable.dataSource = self
        personasTable.tableFooterView = UIView()
        personasTable.delegate = self
        
        
    }
    
    //MARK: -Actions

    //Generamos una nueva lista
    @IBAction func generarListaAction(_ sender: Any) {
        
        NetworkingProvider.shared.getList() { (user) in
            self.myUsers = user
            DispatchQueue.main.async {
                self.personasTable.reloadData()
            }
            
        } failure: { (error) in
            print(error.debugDescription)
        }
        
        DispatchQueue.main.async {
            self.personasTable.reloadData()
        }
        filterMale = false
        filterFemale = false
    }
    
    //Volvemos la lista a los primeros 50 resultados
    @IBAction func reserAction(_ sender: Any) {
        self.myUsers = self.myUsersDefault
        DispatchQueue.main.async {
            self.personasTable.reloadData()
        }
        filterMale = false
        filterFemale = false
    }
    
    //MARK: -Preparacion para enviar datos a otra vista
    //Validacion para saber a que Vista mandaremos los datos
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destino = segue.destination as? UsuarioViewController {
            destino.myUser = myUsers
            destino.myNumberUser = numColumna
            
        }
        
        if let vcFiltro = segue.destination as? ModalFiltroVC {
            vcFiltro.delegate = self
            if #available(iOS 15.0, *) {
                if let sheet = vcFiltro.sheetPresentationController {
                    sheet.detents = [.medium()]
                    sheet.preferredCornerRadius = 20
                }
            } else {
                // Fallback on earlier versions
            }
            vcFiltro.filterMale = filterMale
            vcFiltro.filterFemale = filterFemale
        }
        
    }
}

//MARK: - DataSource
extension ViewController: UITableViewDataSource{
    
    //Altura de la celda
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 80
    }
    
    //Numero de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        myUsers.count
        
    }
    
    // LLenamos los renglones con la informacion requerida
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = personasTable.dequeueReusableCell(withIdentifier: "myCustomCell", for: indexPath) as? customCell
        
        cell?.labelPersona.text = myUsers[indexPath.row].name.title + " " + myUsers[indexPath.row].name.first + " " + myUsers[indexPath.row].name.last
        cell?.labelEmail.text = myUsers[indexPath.row].email
        if myUsers[indexPath.row].gender == "male" {
            cell?.labelGenero.text = "Género Masculino"
        } else {
            cell?.labelGenero.text = "Género Femenino"
        }
        cell?.personImageView.kf.setImage(with: URL(string: myUsers[indexPath.row].picture.thumbnail))
        return cell!
        
    }
    
}

//MARK: - Delegate del TableView

//Accion al seleccionar un renglon
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        numColumna = indexPath.row
        performSegue(withIdentifier: "VCUsuario", sender: self)
        
    }
    
}

//MARK: - DataEnteredDelegate

//Obtenemos los datos requeridos de la vista siguiente
extension ViewController: DataEnteredDelegate {
    
    
    func userDidEnterInformation(male: Bool, female: Bool) {
        //Hacemos la validacion para aplicar filtro
        if male {
            NetworkingProvider.shared.getListMale() { (user) in
                self.myUsers = user
                DispatchQueue.main.async {
                    self.personasTable.reloadData()
                }
                
            } failure: { (error) in
                print(error.debugDescription)
            }
            
            filterMale = male
            filterFemale = female
            
            DispatchQueue.main.async {
                self.personasTable.reloadData()
            }
            
        } else {
            NetworkingProvider.shared.getListFemale() { (user) in
                self.myUsers = user
                DispatchQueue.main.async {
                    self.personasTable.reloadData()
                }
                
            } failure: { (error) in
                print(error.debugDescription)
            }
            
            filterMale = male
            filterFemale = female
            
            DispatchQueue.main.async {
                self.personasTable.reloadData()
            }
        }
    }
    
    
}
