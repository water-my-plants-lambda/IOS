//
//  APIController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class APIController {
    private let baseURL = URL(string: "https://water-my-plants.firebaseio.com/")!
    
    var bearer: Bearer?
    
    func signUp(with user: User, completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("blah/blah")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("blah/blah", forHTTPHeaderField: "Blah-blah")
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            NSLog("Error encoding User: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
           if let response = response as? HTTPURLResponse,
            response.statusCode != 200 {
            completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
            return
            }
            if let error = error {
                NSLog("Error signing up: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    func signIn(with user: User, completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("blah/blah")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("blah/blah", forHTTPHeaderField: "Blah-blah")
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            NSLog("Error encoding User: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            if let error = error {
                NSLog("Error signing up: \(error)")
                completion(error)
                return
            }
            guard let data = data else {
                NSLog("No data returned from task")
                completion(NSError())
                return
            }
            do {
                self.bearer = try JSONDecoder().decode(Bearer.self, from: data)
                completion(nil)
            } catch {
                NSLog("Error decoding Bearer: \(error)")
                completion(error)
                return
            }
        }.resume()
    }
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
}
