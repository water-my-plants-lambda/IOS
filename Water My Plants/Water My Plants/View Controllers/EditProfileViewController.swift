//
//  EditProfileViewController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

protocol EditProfileViewControllerDelegate: class {
    func didUpdateUser(user: User)
}

class EditProfileViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    @IBOutlet weak var newUsernameTextField: UITextField!
    @IBOutlet weak var newPhoneTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var user: User?
    var apiController: APIController?
    weak var delegate: EditProfileViewControllerDelegate?
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
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
                NSLog("Error updating: \(error)")
                return
            }
        })
        delegate?.didUpdateUser(user: updatedUser)
        navigationController?.popToRootViewController(animated: true)
    }
    
        func setTheme() {
            view.backgroundColor = ThemeHelper.lightBlue
            newUsernameTextField.textColor = ThemeHelper.darkGreen
            newUsernameTextField.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 18)
            newPhoneTextField.textColor = ThemeHelper.darkGreen
            newPhoneTextField.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 18)
            imageView.image = UIImage(named: "Edit Profile")
        }
}
