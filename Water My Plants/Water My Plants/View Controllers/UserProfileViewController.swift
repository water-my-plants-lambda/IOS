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
    
    var user: User?

    // MARK: - View Loading
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = user?.username
        phoneLabel.text = user?.phoneNumber
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

}
