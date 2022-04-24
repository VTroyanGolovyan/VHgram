//
//  SignUpCollectionViewCell.swift
//  VHgram
//
//  Created by Владислав on 22.04.2022.
//

import UIKit

class SignUpCollectionViewCell: UICollectionViewCell {

    static let reuseId = "SignUpCollectionViewCell"
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var verdict: UILabel!
    @IBOutlet weak var checkPassword: UITextField!
    
    @IBAction func SignUpNtnAct(_ sender: Any) {
        AuthModel.regLabelDelegate = verdict
        
        AuthModel.signUp(name: name.text!, lastName: lastName.text!, login: email.text!, password: password.text!, checkPassword: checkPassword.text!)
    }
    
    @IBOutlet weak var sugnUpBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        name.attributedPlaceholder = NSAttributedString(string: "Name",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        lastName.attributedPlaceholder = NSAttributedString(string: "Last name",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        email.attributedPlaceholder = NSAttributedString(string: "Email",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        checkPassword.attributedPlaceholder = NSAttributedString(string: "Confirm password",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        
        
    }

}
