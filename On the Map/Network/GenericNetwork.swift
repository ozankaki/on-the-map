//
//  GenericNetwork.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import Foundation

class BaseClient {
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(
        url: URL, responseType: ResponseType.Type, body: RequestType,
        completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let json = try JSONEncoder().encode(body)
            request.httpBody = json
        } catch {
            DispatchQueue.main.async {
                completion(nil, error)
            }
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // TODO: use response for _
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let range = 5..<data.count
                let newData = data.subdata(in: range)
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
//                do {
//                    let errorResponse = try decoder.decode(ResponseType.Type, from: data) as Error
//                    DispatchQueue.main.async {
//                        completion(nil, errorResponse)
//                    }
//                } catch {
//                    DispatchQueue.main.async {
//                        completion(nil, error)
//                    }
//                }
            }
        }
        task.resume()
    }

}
