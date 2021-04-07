//
//  LoginResponse.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import Foundation

struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct Session: Codable {
    let sessionId: String
    let expiration: String
    
    enum CodingKeys: String, CodingKey {
        case sessionId = "id"
        case expiration
    }
}

struct Account: Codable {
    let registered: Bool
    let key: String
}
