//
//  DialogTableViewCell.swift
//  VHgram
//
//  Created by Владислав on 24.04.2022.
//

import UIKit

class DialogTableViewCell: RoundedCellWithShadow {

    static let reuseId = "DialogTableViewCell"
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    var userAvatarURL: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fillCell(data: [String:String]) {
        message.text = data["message"]
        userName.text = data["sender"]
        date.text = data["send_time"]
        userAvatarURL = data["avatar"]
        self.userAvatar.image = UIImage(named: "profile-user")
        NetworkLayer.loadImage(relativePath: userAvatarURL ?? "", img: self.userAvatar)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.userAvatar.layer.cornerRadius = self.userAvatar.frame.size.width / 2
        self.userAvatar.layer.masksToBounds = true
    }
    
}
