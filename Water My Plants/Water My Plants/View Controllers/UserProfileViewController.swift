//
//  UserProfileViewController.swift
//  Water My Plants
//
//  Created by Mitchell Budge on 5/28/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

protocol UserProfileViewControllerDelegate: class {
    func didSaveUser(user: User)
}

class UserProfileViewController: UIViewController, EditProfileViewControllerDelegate {

    // MARK: - Properties and Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var user: User?
    var tableView: PlantsTableViewController?
    var apiController: APIController?
    weak var delegate: UserProfileViewControllerDelegate?

    // MARK: - View Loading
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setTheme()
        self.user = tableView?.currentUser
        usernameLabel.text = user?.username
        phoneLabel.text = user?.phone
    }
    
    func didSaveUser(user: User) {
        usernameLabel.text = user.username
        phoneLabel.text = user.phone
    }
    
    // MARK: - Actions
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editVC = segue.destination as? EditProfileViewController else { return }
        editVC.user = user
        editVC.apiController = apiController
        editVC.delegate = self
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
