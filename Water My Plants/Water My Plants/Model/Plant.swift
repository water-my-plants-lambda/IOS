//
//  Plant.swift
//  Water My Plants
//
//  Created by Lisa Sampson on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

struct Plant: Codable, Equatable {
    var name: String
    var id: Int
    var userId: Int
    var description: String
    var lastWater: Date
}
