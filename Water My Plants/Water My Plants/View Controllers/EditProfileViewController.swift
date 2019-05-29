//
//  EditProfileViewController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    @IBOutlet weak var newUsernameTextField: UITextField!
    @IBOutlet weak var newPhoneTextField: UITextField!
    
    var user: User?
    var apiController: APIController?
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let newUsername = newUsernameTextField.text,
            !newUsername.isEmpty,
            let newPhone = newPhoneTextField.text,
            !newPhone.isEmpty else { return }
        
        guard var updatedUser = user else { return }
        updatedUser.username = newUsername
        updatedUser.phone = newPhone
        
        apiController?.updateProfile(with: updatedUser, completion: { (error) in
            if let error = error {
                NSLog("Error creating plant: \(error)")
                return
            }
        })
        
        navigationController?.popToRootViewController(animated: true)
    }
}
