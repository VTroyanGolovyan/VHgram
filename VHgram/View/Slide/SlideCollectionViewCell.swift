//
//  SlideCollectionViewCell.swift
//  VHgram
//
//  Created by Владислав on 10.04.2022.
//

import UIKit

class SlideCollectionViewCell: UICollectionViewCell {
    static let reuseId = "SlideCollectionViewCell"
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func signIn(_ sender: UIButton) {
        let login = self.email.text
        let password = self.password.text
        AuthModel.labelDelegate = label
        if (login != nil && password != nil) {
            AuthModel.loginDelegate = delegate
            AuthModel.signIn(login: login!, password: password!)
        }
    }
    
    var delegate: LoginViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        email.attributedPlaceholder = makeAttributedPlaceholder(text: "Email")
        password.attributedPlaceholder = makeAttributedPlaceholder(text: "Password")
    }

}
