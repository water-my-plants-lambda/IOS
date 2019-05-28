//
//  LoginViewController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

// Enum
enum LoginType {
    case signUp
    case signIn
}

class LoginViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var loginType = LoginType.signUp
    var apiController: APIController?
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 8
    }
    
    // MARK: - Actions
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let apiController = apiController else { return }
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let phoneNumber = phoneTextField.text,
            !phoneNumber.isEmpty {
            let user = User(username: username, password: password, phoneNumber: phoneNumber)
            switch loginType {
            case .signUp:
                apiController.signUp(with: user) { (error) in
                    if let error = error {
                        NSLog("Error signing up: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            let alert = UIAlertController(title: "Sign Up Successful", message: "Please log in.", preferredStyle: .alert)
                            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(alertAction)
                            self.present(alert, animated: true, completion: {
                                self.loginType = .signIn
                                self.loginSegmentedControl.selectedSegmentIndex = 1
                                self.signUpButton.setTitle("Sign In", for: .normal)
                            })
                        }
                    }
                }
            case .signIn:
                apiController.signIn(with: user) { (error) in
                    if let error = error {
                        NSLog("Error loggin in: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signUp
            signUpButton.setTitle("Sign Up", for: .normal)
        } else {
            loginType = .signIn
            signUpButton.setTitle("Sign In", for: .normal)
        }
    }
}
