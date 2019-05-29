//
//  PlantsTableViewController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PlantsTableViewController: UITableViewController {
    
    // MARK: - Properties
    let plantController = PlantController()
    var isCellSegue: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        plantController.fetchPlants { (error) in
//            if let error = error {
//                NSLog("Error creating plant: \(error)")
//                return
//            }
//
//            self.tableView.reloadData()
//        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantController.plants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath)

        let plant = plantController.plants[indexPath.row]
        cell.textLabel?.text = plant.name
        cell.detailTextLabel?.text = plant.species

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let plant = plantController.plants[indexPath.row]
            plantController.deletePlant(with: plant) { (error) in
                if let error = error {
                    NSLog("Error creating plant: \(error)")
                    return
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? PlantDetailViewController else { return }
        detailVC.plantController = plantController
        
        if segue.identifier == "CellSegue" {
            guard let index = tableView.indexPathForSelectedRow else { return }
            detailVC.plant = plantController.plants[index.row]
            isCellSegue = true
            detailVC.isCellSegue = isCellSegue
        }
    }

}
