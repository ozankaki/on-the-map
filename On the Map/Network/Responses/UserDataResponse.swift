//
//  UserDataResponse.swift
//  On the Map
//
//  Created by Ozan Kaki on 10.04.2021.
//

import Foundation

struct UserDataResponse: Codable {

    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
