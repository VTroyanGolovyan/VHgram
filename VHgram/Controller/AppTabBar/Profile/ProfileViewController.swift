//
//  ProfileViewController.swift
//  VHgram
//
//  Created by Владислав on 22.04.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var model = ProfileModel(uid: AuthModel.GetInstance().uid ?? 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.profileDelegate = self
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.backgroundColor = UIColor.darkGray
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    override func viewWillAppear(_ animated: Bool) {
        fillData(name: model.getName(), avatar: model.getAvatar())
    }
    
    func fillData(name: String, avatar: String) {
        self.name.text = name
        NetworkLayer.loadImage(relativePath: avatar, img: self.avatar)
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
