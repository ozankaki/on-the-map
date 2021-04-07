//
//  ErrorResponse.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import Foundation

struct ErrorResponse: Codable {
    let errorCode: Int
    let errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "status"
        case errorMessage = "error"
    }
}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        return errorMessage
    }
}
