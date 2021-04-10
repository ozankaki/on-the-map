//
//  StudentLocation.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import Foundation

class StudentLocation: Codable {
    var firstName: String?
    var lastName: String?
    var longitude: Double?
    var latitude: Double?
    var mapString: String?
    var mediaURL: String?
    var uniqueKey: String?
    var objectId: String?
    var createdAt: String?
    var updatedAt: String?
    
    init() {
        
    }
}
