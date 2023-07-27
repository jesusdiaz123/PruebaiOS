//
//  User.swift
//  ProyectoListaUsuarios
//
//  Created by Jesus Alberto Diaz de Leon on 21/07/23.
//

import Foundation

/*
 "results":[
       {
          "gender":"female",
          "name":{
             "title":"Ms",
             "first":"Slađana",
             "last":"Spasić"
          },
          "location":{
             "street":{
                "number":9764,
                "name":"Danice Aćimac"
             },
             "city":"Žagubica",
             "state":"North Bačka",
             "country":"Serbia",
             "postcode":23997,
             "coordinates":{
                "latitude":"63.2299",
                "longitude":"105.0743"
             },
             "timezone":{
                "offset":"-3:30",
                "description":"Newfoundland"
             }
          },
          "email":"sladana.spasic@example.com",
          "login":{
             "uuid":"cbe5f2f6-26b1-4bfd-bdc7-7b712339c3e7",
             "username":"heavykoala765",
             "password":"salmon",
             "salt":"AThT72R1",
             "md5":"c70ef22ef477e7d2282555b4bc6da8b8",
             "sha1":"de04654f51dde9c29edf5d635844b41e00c54f07",
             "sha256":"64720747d6a91f8dfa18e12174c9b927fcea36ce2262413e0e9ff7e539e458f2"
          },
          "dob":{
             "date":"1970-09-17T13:57:53.325Z",
             "age":52
          },
          "registered":{
             "date":"2004-03-05T15:41:52.302Z",
             "age":19
          },
          "phone":"012-6729-447",
          "cell":"060-0603-489",
          "id":{
             "name":"SID",
             "value":"267134491"
          },
          "picture":{
             "large":"https://randomuser.me/api/portraits/women/14.jpg",
             "medium":"https://randomuser.me/api/portraits/med/women/14.jpg",
             "thumbnail":"https://randomuser.me/api/portraits/thumb/women/14.jpg"
          },
          "nat":"RS"
       }]
 */

// MARK: - Welcome
struct UserResponse: Codable {
    let results: [Result]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct Result: Codable {
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let login: Login
    let dob, registered: Dob
    let phone, cell: String
    let id: ID
    let picture: Picture
    let nat: String
}

// MARK: - Dob
struct Dob: Codable {
    let date: String
    let age: Int
}

// MARK: - ID
struct ID: Codable {
    let name: String
    let value: String?
}

// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state, country: String
    let postcode: Postcode
    let coordinates: Coordinates
    let timezone: Timezone
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String
}

enum Postcode: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Postcode.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Postcode"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, description: String
}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String
    let md5, sha1, sha256: String
}

// MARK: - Name
struct Name: Codable {
    let title: String
    let first, last: String
}

enum Title: String, Codable {
    case madame = "Madame"
    case miss = "Miss"
    case mr = "Mr"
    case mrs = "Mrs"
    case ms = "Ms"
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}
