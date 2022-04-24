//
//  SettingsViewController.swift
//  VHgram
//
//  Created by Владислав on 22.04.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    var delegate: AppTabBarViewControllerDelegate?
    
    @IBAction func signOut(_ sender: Any) {
        AuthModel.signOut()
        delegate?.switchSignInController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
    }

}
