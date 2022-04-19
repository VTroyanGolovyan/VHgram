//
//  SlideCollectionViewCell.swift
//  VHgram
//
//  Created by Владислав on 10.04.2022.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    static let reuseId = "SlideCollectionViewCell"
    
    var delegate: LoginViewControllerDelegate?
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func signIn(_ sender: UIButton) {
        var login = self.email.text
        var password = self.password.text
        print(login, password)
        delegate?.switchAppController()
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
