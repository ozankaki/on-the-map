//
//  GenericNetwork.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import Foundation

class BaseClient: Loadable {
    
    func trimUdacityResponse(_ data: Data) -> Data {
        let range = 5..<data.count
        let newData = data.subdata(in: range)
        return newData
    }
    
    func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(
        url: URL, responseType: ResponseType.Type, body: RequestType,
        completion: @escaping (ResponseType?, Error?) -> Void) {
        startLoading()
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do {
            let json = try JSONEncoder().encode(body)
            request.httpBody = json
        } catch {
            DispatchQueue.main.async {
                self.stopLoading()
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
            let newData = self.trimUdacityResponse(data)
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: newData)
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: newData) as Error
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }

    func taskForGETRequest<ResponseType: Decodable>(
        url: URL, responseType: ResponseType.Type,
        completion: @escaping (ResponseType?, Error?) -> Void) {
        self.startLoading()
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    self.stopLoading()
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.stopLoading()
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
}
