//
//  LoginRequest.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import Foundation

struct LoginRequest: Codable {

    let udacity: Udacity
}

struct Udacity: Codable {
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case password
    }
}
