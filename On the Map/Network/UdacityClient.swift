//
//  UdacityClient.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import UIKit

class UdacityClient: BaseClient {
    
    static var studentLocations = [StudentLocation]()
    
    struct Auth {
        static var key = ""
        static var sessionId = ""
        static var firstName = ""
        static var lastName = ""
        static var objectId = ""
    }

    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"

        case signUp
        case login
        case getStudentLocations
        case getUserData
        case addStudentLocation

        var path: String {
            switch self {
            case .signUp: return "https://auth.udacity.com/sign-up"
            case .login: return Endpoints.base + "/session"
            case .getStudentLocations: return Endpoints.base + "/StudentLocation"
            case .getUserData: return Endpoints.base + "/users/" + Auth.key
            case .addStudentLocation: return Endpoints.base + "/StudentLocation"
            }
        }

        var url: URL {
            return URL(string: path)!
        }
    }
    
    func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let udacity = Udacity(username: username, password: password)
        let body = LoginRequest(udacity: udacity)
        super.taskForPOSTRequest(url: Endpoints.login.url,
                                          responseType: LoginResponse.self, body: body) { response, error in
            if let response = response {
                Auth.key = response.account.key
                Auth.sessionId = response.session.sessionId
                UdacityClient().getUserData()
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }

    func getStudentLocations(completion: @escaping (Bool, Error?) -> Void) {
        super.taskForGETRequest(url: Endpoints.getStudentLocations.url,
                                responseType: StudentLocationsResponse.self) { response, error in
            if let response = response {
                UdacityClient.studentLocations = response.results
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    func getUserData() {
        super.taskForGETRequest(url: Endpoints.getUserData.url,
                                responseType: UserDataResponse.self) { response, _ in
            if let response = response {
                Auth.firstName = response.firstName
                Auth.lastName = response.lastName
            }
        }
    }
    
    func addStudentLocation(studentLocation: StudentLocation, completion: @escaping (Bool, Error?) -> Void) {
        super.taskForPOSTRequest(url: Endpoints.addStudentLocation.url,
                                          responseType: AddLocationResponse.self,
                                          body: studentLocation) { response, error in
            if let response = response {
                Auth.objectId = response.objectId ?? ""
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}
