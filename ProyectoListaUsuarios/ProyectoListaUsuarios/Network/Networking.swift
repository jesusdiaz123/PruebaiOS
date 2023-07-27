//
//  Networking.swift
//  ProyectoListaUsuarios
//
//  Created by Jesus Alberto Diaz de Leon on 21/07/23.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    //MARK: -Constantes
    static let shared = NetworkingProvider()
    private let kBaseUrl = "https://randomuser.me/api/?"
    private let kStatusOk = 200...299
    
    //MARK: -getList
    
    //Funcion para hacer el llamado a la lista de 50 personas random
    func getList(success: @escaping (_ user: [Result]) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
       let url = "\(kBaseUrl)results=50"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self) { response in
            
            if let user = response.value?.results {
                success(user)
                print(user)
            } else {
                print(response.error?.responseCode ?? "No error")
                failure(response.error)
            }
            
            
        }
    }
    
    //MARK: -getListaMale
    
    //Funcion para hacer el llamado a la lista de 50 personas random con el filtro masculino
    func getListMale(success: @escaping (_ user: [Result]) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = "\(kBaseUrl)results=50&gender=male"
         
         AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self) { response in
             
             if let user = response.value?.results {
                 success(user)
                 print(user)
             } else {
                 print(response.error?.responseCode ?? "No error")
                 failure(response.error)
             }
             
             
         }
     }
    
    //MARK: -getListFamale
    
    //Funcion para hacer el llamado a la lista de 50 personas random con el filtro femenino
    func getListFemale(success: @escaping (_ user: [Result]) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = "\(kBaseUrl)results=50&gender=female"
         
         AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self) { response in
             
             if let user = response.value?.results {
                 success(user)
                 print(user)
             } else {
                 print(response.error?.responseCode ?? "No error")
                 failure(response.error)
             }
             
             
         }
     }
}

