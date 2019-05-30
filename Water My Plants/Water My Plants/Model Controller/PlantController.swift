//
//  PlantController.swift
//  Water My Plants
//
//  Created by Lisa Sampson on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class PlantController {
    
    // MARK: - Properties
    var plants: [Plant] = []
    var plant: Plant?
    var bearer: Bearer?
//    private let baseURL = URL(string: "https://water-my-plants-be.herokuapp.com")!
    
    // MARK: - Initializers
    
    init() {
        loadFromPersistence()
    }
  
    // MARK: - Networking
//    func fetchPlants(completion: @escaping (Error?) -> Void) {
//        guard let bearer = bearer else {
//            NSLog("No token available")
//            completion(NSError())
//            return
//        }
//        let requestURL = baseURL
//            .appendingPathComponent("api/users/\(plant!.userId)/plants")
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.get.rawValue
//        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let response = response as? HTTPURLResponse,
//            response.statusCode == 401 {
//                completion(NSError())
//                return
//            }
//            if let error = error {
//                NSLog("Error getting plant details: \(error)")
//                completion(NSError())
//                return
//            }
//            guard let data = data else {
//                completion(NSError())
//                return
//            }
//            let decoder = JSONDecoder()
//            do {
//                self.plants = try decoder.decode([Plant].self, from: data)
//                completion(nil)
//            } catch {
//                NSLog("Error decoding plant details: \(error)")
//                completion(NSError())
//            }
//        }.resume()
//    }
//    
//    func createPlant(with plant: Plant, completion: @escaping (Error?) -> Void) {
//        guard let bearer = bearer else {
//            NSLog("No token available")
//            completion(NSError())
//            return
//        }
//        let requestURL = baseURL.appendingPathComponent("api")
//            .appendingPathComponent("users")
//            .appendingPathComponent("\(plant.userId)")
//            .appendingPathComponent("plants")
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
//        do {
//            let encoder = JSONEncoder()
//            request.httpBody = try encoder.encode(plant)
//        } catch {
//            completion(error)
//            return
//        }
//        URLSession.shared.dataTask(with: request) { _, response, error in
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
//                return
//            }
//            if let error = error {
//                completion(error)
//                return
//            }
//            self.plants.append(plant)
//            self.saveToPersistence()
//        }.resume()
//    }
//    
//    func updatePlant(with plant: Plant, completion: @escaping (Error?) -> Void) {
//        guard let bearer = bearer else {
//            NSLog("No bearer token available")
//            completion(NSError())
//            return
//        }
//        
//        let requestURL = baseURL
//            .appendingPathComponent("blah")
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
//        do {
//            let encoder = JSONEncoder()
//            request.httpBody = try encoder.encode(plant)
//        } catch {
//            completion(error)
//            return
//        }
//        URLSession.shared.dataTask(with: request) { _, response, error in
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
//                return
//            }
//            if let error = error {
//                completion(error)
//                return
//            }
//            guard let index = self.plants.firstIndex(of: plant) else { return }
//            
//            var scratch = self.plants[index]
//            scratch.name = plant.name
//            scratch.description = plant.description
//            scratch.times = plant.times
//            
//            self.plants.remove(at: index)
//            self.plants.insert(scratch, at: index)
//            self.saveToPersistence()
//            }.resume()
//    }
//    
//    func deletePlant(with plant: Plant, completion: @escaping (Error?) -> Void) {
//        guard let bearer = bearer else {
//            NSLog("No bearer token available")
//            completion(NSError())
//            return
//        }
//        let requestURL = baseURL
//            .appendingPathComponent("blah")
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = HTTPMethod.delete.rawValue
//        request.addValue("Bearer \(bearer.token)", forHTTPHeaderField: "Authorization")
//        do {
//            let encoder = JSONEncoder()
//            request.httpBody = try encoder.encode(plant)
//        } catch {
//            completion(error)
//            return
//        }
//        URLSession.shared.dataTask(with: request) { _, response, error in
//            if let response = response as? HTTPURLResponse,
//                response.statusCode != 200 {
//                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
//                return
//            }
//            if let error = error {
//                completion(error)
//                return
//            }
//            guard let index = self.plants.firstIndex(of: plant) else {
//                NSLog("Error finding plant")
//                completion(NSError())
//                return
//            }
//            self.plants.remove(at: index)
//            self.saveToPersistence()
//        }.resume()
//    }
//    
//    // MARK: - Enum
//    enum HTTPMethod: String {
//        case get = "GET"
//        case put = "PUT"
//        case post = "POST"
//        case delete = "DELETE"
//    }
}
