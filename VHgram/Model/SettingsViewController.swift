//
//  SettingsViewController.swift
//  VHgram
//
//  Created by Владислав on 22.04.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    var delegate: AppTabBarViewControllerDelegate?
    
    @IBOutlet weak var btn: UIButton!
    @IBAction func signOut(_ sender: Any) {
        AuthModel.signOut()
        delegate?.switchSignInController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = TabsSettings.settingsTabName
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        btn.layer.cornerRadius = CGFloat(CustomSettings.cornerRadius)
        btn.layer.masksToBounds = true
    }

}
