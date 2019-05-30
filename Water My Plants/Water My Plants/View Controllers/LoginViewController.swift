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
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var loginType = LoginType.signUp
    var apiController: APIController?
    
    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    // MARK: - Actions
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let apiController = apiController else { return }
        if let username = usernameTextField.text,
            !username.isEmpty,
            let password = passwordTextField.text,
            !password.isEmpty,
            let phone = phoneTextField.text,
            let email = emailTextField.text {
            let user = User(username: username, password: password, phone: phone, email: email)
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
                        NSLog("Error logging in: \(error)")
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
            phoneTextField.isHidden = false
            emailTextField.isHidden = false
        } else if sender.selectedSegmentIndex == 1 {
            loginType = .signIn
            phoneTextField.isHidden = true
            emailTextField.isHidden = true
            signUpButton.setTitle("Sign In", for: .normal)
        }
    }
    
    func setTheme() {
        view.backgroundColor = ThemeHelper.lightBlue
        loginSegmentedControl.backgroundColor = ThemeHelper.lightGreen
        loginSegmentedControl.tintColor = ThemeHelper.lightBeige
        loginSegmentedControl.setTitleTextAttributes(ThemeHelper.textAttributes as [NSAttributedString.Key : Any], for: .normal)
        usernameTextField.textColor = ThemeHelper.darkGreen
        usernameTextField.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 18)
        passwordTextField.textColor = ThemeHelper.darkGreen
        passwordTextField.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 18)
        phoneTextField.textColor = ThemeHelper.darkGreen
        phoneTextField.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 18)
        emailTextField.textColor = ThemeHelper.darkGreen
        emailTextField.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 18)
        signUpButton.setTitleColor(ThemeHelper.darkGreen, for: .normal)
        signUpButton.titleLabel?.font = ThemeHelper.badScriptFont(with: .largeTitle, pointSize: 30)
        imageView.image = UIImage(named: "Login")
        logoImageView.image = UIImage(named: "App Logo")
    }
}
