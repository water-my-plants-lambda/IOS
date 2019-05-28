//
//  PlantDetailViewController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class PlantDetailViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    var plantController: PlantController?
    var plant: Plant?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: -  Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
    }
}
