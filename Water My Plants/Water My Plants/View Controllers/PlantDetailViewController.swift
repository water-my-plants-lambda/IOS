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
    var isCellSegue: Bool = false
    let localNotifHelper = LocalNotificationHelper()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var speciesTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        updateViews()
    }
    
    func updateViews() {
        if isCellSegue {
            saveButton.title = "Update"
            self.title = plant?.name
//            datePicker.isHidden = false
            
            nameTextField.text = plant?.name
            speciesTextField.text = plant?.description
            datePicker.date = plant!.times
        } else {
            self.title = "New Plant"
//            datePicker.isHidden = true
        }
    }

    // MARK: -  Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text,
            !name.isEmpty,
            let description = speciesTextField.text,
            !description.isEmpty else { return }
        let times = datePicker.date
        
        if isCellSegue {
            guard let plant = plant else { return }
            plantController?.updatePlant(with: plant, name: name, description: description, times: times)
        } else {
            plantController?.createPlant(with: name, description: description, times: times)
        }
        
        localNotifHelper.requestAuthorizationStatus { success in
            if success == true {
                self.localNotifHelper.scheduleDailyReminderNotification(name: name, times: times, calendar: Calendar.current)
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    func setTheme() {
        view.backgroundColor = ThemeHelper.lightBlue
        nameTextField.textColor = ThemeHelper.darkGreen
        nameTextField.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 18)
        speciesTextField.textColor = ThemeHelper.darkGreen
        speciesTextField.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 18)
        imageView.image = UIImage(named: "Plant Detail")
    }
}
