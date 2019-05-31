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
    
    // MARK: - Initializers
    init() {
        loadFromPersistence()
    }
    
    // MARK: - CRUD
    func createPlant(with name: String, description: String, times: Date) {
        let plant = Plant(name: name, description: description, times: times)
        plants.append(plant)
        saveToPersistence()
    }
    
    func updatePlant(with plant: Plant, name: String, description: String, times: Date) {
        guard let index = plants.firstIndex(of: plant) else { return }
        var scratch = plants[index]
        scratch.name = name
        scratch.description = description
        scratch.times = times
        
        plants.remove(at: index)
        plants.insert(scratch, at: index)
        saveToPersistence()
    }
    
    func deletePlant(with plant: Plant) {
        guard let index = plants.firstIndex(of: plant) else { return }
        plants.remove(at: index)
        saveToPersistence()
    }
}
