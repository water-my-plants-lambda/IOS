//
//  APIController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

// MARK: -  Enum
enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

class APIController {
    
    // MARK: - Properties
    private let baseURL = URL(string: "https://water-my-plants-be.herokuapp.com")!
    var bearer: Bearer!
    
    // MARK: - Authentication
    func signUp(with user: User, completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("api").appendingPathComponent("register")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            NSLog("Error encoding User: \(error)")
            completion(error)
            return
        }
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 {
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
        let requestURL = baseURL.appendingPathComponent("api").appendingPathComponent("login")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(user)
        } catch {
            NSLog("Error encoding User: \(error)")
            completion(error)
            return
        }
        print(user)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            if let error = error {
                NSLog("Error signing in: \(error)")
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
    
    // MARK: - User Profile CRUD
    func getUser(forId id: Int, completion: @escaping (User?, Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("api").appendingPathComponent("users").appendingPathComponent("\(id)")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            do {
                if let data = data {
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(user, nil)
                }
            } catch {
                NSLog("Errordecoding data: \(error)")
                completion(nil, error)
            }
            }.resume()
    }
    
    func updateProfile(with user: User, completion: @escaping (Error?) -> Void) {
        let requestURL = baseURL.appendingPathComponent("api").appendingPathComponent("users").appendingPathComponent("\(bearer.id)")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
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
                NSLog("Error updating user: \(error)")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    }
}
