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
    
    var model: ProfileModel = ProfileModel(uid: AuthModel.GetInstance().uid ?? 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.profileDelegate = self
        self.navigationItem.title = TabsSettings.profileTabName
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        model.refetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        fillData(name: model.getName(), avatar: model.getAvatar())
    }
    
    func fillData(name: String, avatar: String) {
        self.name.text = name
        NetworkLayer.loadImage(relativePath: avatar, img: self.avatar)
    }

}
