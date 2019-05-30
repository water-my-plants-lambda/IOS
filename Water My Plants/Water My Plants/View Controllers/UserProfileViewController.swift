//
//  UserProfileViewController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var user: User?

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        usernameLabel.text = "Username: mitchell"
        phoneLabel.text = "Phone number: 1(800)787-9233"
    }
    
    // MARK: - Actions
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editVC = segue.destination as? EditProfileViewController else { return }
        editVC.user = user
    }
    
    func setTheme() {
        view.backgroundColor = ThemeHelper.lightBlue
        usernameLabel.textColor = ThemeHelper.darkGreen
        usernameLabel.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 22)
        phoneLabel.textColor = ThemeHelper.darkGreen
        phoneLabel.font = ThemeHelper.badScriptFont(with: .callout, pointSize: 22)
        imageView.image = UIImage(named: "Profile")
    }
}
