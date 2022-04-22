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
        self.navigationController?.navigationBar.backgroundColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
