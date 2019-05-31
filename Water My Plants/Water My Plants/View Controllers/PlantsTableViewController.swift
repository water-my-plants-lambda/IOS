//
//  PlantsTableViewController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PlantsTableViewController: UITableViewController, UserProfileViewControllerDelegate {
    
    // MARK: - Properties
    let plantController = PlantController()
    var isCellSegue: Bool = false
    let apiController = APIController()
    var currentUser: User?
    
    // MARK: - View Loading
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if apiController.bearer == nil {
            performSegue(withIdentifier: "LoginSegue", sender: self)
        } else {
            plantController.bearer = apiController.bearer
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Delegate Method
    func didSaveUser(user: User) {
        currentUser = user
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plantController.plants.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell", for: indexPath)
        
        let plant = plantController.plants[indexPath.row]
        tableView.backgroundColor = ThemeHelper.lightBlue
        cell.backgroundColor = ThemeHelper.darkBeige
        cell.textLabel?.text = plant.name
        cell.textLabel?.textColor = ThemeHelper.darkGreen
        cell.textLabel?.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 20)
        cell.detailTextLabel?.text = plant.description
        cell.detailTextLabel?.textColor = ThemeHelper.darkGreen
        cell.detailTextLabel?.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 15)
        cell.imageView?.image = UIImage(named: "plants")
        cell.imageView?.tintColor = ThemeHelper.darkBeige
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let plant = plantController.plants[indexPath.row]
            plantController.deletePlant(with: plant)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CellSegue" {
            guard let detailVC = segue.destination as? PlantDetailViewController else { return }
            detailVC.plantController = plantController
            guard let index = tableView.indexPathForSelectedRow else { return }
            detailVC.plant = plantController.plants[index.row]
            isCellSegue = true
            detailVC.isCellSegue = isCellSegue
        } else if segue.identifier == "AddSegue" {
            guard let detailVC = segue.destination as? PlantDetailViewController else { return }
            detailVC.plantController = plantController
        } else if segue.identifier == "LoginSegue" {
            guard let loginVC = segue.destination as? LoginViewController else { return }
            loginVC.apiController = apiController
            loginVC.tableView = self
        } else if segue.identifier == "ProfileSegue" {
            guard let navVC = segue.destination as? UINavigationController else { return }
            guard let profileVC = navVC.viewControllers.first as? UserProfileViewController else { return }
            profileVC.tableView = self
            profileVC.apiController = apiController
            profileVC.delegate = self
        }
    }
}
