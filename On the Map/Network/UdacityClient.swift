//
//  UdacityClient.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import UIKit

class UdacityClient: BaseClient {
    
    struct Auth {
        static var key = ""
        static var sessionId = ""
    }

    enum Endpoints {
        static let base = "https://onthemap-api.udacity.com/v1"

        case login

        var path: String {
            switch self {
            case .login: return Endpoints.base + "/session"
            }
        }

        var url: URL {
            return URL(string: path)!
        }
    }
    
    class func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let udacity = Udacity(username: username, password: password)
        let body = LoginRequest(udacity: udacity)
        super.taskForPOSTRequest(url: Endpoints.login.url,
                                          responseType: LoginResponse.self, body: body) { response, error in
            if let response = response {
                Auth.key = response.account.key
                Auth.sessionId = response.session.sessionId
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }

}
